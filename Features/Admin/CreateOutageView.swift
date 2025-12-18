import SwiftUI

struct CreateOutageView: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedArea = "Kigali Central"
    
    // UPDATED: Changed from OutageSeverity to WaterStatus
    @State private var selectedSeverity: WaterStatus = .available
    
    @State private var description = ""
    @State private var cause = ""
    @State private var estimatedHours = 2
    @State private var affectedCustomers = 1000
    @State private var isCreating = false
    
    let areas = ["Kigali Central", "Gasabo", "Nyarugenge", "Kicukiro", "Kimisagara", "Remera"]
    
    var body: some View {
        ZStack {
            Color.backgroundDark.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    areaPickerSection
                    severitySection
                    descriptionSection
                    causeSection
                    durationAndCustomersSection
                    createButton
                }
            }
        }
        .navigationTitle("Create Outage")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Sub-views
private extension CreateOutageView {
    
    var areaPickerSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Area").font(.subheadline).foregroundColor(.textSecondary)
            Picker("Area", selection: $selectedArea) {
                ForEach(areas, id: \.self) { area in
                    Text(area).tag(area)
                }
            }
            .pickerStyle(.menu)
            .padding()
            .background(Color.cardDark)
            .cornerRadius(12)
            .foregroundColor(.textPrimary)
        }
        .padding(.horizontal).padding(.top)
    }
    
    var severitySection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Severity").font(.subheadline).foregroundColor(.textSecondary)
            VStack(spacing: 12) {
                // UPDATED: Loop through WaterStatus cases
                ForEach(WaterStatus.allCases, id: \.self) { severity in
                    StatusOptionButton(
                        status: severity,
                        isSelected: selectedSeverity == severity
                    ) {
                        withAnimation { selectedSeverity = severity }
                    }
                }
            }
        }
        .padding().background(Color.cardDark).cornerRadius(16).padding(.horizontal)
    }
    
    var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Description").font(.subheadline).foregroundColor(.textSecondary)
            TextField("Enter description", text: $description, axis: .vertical)
                .lineLimit(3...6)
                .textFieldStyle(.plain)
                .padding().background(Color.cardDark).cornerRadius(12).foregroundColor(.textPrimary)
        }
        .padding(.horizontal)
    }
    
    var causeSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Cause").font(.subheadline).foregroundColor(.textSecondary)
            TextField("Enter cause", text: $cause)
                .textFieldStyle(.plain)
                .padding().background(Color.cardDark).cornerRadius(12).foregroundColor(.textPrimary)
        }
        .padding(.horizontal)
    }
    
    var durationAndCustomersSection: some View {
        Group {
            VStack(alignment: .leading, spacing: 8) {
                Text("Estimated Duration (hours)").font(.subheadline).foregroundColor(.textSecondary)
                Stepper(value: $estimatedHours, in: 1...48) {
                    Text("\(estimatedHours) hours").foregroundColor(.textPrimary)
                }
                .padding().background(Color.cardDark).cornerRadius(12)
            }
            .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Affected Customers").font(.subheadline).foregroundColor(.textSecondary)
                TextField("Enter number", value: $affectedCustomers, format: .number)
                    .textFieldStyle(.plain)
                    .padding().background(Color.cardDark).cornerRadius(12).foregroundColor(.textPrimary)
                    .keyboardType(.numberPad)
            }
            .padding(.horizontal)
        }
    }
    
    var createButton: some View {
        PrimaryButton(title: "Create Outage") {
            withAnimation { isCreating = true }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation {
                    isCreating = false
                    dismiss()
                }
            }
        }
        .disabled(isCreating || description.isEmpty || cause.isEmpty)
        .padding(.horizontal).padding(.bottom, 40)
    }
}
