import SwiftUI
import CoreLocation

// NOTE: Uses Google Maps via WaterMapComponent; that file already has a fallback
// when GoogleMaps is unavailable, so this type is always defined.

#if canImport(GoogleMaps)
// MARK: - Primary Water Flow Map View (with Google Maps)
struct WaterFlowMapView: View {
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
    
    // User role - would come from router or environment
    var isAdmin: Bool {
        (router.currentUser?.role ?? .customer) == .admin
    }
    
    // Filter sources for customer by area
    var filteredSources: [MapWaterSource] {
        if isAdmin {
            return waterSources
        } else {
            let userArea = router.currentUser?.area ?? ""
            if userArea.isEmpty { return waterSources }
            return waterSources.filter { source in
                source.area?.localizedCaseInsensitiveContains(userArea) ?? false
            }
        }
    }
    
    var body: some View {
        content
            .navigationTitle("Water Map")
            .navigationBarTitleDisplayMode(.large)
    }
    
    private var content: some View {
        ZStack(alignment: .top) {
            WaterMapComponent(
                waterSources: filteredSources,
                selectedSource: $selectedWaterSource,
                showFlowArrows: showFlowArrows,
                showMarkers: showMarkers
            )
            .edgesIgnoringSafeArea(.all)
            
            overlays
        }
        .sheet(item: $selectedWaterSource) { source in
            WaterSourceDetailSheet(
                waterSource: source,
                isAdmin: isAdmin,
                onClose: { selectedWaterSource = nil },
                onEdit: { source in editingSource = source },
                onDelete: { source in deleteSource(source) }
            )
        }
        .sheet(isPresented: $showAddSourceSheet) {
            AddWaterSourceSheet(
                onSave: { newSource in addSource(newSource) },
                onCancel: { showAddSourceSheet = false }
            )
        }
        .sheet(item: $editingSource) { source in
            EditWaterSourceSheet(
                source: source,
                onSave: { updatedSource in updateSource(updatedSource) },
                onCancel: { editingSource = nil }
            )
            .presentationDetents([.large])
        }
    }
    
    private var overlays: some View {
        VStack(spacing: 0) {
            MapSearchBar(text: $searchText, onSearch: performSearch)
                .padding(.horizontal, .spacingMD)
                .padding(.top, 16)
            
            Spacer()
            
            HStack(alignment: .bottom, spacing: .spacingMD) {
                WaterFlowLegend()
                Spacer()
                
                if isAdmin {
                    Button(action: { withAnimation(.spring()) { showLayerControls.toggle() } }) {
                        Image(systemName: showLayerControls ? "eye.slash.fill" : "eye.fill")
                            .font(.title3)
                            .foregroundColor(.textPrimary)
                            .frame(width: 44, height: 44)
                            .background(Color.cardDark)
                            .clipShape(Circle())
                            .shadow(radius: 4)
                    }
                    
                    Button(action: { showAddSourceSheet = true }) {
                        Image(systemName: "plus")
                            .font(.title3)
                            .foregroundColor(.textPrimary)
                            .frame(width: 44, height: 44)
                            .background(Color.primaryBlue)
                            .clipShape(Circle())
                            .shadow(radius: 4)
                    }
                }
            }
            .padding(.horizontal, .spacingMD)
            .padding(.bottom, 20)
        }
        .overlay(alignment: .topTrailing) {
            if showLayerControls && isAdmin {
                layerControls
                    .padding(.trailing, .spacingMD)
                    .padding(.top, 60)
            }
        }
    }
    
    private var layerControls: some View {
        VStack(alignment: .leading, spacing: .spacingSM) {
            Text("Map Layers")
                .font(.heading3)
                .foregroundColor(.textPrimary)
            
            LayerToggleRow(title: "Flow Arrows", isOn: $showFlowArrows, icon: "arrow.right")
            LayerToggleRow(title: "Markers", isOn: $showMarkers, icon: "mappin.circle.fill")
            LayerToggleRow(title: "Alerts", isOn: $showAlerts, icon: "exclamationmark.triangle.fill")
            LayerToggleRow(title: "Maintenance Zones", isOn: $showMaintenanceZones, icon: "wrench.and.screwdriver.fill")
        }
        .padding(.spacingMD)
        .background(Color.cardDark)
        .cornerRadius(.radiusLG)
        .shadow(radius: 8)
        .frame(maxWidth: 200, alignment: .trailing)
    }
    
    // MARK: - Actions
    private func performSearch() {
        guard !searchText.isEmpty else { return }
        if let match = filteredSources.first(where: { $0.name.localizedCaseInsensitiveContains(searchText) }) {
            selectedWaterSource = match
        }
    }
    
    private func addSource(_ source: MapWaterSource) {
        waterSources.append(source)
        showAddSourceSheet = false
    }
    
    private func updateSource(_ source: MapWaterSource) {
        if let index = waterSources.firstIndex(where: { $0.id == source.id }) {
            waterSources[index] = source
        }
        editingSource = nil
        selectedWaterSource = source
    }
    
    private func deleteSource(_ source: MapWaterSource) {
        waterSources.removeAll { $0.id == source.id }
        selectedWaterSource = nil
    }
}
#else
// MARK: - Fallback when GoogleMaps is unavailable
struct WaterFlowMapView: View {
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "map.fill")
                .font(.largeTitle)
                .foregroundColor(.textSecondary)
            Text("Map unavailable: Google Maps SDK not present.")
                .font(.bodyMedium)
                .foregroundColor(.textSecondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.cardDark.ignoresSafeArea())
    }
}
#endif

// MARK: - Helper Views
struct LayerToggleRow: View {
    let title: String
    @Binding var isOn: Bool
    let icon: String
    
    var body: some View {
        Toggle(isOn: $isOn) {
            HStack(spacing: .spacingSM) {
                Image(systemName: icon)
                    .foregroundColor(.primaryBlue)
                    .frame(width: 20)
                
                Text(title)
                    .font(.bodySmall)
                    .foregroundColor(.textPrimary)
            }
        }
        .toggleStyle(SwitchToggleStyle(tint: .primaryBlue))
    }
}
