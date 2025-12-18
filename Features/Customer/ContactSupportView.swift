import SwiftUI

struct ContactSupportView: View {
    @State private var subject = ""
    @State private var message = ""
    @State private var contactMethod: ContactMethod = .email
    @State private var isSubmitted = false
    
    enum ContactMethod: String, CaseIterable {
        case email = "Email"
        case phone = "Phone"
        case chat = "Live Chat"
    }
    
    var body: some View {
        ZStack {
            Color.backgroundDark.ignoresSafeArea()
            
            if isSubmitted {
                VStack(spacing: 24) {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.green)
                    
                    Text("Message Sent!")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.textPrimary)
                    
                    Text("We'll get back to you within 24 hours")
                        .font(.subheadline)
                        .foregroundColor(.textSecondary)
                        .multilineTextAlignment(.center)
                    
                    PrimaryButton(title: "Send Another") {
                        withAnimation {
                            isSubmitted = false
                            subject = ""
                            message = ""
                        }
                    }
                }
                .padding()
                .transition(.scale.combined(with: .opacity))
            } else {
                ScrollView {
                    VStack(spacing: 24) {
                        VStack(spacing: 16) {
                            InfoCard(
                                icon: "phone.fill",
                                title: "Phone Support",
                                value: "+250 788 000 000",
                                color: .blue
                            )
                            
                            InfoCard(
                                icon: "envelope.fill",
                                title: "Email Support",
                                value: "support@waterutility.rw",
                                color: .orange
                            )
                            
                            InfoCard(
                                icon: "clock.fill",
                                title: "Support Hours",
                                value: "24/7 Available",
                                color: .green
                            )
                        }
                        .padding(.top)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Contact Method")
                                .font(.subheadline)
                                .foregroundColor(.textSecondary)
                            
                            Picker("Method", selection: $contactMethod) {
                                ForEach(ContactMethod.allCases, id: \.self) { method in
                                    Text(method.rawValue).tag(method)
                                }
                            }
                            .pickerStyle(.segmented)
                        }
                        .padding(.horizontal)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Subject")
                                .font(.subheadline)
                                .foregroundColor(.textSecondary)
                            
                            TextField("Enter subject", text: $subject)
                                .textFieldStyle(.plain)
                                .padding()
                                .background(Color.cardDark)
                                .cornerRadius(12)
                                .foregroundColor(.textPrimary)
                        }
                        .padding(.horizontal)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Message")
                                .font(.subheadline)
                                .foregroundColor(.textSecondary)
                            
                            TextEditor(text: $message)
                                .frame(height: 200)
                                .padding(8)
                                .background(Color.cardDark)
                                .cornerRadius(12)
                                .foregroundColor(.textPrimary)
                                .scrollContentBackground(.hidden)
                        }
                        .padding(.horizontal)
                        
                        PrimaryButton(title: "Send Message") {
                            withAnimation {
                                isSubmitted = true
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 40)
                    }
                }
            }
        }
        .navigationTitle("Contact Support")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        ContactSupportView()
    }
}

