import SwiftUI

struct PaywallView: View {
    @EnvironmentObject var purchases: PurchaseManager
    @Environment(\.dismiss) private var dismiss
    @State private var isPurchasing = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Image(systemName: "checkmark.seal.fill")
                    .font(.system(size: 56))
                    .foregroundStyle(Theme.accent)
                    .padding(.top, 32)

                Text("Ratecard Pro")
                    .font(Theme.titleFont)
                    .foregroundStyle(Theme.textPrimary)

                Text("Multiple rate cards for different client tiers")
                    .font(Theme.bodyFont)
                    .foregroundStyle(Theme.textPrimary.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)

                Spacer()

                Button {
                    isPurchasing = true
                    Task {
                        await purchases.purchase()
                        isPurchasing = false
                        if purchases.isPurchased { dismiss() }
                    }
                } label: {
                    Text(isPurchasing ? "Processing..." : "Unlock for $3.99")
                        .font(Theme.bodyFont.weight(.semibold))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Theme.accent)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                }
                .accessibilityIdentifier("paywallPurchaseButton")
                .disabled(isPurchasing)
                .padding(.horizontal)

                Button("Restore Purchases") {
                    Task { await purchases.restore() }
                }
                .accessibilityIdentifier("paywallRestoreButton")
                .font(Theme.captionFont)
                .padding(.bottom, 8)
            }
            .padding(.bottom, 24)
            .background(Theme.background.ignoresSafeArea())
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                        .accessibilityIdentifier("paywallCloseButton")
                }
            }
        }
    }
}
