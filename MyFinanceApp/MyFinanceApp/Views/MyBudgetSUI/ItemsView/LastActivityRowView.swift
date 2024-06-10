import SwiftUI

struct LastActivityRowView: View {
    var activityObj: Transaction
    var body: some View {
        HStack {
            CategoryIconView(category: activityObj.category)

            VStack(alignment: .leading) {
                Text("\(activityObj.name)")
                    .font(.system(size: 18, weight: .bold))
                Text(activityObj.dateParsed, format: .dateTime.year().month().day())
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Text(activityObj.price, format: .currency(code: "RUB"))
                .font(.system(size: 18, weight: .bold))
        }
    }
}
