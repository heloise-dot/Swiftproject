import SwiftUI

struct HelpCenterView: View {
    @State private var faqs: [(question: String, answer: String)] = [
        ("How do I check water availability?", "Navigate to the Home tab and select your area, or use the Water Availability search feature to check any area's status."),
        ("What should I do during an outage?", "During an outage, conserve water by using stored water. Check the Outages section for updates and estimated restoration times."),
        ("How do I report a water issue?", "Contact support through the Contact Support section in your profile. Provide details about the issue and your location."),
        ("How is my water usage calculated?", "Your water usage is calculated based on meter readings. You can view daily, weekly, and monthly breakdowns in the Usage tab."),
        ("Can I receive outage notifications?", "Yes! Enable outage alerts in Settings > Notifications to receive real-time updates about water outages in your area."),
        ("What do the status colors mean?", "Green means water is available, Yellow indicates low pressure, Orange is scheduled maintenance, and Red means water is off.")
    ]
    
    @State private var expandedIndex: Int? = nil
    
    var body: some View {
        ZStack {
            Color.backgroundDark.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    VStack(spacing: 12) {
                        Image(systemName: "questionmark.circle.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.primaryBlue)
                        
                        Text("Frequently Asked Questions")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.textPrimary)
                    }
                    .padding(.top, 20)
                    
                    VStack(spacing: 12) {
                        ForEach(Array(faqs.enumerated()), id: \.offset) { index, faq in
                            FAQCard(
                                question: faq.question,
                                answer: faq.answer,
                                isExpanded: expandedIndex == index
                            ) {
                                withAnimation {
                                    expandedIndex = expandedIndex == index ? nil : index
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    NavigationLink(value: AppRoute.contactSupport) {
                        HStack {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Still need help?")
                                    .font(.headline)
                                    .foregroundColor(.textPrimary)
                                
                                Text("Contact our support team")
                                    .font(.subheadline)
                                    .foregroundColor(.textSecondary)
                            }
                            
                            Spacer()
                            
                            Image(systemName: "arrow.right")
                                .foregroundColor(.primaryBlue)
                        }
                        .padding()
                        .background(Color.cardDark)
                        .cornerRadius(16)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.horizontal)
                    .padding(.bottom, 40)
                }
            }
        }
        .navigationTitle("Help Center")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct FAQCard: View {
    let question: String
    let answer: String
    let isExpanded: Bool
    let action: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button(action: action) {
                HStack {
                    Text(question)
                        .font(.headline)
                        .foregroundColor(.textPrimary)
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                    
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.textSecondary)
                }
                .padding()
            }
            .buttonStyle(PlainButtonStyle())
            
            if isExpanded {
                Divider()
                    .background(Color.textSecondary.opacity(0.3))
                
                Text(answer)
                    .font(.subheadline)
                    .foregroundColor(.textSecondary)
                    .padding()
                    .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .background(Color.cardDark)
        .cornerRadius(16)
    }
}

#Preview {
    NavigationStack {
        HelpCenterView()
    }
}

