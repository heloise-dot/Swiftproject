import SwiftUI
import UIKit
#if canImport(GoogleMaps)
import GoogleMaps
#endif
import CoreLocation

struct CustomerTabView: View {
    @EnvironmentObject var router: AppRouter
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            CustomerHomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(0)
            
            UsageOverviewView()
                .tabItem {
                    Label("Usage", systemImage: "chart.bar.fill")
                }
                .tag(1)
            
            NavigationStack {
                MapWaterFlowMapView()
                    .environmentObject(router)
            }
            .tabItem {
                Label("Map", systemImage: "map.fill")
            }
            .tag(2)
            
            NotificationsView()
                .tabItem {
                    Label("Notifications", systemImage: "bell.fill")
                }
                .tag(3)
            
            CustomerProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
                .tag(4)
        }
        .accentColor(.primaryBlue)
    }
}

#Preview {
    CustomerTabView()
        .environmentObject(AppRouter())
}

// MARK: - MAP COMPONENTS CONSOLIDATED
// Supporting views and components for WaterFlowMapView

struct MapViewSearchBar: View {
    @Binding var text: String
    var onSearch: () -> Void
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.textTertiary)
            
            TextField("Search rivers, canals...", text: $text)
                .foregroundColor(.textPrimary)
                .onSubmit(onSearch)
            
            if !text.isEmpty {
                Button(action: { text = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.textTertiary)
                }
            }
        }
        .padding()
        .background(Color.cardDark)
        .cornerRadius(.radiusLG)
        .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)
    }
}

struct MapWaterFlowLegend: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Flow Status")
                .font(.labelSmall)
                .fontWeight(.semibold)
                .foregroundColor(.textPrimary)
                .padding(.bottom, 4)
            
            ForEach(WaterFlowStatus.allCases, id: \.self) { status in
                HStack(spacing: 8) {
                    Circle()
                        .fill(status.color)
                        .frame(width: 10, height: 10)
                    
                    Text(status.rawValue)
                        .font(.caption)
                        .foregroundColor(.textSecondary)
                }
            }
        }
        .padding(12)
        .background(Color.cardDark.opacity(0.95))
        .cornerRadius(.radiusMD)
        .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
    }
}

struct MapWaterSourceDetailSheet: View {
    let waterSource: MapWaterSource
    var isAdmin: Bool
    var onClose: () -> Void
    var onEdit: (MapWaterSource) -> Void
    var onDelete: (MapWaterSource) -> Void
    
    var body: some View {
        NavigationStack {
            MapWaterSourceDetailView(waterSource: waterSource, onClose: onClose)
                .toolbar {
                    if isAdmin {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Menu {
                                Button(action: { onEdit(waterSource) }) {
                                    Label("Edit", systemImage: "pencil")
                                }
                                Button(role: .destructive, action: { onDelete(waterSource) }) {
                                    Label("Delete", systemImage: "trash")
                                }
                            } label: {
                                Image(systemName: "ellipsis.circle")
                            }
                        }
                    }
                }
        }
    }
}

struct MapAddWaterSourceSheet: View {
    var onSave: (MapWaterSource) -> Void
    var onCancel: () -> Void
    @State private var name = ""
    @State private var type: WaterSourceType = .distributionPoint
    @State private var flowRate = 0.0
    @State private var status: WaterFlowStatus = .normal
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Details") {
                    TextField("Name", text: $name)
                    Picker("Type", selection: $type) {
                        ForEach(WaterSourceType.allCases, id: \.self) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }
                }
                Section("Status") {
                    Picker("Status", selection: $status) {
                        ForEach(WaterFlowStatus.allCases, id: \.self) { status in
                            Text(status.rawValue).tag(status)
                        }
                    }
                    TextField("Flow Rate", value: $flowRate, format: .number)
                        .keyboardType(.decimalPad)
                }
            }
            .navigationTitle("Add Water Source")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) { Button("Cancel", action: onCancel) }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let newSource = MapWaterSource(name: name, type: type, flowRate: flowRate, status: status, path: [])
                        onSave(newSource)
                    }
                    .disabled(name.isEmpty)
                }
            }
        }
    }
}

struct MapEditWaterSourceSheet: View {
    var source: MapWaterSource
    var onSave: (MapWaterSource) -> Void
    var onCancel: () -> Void
    @State private var name: String
    @State private var flowRate: Double
    @State private var status: WaterFlowStatus
    
    init(source: MapWaterSource, onSave: @escaping (MapWaterSource) -> Void, onCancel: @escaping () -> Void) {
        self.source = source
        self.onSave = onSave
        self.onCancel = onCancel
        _name = State(initialValue: source.name)
        _flowRate = State(initialValue: source.flowRate)
        _status = State(initialValue: source.status)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Details") { TextField("Name", text: $name) }
                Section("Status") {
                    Picker("Status", selection: $status) {
                        ForEach(WaterFlowStatus.allCases, id: \.self) { status in
                            Text(status.rawValue).tag(status)
                        }
                    }
                    TextField("Flow Rate", value: $flowRate, format: .number).keyboardType(.decimalPad)
                }
            }
            .navigationTitle("Edit Water Source")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) { Button("Cancel", action: onCancel) }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        var updatedSource = source
                        updatedSource.name = name
                        updatedSource.flowRate = flowRate
                        updatedSource.status = status
                        onSave(updatedSource)
                    }
                    .disabled(name.isEmpty)
                }
            }
        }
    }
}

struct MapWaterSourceDetailView: View {
    let waterSource: MapWaterSource
    var onClose: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            Capsule().fill(Color.textSecondary.opacity(0.3)).frame(width: 40, height: 5).padding(.top, 8).padding(.bottom, 16)
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(waterSource.name).font(.heading2).foregroundColor(.textPrimary)
                    Text(waterSource.type.rawValue).font(.bodyMedium).foregroundColor(.textSecondary)
                }
                Spacer()
                Button(action: onClose) { Image(systemName: "xmark.circle.fill").font(.title2).foregroundColor(.textTertiary) }
                .buttonStyle(.interactive)
            }
            .padding(.horizontal).padding(.bottom, 24)
            HStack(spacing: 12) {
                MapStatusInfoCard(title: "Status", value: waterSource.status.rawValue, icon: "waveform.path.ecg", color: waterSource.status.color)
                MapStatusInfoCard(title: "Quality", value: waterSource.quality, icon: "drop.fill", color: .primaryTeal)
                MapStatusInfoCard(title: "Flow", value: waterSource.flowRateDisplay, icon: "wind", color: .primaryBlue)
            }
            .padding(.horizontal).padding(.bottom, 24)
            VStack(alignment: .leading, spacing: 12) {
                Text("Current Conditions").font(.heading3).foregroundColor(.textPrimary)
                HStack(spacing: 12) {
                    Image(systemName: "exclamationmark.circle.fill").foregroundColor(waterSource.status.color)
                    Text(waterSource.status.description).font(.bodyMedium).foregroundColor(.textSecondary)
                }
                .padding().frame(maxWidth: .infinity, alignment: .leading).background(Color.cardDark).cornerRadius(.radiusMD)
            }
            .padding(.horizontal).padding(.bottom, 32)
        }
        .background(Color.backgroundDark)
        .cornerRadius(.radiusXL, corners: [.topLeft, .topRight])
    }
}

struct MapStatusInfoCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: icon).font(.title3).foregroundColor(color).frame(width: 40, height: 40).background(color.opacity(0.15)).clipShape(Circle())
            VStack(spacing: 4) {
                Text(value).font(.labelMedium).fontWeight(.semibold).foregroundColor(.textPrimary).multilineTextAlignment(.center).minimumScaleFactor(0.8)
                Text(title).font(.caption).foregroundColor(.textTertiary)
            }
        }
        .padding(12).frame(maxWidth: .infinity).background(Color.cardDark).cornerRadius(.radiusMD)
    }
}

#if canImport(GoogleMaps)
struct MapWaterMapComponent: UIViewRepresentable {
    var waterSources: [MapWaterSource]
    @Binding var selectedSource: MapWaterSource?
    var showFlowArrows: Bool = true
    var showMarkers: Bool = true
    
    func makeUIView(context: Context) -> GMSMapView {
        let camera = GMSCameraPosition.camera(withLatitude: WaterMapData.rwandaCenter.latitude, longitude: WaterMapData.rwandaCenter.longitude, zoom: 9.0)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        mapView.delegate = context.coordinator
        if let styleURL = Bundle.main.url(forResource: "map_style", withExtension: "json") {
            mapView.mapStyle = try? GMSMapStyle(contentsOfFileURL: styleURL)
        }
        return mapView
    }
    
    func updateUIView(_ mapView: GMSMapView, context: Context) {
        mapView.clear()
        for source in waterSources {
            if source.path.count > 1 {
                let path = GMSMutablePath()
                for coordinate in source.path { path.add(coordinate) }
                let polyline = GMSPolyline(path: path)
                polyline.strokeColor = UIColor(source.status.color)
                polyline.strokeWidth = 3.0 + min(CGFloat(source.flowRate / 50.0), 3.0)
                polyline.map = mapView
                polyline.tappable = true
                polyline.userData = source
                if showFlowArrows && source.path.count >= 2 { addFlowArrows(to: mapView, path: source.path, color: source.status.color) }
            }
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
        guard path.count >= 2 else { return }
        let arrowInterval = max(path.count / 4, 1)
        for i in stride(from: 0, to: path.count - 1, by: arrowInterval) {
            let start = path[i]; let end = path[min(i + 1, path.count - 1)]
            let bearing = calculateBearing(from: start, to: end)
            let arrowMarker = GMSMarker(position: end)
            arrowMarker.icon = createArrowIcon(color: UIColor(color), bearing: bearing)
            arrowMarker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
            arrowMarker.map = mapView
        }
    }
    
    private func calculateBearing(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D) -> Double {
        let lat1 = from.latitude * .pi / 180; let lat2 = to.latitude * .pi / 180; let dLon = (to.longitude - from.longitude) * .pi / 180
        let y = sin(dLon) * cos(lat2); let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon)
        return (atan2(y, x) * 180 / .pi + 360).truncatingRemainder(dividingBy: 360)
    }
    
    private func createArrowIcon(color: UIColor, bearing: Double) -> UIImage {
        let size = CGSize(width: 16, height: 16); UIGraphicsBeginImageContextWithOptions(size, false, 0); defer { UIGraphicsEndImageContext() }
        guard let context = UIGraphicsGetCurrentContext() else { return UIImage() }
        context.translateBy(x: size.width / 2, y: size.height / 2); context.rotate(by: CGFloat(bearing * .pi / 180)); context.translateBy(x: -size.width / 2, y: -size.height / 2)
        let path = UIBezierPath(); path.move(to: CGPoint(x: size.width * 0.8, y: size.height / 2)); path.addLine(to: CGPoint(x: size.width * 0.2, y: size.height * 0.2)); path.addLine(to: CGPoint(x: size.width * 0.2, y: size.height * 0.8)); path.close()
        color.setFill(); path.fill(); return UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
    }
    
    func makeCoordinator() -> Coordinator { Coordinator(self) }
    class Coordinator: NSObject, GMSMapViewDelegate {
        var parent: MapWaterMapComponent
        init(_ parent: MapWaterMapComponent) { self.parent = parent }
        func mapView(_ mapView: GMSMapView, didTap overlay: GMSOverlay) {
            if let polyline = overlay as? GMSPolyline, let source = polyline.userData as? MapWaterSource { withAnimation { parent.selectedSource = source } }
        }
        func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
            if let source = marker.userData as? MapWaterSource { withAnimation { parent.selectedSource = source }; return true }; return false
        }
    }
}
#else
struct MapWaterMapComponent: View {
    var waterSources: [MapWaterSource]; @Binding var selectedSource: MapWaterSource?; var showFlowArrows: Bool = true; var showMarkers: Bool = true
    var body: some View { VStack { Text("Map unavailable: Google Maps SDK not present.").foregroundColor(.textSecondary).padding() }.frame(maxWidth: .infinity, maxHeight: .infinity).background(Color.cardDark) }
}
#endif

// MARK: - Primary Water Flow Map View
public struct MapWaterFlowMapView: View {
    @EnvironmentObject var router: AppRouter
    @State private var searchText = ""
    @State private var selectedWaterSource: MapWaterSource?
    @State private var waterSources: [MapWaterSource] = WaterMapData.waterSources
    @State private var showFlowArrows = true
    @State private var showMarkers = true
    @State private var showAlerts = true
    @State private var showMaintenanceZones = true
    @State private var selectedLayer: MapLayer = .all
    @State private var showLayerControls = false
    @State private var showAddSourceSheet = false
    @State private var editingSource: MapWaterSource?
    
    var isAdmin: Bool { (router.currentUser?.role ?? .customer) == .admin }
    var filteredSources: [MapWaterSource] {
        if isAdmin { return waterSources }
        let userArea = router.currentUser?.area ?? ""
        return userArea.isEmpty ? waterSources : waterSources.filter { $0.area?.localizedCaseInsensitiveContains(userArea) ?? false }
    }
    
    public var body: some View {
        content.navigationTitle("Water Map").navigationBarTitleDisplayMode(.large)
    }
    
    private var content: some View {
        ZStack(alignment: .top) {
            MapWaterMapComponent(waterSources: filteredSources, selectedSource: $selectedWaterSource, showFlowArrows: showFlowArrows, showMarkers: showMarkers)
                .edgesIgnoringSafeArea(.all)
            overlays
        }
        .sheet(item: $selectedWaterSource) { source in
            MapWaterSourceDetailSheet(waterSource: source, isAdmin: isAdmin, onClose: { selectedWaterSource = nil }, onEdit: { editingSource = $0 }, onDelete: { deleteSource($0) })
        }
        .sheet(isPresented: $showAddSourceSheet) { MapAddWaterSourceSheet(onSave: { addSource($0) }, onCancel: { showAddSourceSheet = false }) }
        .sheet(item: $editingSource) { source in MapEditWaterSourceSheet(source: source, onSave: { updateSource($0) }, onCancel: { editingSource = nil }).presentationDetents([.large]) }
    }
    
    private var overlays: some View {
        VStack(spacing: 0) {
            MapViewSearchBar(text: $searchText, onSearch: performSearch).padding(.horizontal, .spacingMD).padding(.top, 16)
            Spacer()
            HStack(alignment: .bottom, spacing: .spacingMD) {
                MapWaterFlowLegend()
                Spacer()
                if isAdmin {
                    Button(action: { withAnimation(.spring()) { showLayerControls.toggle() } }) { Image(systemName: showLayerControls ? "eye.slash.fill" : "eye.fill").font(.title3).foregroundColor(.textPrimary).frame(width: 44, height: 44).background(Color.cardDark).clipShape(Circle()).shadow(radius: 4) }
                    .buttonStyle(.interactive)
                    Button(action: { showAddSourceSheet = true }) { Image(systemName: "plus").font(.title3).foregroundColor(.textPrimary).frame(width: 44, height: 44).background(Color.primaryBlue).clipShape(Circle()).shadow(radius: 4) }
                    .buttonStyle(.interactive)
                }
            }
            .padding(.horizontal, .spacingMD).padding(.bottom, 20)
        }
        .overlay(alignment: .topTrailing) {
            if showLayerControls && isAdmin { layerControls.padding(.trailing, .spacingMD).padding(.top, 60) }
        }
    }
    
    private var layerControls: some View {
        VStack(alignment: .leading, spacing: .spacingSM) {
            Text("Map Layers").font(.heading3).foregroundColor(.textPrimary)
            LayerToggleRow(title: "Flow Arrows", isOn: $showFlowArrows, icon: "arrow.right")
            LayerToggleRow(title: "Markers", isOn: $showMarkers, icon: "mappin.circle.fill")
            LayerToggleRow(title: "Alerts", isOn: $showAlerts, icon: "exclamationmark.triangle.fill")
            LayerToggleRow(title: "Maintenance Zones", isOn: $showMaintenanceZones, icon: "wrench.and.screwdriver.fill")
        }
        .padding(.spacingMD).background(Color.cardDark).cornerRadius(.radiusLG).shadow(radius: 8).frame(maxWidth: 200, alignment: .trailing)
    }
    
    private func performSearch() {
        if let match = filteredSources.first(where: { $0.name.localizedCaseInsensitiveContains(searchText) }) { selectedWaterSource = match }
    }
    private func addSource(_ source: MapWaterSource) { waterSources.append(source); showAddSourceSheet = false }
    private func updateSource(_ source: MapWaterSource) { if let index = waterSources.firstIndex(where: { $0.id == source.id }) { waterSources[index] = source }; editingSource = nil; selectedWaterSource = source }
    private func deleteSource(_ source: MapWaterSource) { waterSources.removeAll { $0.id == source.id }; selectedWaterSource = nil }
}

struct LayerToggleRow: View {
    let title: String; @Binding var isOn: Bool; let icon: String
    var body: some View {
        Toggle(isOn: $isOn) {
            HStack(spacing: .spacingSM) {
                Image(systemName: icon).foregroundColor(.primaryBlue).frame(width: 20)
                Text(title).font(.bodySmall).foregroundColor(.textPrimary)
            }
        }
        .toggleStyle(SwitchToggleStyle(tint: .primaryBlue))
    }
}

// MARK: - View Extensions & Shapes
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}
