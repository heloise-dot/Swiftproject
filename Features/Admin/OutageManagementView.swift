import SwiftUI

struct OutageManagementView: View {
    @State private var selectedTab = 0
    
    var body: some View {
            ZStack {
                Color.backgroundDark.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    Picker("View", selection: $selectedTab) {
                        Text("Active").tag(0)
                        Text("History").tag(1)
                    }
                    .pickerStyle(.segmented)
                    .padding()
                    
                    if selectedTab == 0 {
                        ActiveOutagesView()
                    } else {
                        OutageHistoryView()
                    }
                }
            }
            .navigationTitle("Outage Management")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(value: AppRoute.createOutage) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.primaryBlue)
                    }
                }
            }
    }
}

#Preview {
    OutageManagementView()
}

