import SwiftUI

struct ChooseCurrencyView: View {
    @Binding var selectedCurrency: String
    @Environment(\.presentationMode) var presentationMode
    let currencies = ["Российский рубль", "Доллар США", "Евро"]

    var body: some View {
        NavigationView {
            List(currencies, id: \.self) { currency in
                CurrencyCellView(currencyName: currency, isSelected: currency == selectedCurrency)
                    .onTapGesture {
                        selectedCurrency = currency
                        presentationMode.wrappedValue.dismiss()
                    }
            }
            .navigationTitle("Выберите валюту")
        }
    }
}
