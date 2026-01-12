import SwiftUI

// MARK: - Water Source Detail Sheet
struct WaterSourceDetailSheet: View {
    let waterSource: MapWaterSource
    var isAdmin: Bool
    var onClose: () -> Void
    var onEdit: (MapWaterSource) -> Void
    var onDelete: (MapWaterSource) -> Void
    
    var body: some View {
        NavigationStack {
            WaterSourceDetailView(waterSource: waterSource, onClose: onClose)
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

// MARK: - Add Water Source Sheet
struct AddWaterSourceSheet: View {
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
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", action: onCancel)
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let newSource = MapWaterSource(
                            name: name,
                            type: type,
                            flowRate: flowRate,
                            status: status,
                            path: [] // Empty path for now
                        )
                        onSave(newSource)
                    }
                    .disabled(name.isEmpty)
                }
            }
        }
    }
}

// MARK: - Edit Water Source Sheet
struct EditWaterSourceSheet: View {
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
                Section("Details") {
                    TextField("Name", text: $name)
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
            .navigationTitle("Edit Water Source")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", action: onCancel)
                }
                
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
