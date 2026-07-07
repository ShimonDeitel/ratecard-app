import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var purchases: PurchaseManager
    @Environment(\.dismiss) private var dismiss
    @AppStorage("ratecard_showNotes") private var showNotes: Bool = true
    @AppStorage("ratecard_confirmDelete") private var confirmDelete: Bool = true
    @State private var showPaywall = false

    var body: some View {
        NavigationStack {
            Form {
                Section("Display") {
                    Toggle("Show notes field", isOn: $showNotes)
                        .accessibilityIdentifier("settingsShowNotesToggle")
                    Toggle("Confirm before delete", isOn: $confirmDelete)
                        .accessibilityIdentifier("settingsConfirmDeleteToggle")
                }

                Section("Ratecard Pro") {
                    if purchases.isPurchased {
                        Label("Pro unlocked", systemImage: "checkmark.seal.fill")
                            .foregroundStyle(Theme.accent)
                    } else {
                        Button("Upgrade to Ratecard Pro") { showPaywall = true }
                            .accessibilityIdentifier("settingsUpgradeButton")
                    }
                    Button("Restore Purchases") {
                        Task { await purchases.restore() }
                    }
                    .accessibilityIdentifier("settingsRestoreButton")
                }

                Section("About") {
                    Link("Privacy Policy", destination: URL(string: "https://shimondeitel.github.io/ratecard-app/privacy.html")!)
                    Link("Terms of Use", destination: URL(string: "https://shimondeitel.github.io/ratecard-app/terms.html")!)
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") { dismiss() }
                        .accessibilityIdentifier("settingsDoneButton")
                }
            }
            .sheet(isPresented: $showPaywall) {
                PaywallView().environmentObject(purchases)
            }
        }
    }
}
