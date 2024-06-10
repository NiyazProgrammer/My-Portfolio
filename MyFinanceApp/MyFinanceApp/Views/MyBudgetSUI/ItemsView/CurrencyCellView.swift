import SwiftUI

struct CurrencyCellView: View {
    var currencyName: String
    var isSelected: Bool

    var body: some View {
        HStack {
            Text(currencyName)
                .padding(.leading, 10)

            Spacer()

            if isSelected {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 20, height: 20)
                    .padding(.trailing, 10)
            } else {
                Circle()
                    .stroke(Color.gray, lineWidth: 2)
                    .frame(width: 20, height: 20)
                    .padding(.trailing, 10)
            }
        }
        .padding(.vertical, 10)
    }
}
