import SwiftUI

struct EditAreaStatusView: View {
    let area: Area
    @State private var selectedStatus: WaterStatus
    @State private var selectedSource: String
    @State private var isSaving = false
    
    @State private var waterSources = ["Main Reservoir", "Pump Station A", "Treatment Plant", "Well System", "Reservoir B", "Pump Station B"]
    
    init(area: Area) {
        self.area = area
        _selectedStatus = State(initialValue: area.status)
        _selectedSource = State(initialValue: area.waterSource)
    }
    
    var body: some View {
        ZStack {
            Color.backgroundDark.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    VStack(spacing: 16) {
                        Text(area.name)
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.textPrimary)
                        
                        StatusBadge(text: selectedStatus.rawValue, color: statusColor(for: selectedStatus))
                    }
                    .padding(.top, 20)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Water Status")
                            .font(.headline)
                            .foregroundColor(.textPrimary)
                        
                        VStack(spacing: 12) {
                            ForEach(WaterStatus.allCases, id: \.self) { status in
                                StatusOptionButton(
                                    status: status,
                                    isSelected: selectedStatus == status
                                ) {
                                    withAnimation {
                                        selectedStatus = status
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                    .background(Color.cardDark)
                    .cornerRadius(16)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Water Source")
                            .font(.subheadline)
                            .foregroundColor(.textSecondary)
                        
                        Picker("Source", selection: $selectedSource) {
                            ForEach(waterSources, id: \.self) { source in
                                Text(source).tag(source)
                            }
                        }
                        .pickerStyle(.menu)
                        .padding()
                        .background(Color.cardDark)
                        .cornerRadius(12)
                        .foregroundColor(.textPrimary)
                    }
                    .padding(.horizontal)
                    
                    VStack(spacing: 16) {
                        InfoCard(
                            icon: "person.3.fill",
                            title: "Population",
                            value: "\(area.population.formatted())",
                            color: .purple
                        )
                        
                        InfoCard(
                            icon: "clock.fill",
                            title: "Last Updated",
                            value: area.lastUpdated.formatted(date: .abbreviated, time: .shortened),
                            color: .orange
                        )
                    }
                    .padding(.horizontal)
                    
                    PrimaryButton(title: "Save Changes") {
                        withAnimation {
                            isSaving = true
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            withAnimation {
                                isSaving = false
                            }
                        }
                    }
                    .disabled(isSaving)
                    .padding(.horizontal)
                    .padding(.bottom, 40)
                }
            }
        }
        .navigationTitle("Edit Area")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func statusColor(for status: WaterStatus) -> Color {
        switch status {
        case .available: return .green
        case .lowPressure: return .yellow
        case .scheduledMaintenance: return .orange
        case .outage: return .red
        }
    }
}

struct StatusOptionButton: View {
    let status: WaterStatus
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Circle()
                    .fill(isSelected ? statusColor(for: status) : Color.clear)
                    .frame(width: 20, height: 20)
                    .overlay(
                        Circle()
                            .stroke(statusColor(for: status), lineWidth: 2)
                    )
                
                Text(status.rawValue)
                    .font(.headline)
                    .foregroundColor(.textPrimary)
                
                Spacer()
                
                if isSelected {
                    Image(systemName: "checkmark")
                        .foregroundColor(statusColor(for: status))
                }
            }
            .padding()
            .background(isSelected ? statusColor(for: status).opacity(0.1) : Color.clear)
            .cornerRadius(12)
        }
        .buttonStyle(.interactive)
    }
    
    private func statusColor(for status: WaterStatus) -> Color {
        switch status {
        case .available: return .green
        case .lowPressure: return .yellow
        case .scheduledMaintenance: return .orange
        case .outage: return .red
        }
    }
}

#Preview {
    NavigationStack {
        EditAreaStatusView(area: Area(name: "Kigali Central", status: .available, population: 50000, waterSource: "Main Reservoir"))
    }
}

