import SwiftUI

struct EditProfileView: View {
    @Binding var user: User
    @Environment(\.dismiss) var dismiss
    @State private var editedName: String
    @State private var editedPhone: String
    @State private var editedAddress: String
    @State private var editedArea: String
    @State private var areas = ["Kigali Central", "Gasabo", "Nyarugenge", "Kicukiro"]
    
    init(user: Binding<User>) {
        self._user = user
        _editedName = State(initialValue: user.wrappedValue.name)
        _editedPhone = State(initialValue: user.wrappedValue.phone)
        _editedAddress = State(initialValue: user.wrappedValue.address)
        _editedArea = State(initialValue: user.wrappedValue.area)
    }
    
    var body: some View {
        ZStack {
            Color.backgroundDark.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    VStack(spacing: 20) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Full Name")
                                .font(.subheadline)
                                .foregroundColor(.textSecondary)
                            
                            TextField("Enter name", text: $editedName)
                                .textFieldStyle(.plain)
                                .padding()
                                .background(Color.cardDark)
                                .cornerRadius(12)
                                .foregroundColor(.textPrimary)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Phone")
                                .font(.subheadline)
                                .foregroundColor(.textSecondary)
                            
                            TextField("Enter phone", text: $editedPhone)
                                .textFieldStyle(.plain)
                                .padding()
                                .background(Color.cardDark)
                                .cornerRadius(12)
                                .foregroundColor(.textPrimary)
                                .keyboardType(.phonePad)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Address")
                                .font(.subheadline)
                                .foregroundColor(.textSecondary)
                            
                            TextField("Enter address", text: $editedAddress)
                                .textFieldStyle(.plain)
                                .padding()
                                .background(Color.cardDark)
                                .cornerRadius(12)
                                .foregroundColor(.textPrimary)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Service Area")
                                .font(.subheadline)
                                .foregroundColor(.textSecondary)
                            
                            Picker("Area", selection: $editedArea) {
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
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    PrimaryButton(title: "Save Changes") {
                        withAnimation {
                            user.name = editedName
                            user.phone = editedPhone
                            user.address = editedAddress
                            user.area = editedArea
                        }
                        dismiss()
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom, 40)
            }
        }
        .navigationTitle("Edit Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        EditProfileView(user: .constant(User(name: "John Doe", email: "john@example.com", phone: "+250 788 123 456", address: "KG 123 St", role: .customer, area: "Kigali Central")))
    }
}

