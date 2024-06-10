import SwiftUI

struct DateSwichView: View {
    var currentMonth: String
    var onPreviousMonthTapped: () -> Void
    var onNextMonthTapped: () -> Void

    var body: some View {
        HStack {
            Button(action: onPreviousMonthTapped) {
                Image(systemName: "chevron.left")
                    .padding()
            }
            Spacer()
            Text(currentMonth.capitalized)
            Spacer()
            Button(action: onNextMonthTapped) {
                Image(systemName: "chevron.right")
                    .padding()
            }
            .padding()
        }
        .frame(width: 300, height: 60)
        .background(Color.gray.opacity(0.4))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
