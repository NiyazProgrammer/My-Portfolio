import SwiftUI

struct BankIconGridView: View {
    @Binding var selectedIcon: String
    @Environment(\.presentationMode) var presentationMode
    let bankIcons: [String] = [
        "alpha", "tinkoff", "sber", "rayfazen", "open", "uMoney"
    ]

    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 6)

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(bankIcons.indices, id: \.self) { index in
                        Image(bankIcons[index])
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding()
                            .onTapGesture {
                                selectedIcon = bankIcons[index]
                                presentationMode.wrappedValue.dismiss()
                            }
                    }
                }
                .padding()
            }
            .navigationTitle("Выбор иконки")
        }
    }
}
