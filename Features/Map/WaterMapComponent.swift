#if canImport(GoogleMaps)
import SwiftUI
import GoogleMaps
import CoreLocation

struct WaterMapComponent: UIViewRepresentable {
    var waterSources: [MapWaterSource]
    @Binding var selectedSource: MapWaterSource?
    var showFlowArrows: Bool = true
    var showMarkers: Bool = true
    
    func makeUIView(context: Context) -> GMSMapView {
        // Initialize focused on Rwanda
        let camera = GMSCameraPosition.camera(
            withLatitude: WaterMapData.rwandaCenter.latitude,
            longitude: WaterMapData.rwandaCenter.longitude,
            zoom: 9.0
        )
        
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        mapView.delegate = context.coordinator
        
        // Custom Dark Mode Style
        if let styleURL = Bundle.main.url(forResource: "map_style", withExtension: "json") {
            mapView.mapStyle = try? GMSMapStyle(contentsOfFileURL: styleURL)
        }
        
        return mapView
    }
    
    func updateUIView(_ mapView: GMSMapView, context: Context) {
        mapView.clear()
        
        for source in waterSources {
            // Draw path/polyline for rivers, canals, etc.
            if source.path.count > 1 {
                let path = GMSMutablePath()
                for coordinate in source.path {
                    path.add(coordinate)
                }
                
                let polyline = GMSPolyline(path: path)
                polyline.strokeColor = UIColor(source.status.color)
                
                // Adjust stroke width based on flow rate (visual intensity)
                let baseWidth: CGFloat = 3.0
                let flowMultiplier = min(CGFloat(source.flowRate / 50.0), 3.0) // Cap at 3x
                polyline.strokeWidth = baseWidth + flowMultiplier
                polyline.map = mapView
                polyline.tappable = true
                polyline.userData = source
                
                // Add flow direction arrows
                if showFlowArrows && source.path.count >= 2 {
                    addFlowArrows(to: mapView, path: source.path, color: source.status.color)
                }
            }
            
            // Add markers for point sources (distribution points, pumps, etc.)
            if showMarkers, let firstCoord = source.path.first {
                let marker = GMSMarker(position: firstCoord)
                marker.title = source.name
                marker.snippet = "\(source.type.rawValue) • \(source.status.rawValue)"
                marker.icon = GMSMarker.markerImage(with: UIColor(source.status.color))
                marker.userData = source
                marker.map = mapView
            }
        }
    }
    
    private func addFlowArrows(to mapView: GMSMapView, path: [CLLocationCoordinate2D], color: Color) {
        // Add arrows along the path to show flow direction
        // For simplicity, add arrows at regular intervals
        guard path.count >= 2 else { return }
        let arrowInterval = max(path.count / 4, 1) // Add ~4 arrows per path
        
        for i in stride(from: 0, to: path.count - 1, by: arrowInterval) {
            let start = path[i]
            let end = path[min(i + 1, path.count - 1)]
            
            // Calculate bearing for arrow direction
            let bearing = calculateBearing(from: start, to: end)
            
            // Create a small marker as arrow indicator
            let arrowMarker = GMSMarker(position: end)
            arrowMarker.icon = createArrowIcon(color: UIColor(color), bearing: bearing)
            arrowMarker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
            arrowMarker.map = mapView
        }
    }
    
    private func calculateBearing(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D) -> Double {
        let lat1 = from.latitude * .pi / 180
        let lat2 = to.latitude * .pi / 180
        let dLon = (to.longitude - from.longitude) * .pi / 180
        
        let y = sin(dLon) * cos(lat2)
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon)
        
        let bearing = atan2(y, x) * 180 / .pi
        return (bearing + 360).truncatingRemainder(dividingBy: 360)
    }
    
    private func createArrowIcon(color: UIColor, bearing: Double) -> UIImage {
        let size = CGSize(width: 16, height: 16)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        defer { UIGraphicsEndImageContext() }
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return UIImage()
        }
        
        context.translateBy(x: size.width / 2, y: size.height / 2)
        context.rotate(by: CGFloat(bearing * .pi / 180))
        context.translateBy(x: -size.width / 2, y: -size.height / 2)
        
        // Draw simple arrow shape pointing right (will be rotated)
        let path = UIBezierPath()
        path.move(to: CGPoint(x: size.width * 0.8, y: size.height / 2))
        path.addLine(to: CGPoint(x: size.width * 0.2, y: size.height * 0.2))
        path.addLine(to: CGPoint(x: size.width * 0.2, y: size.height * 0.8))
        path.close()
        
        color.setFill()
        path.fill()
        
        return UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, GMSMapViewDelegate {
        var parent: WaterMapComponent
        
        init(_ parent: WaterMapComponent) {
            self.parent = parent
        }
        
        func mapView(_ mapView: GMSMapView, didTap overlay: GMSOverlay) {
            if let polyline = overlay as? GMSPolyline,
               let source = polyline.userData as? MapWaterSource {
                withAnimation {
                    parent.selectedSource = source
                }
            }
        }
        
        func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
            if let source = marker.userData as? MapWaterSource {
                withAnimation {
                    parent.selectedSource = source
                }
                return true
            }
            return false
        }
    }
}

#else
// Fallback placeholder when GoogleMaps is not available (e.g., CI without SDK)
import SwiftUI

struct WaterMapComponent: View {
    var waterSources: [MapWaterSource]
    @Binding var selectedSource: MapWaterSource?
    var showFlowArrows: Bool = true
    var showMarkers: Bool = true
    
    var body: some View {
        VStack {
            Text("Map unavailable: Google Maps SDK not present.")
                .foregroundColor(.textSecondary)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.cardDark)
    }
}
#endif

