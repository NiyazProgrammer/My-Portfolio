
import SwiftUI

struct EditCardView: View {
    @State private var showModal: ModalType?
    @ObservedObject var viewModel: AddCardViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            TextField("Наименование счёта", text: $viewModel.name)
                .padding([.leading, .trailing, .top], 10)

            DashedLine()
                .stroke(style: StrokeStyle(lineWidth: 2, dash: [2, 4]))
                .frame(height: 1)
                .foregroundStyle(.purple)
                .padding([.leading, .trailing, .top], 10)

            OptionCardCell()

            DetailRow(title: "Валюта", value: viewModel.selectedCurrency) {
                showModal = .currency
            }

            DetailRow(title: "Остаток", value: viewModel.selectedBalance) {
                showModal = .balance
            }

            IconRow(title: "Иконка счёта", selectedImage: viewModel.selectedIcon) {
                showModal = .icon
            }

            BackgroundRow(title: "Фон счёта", selectedImage: viewModel.selectedBackground) {
                showModal = .background
            }

            Button(action: {}) {
                Text("Удалить счет")
                    .font(.system(size: 16))
                    .foregroundStyle(.red)
            }
            .frame(maxWidth: .infinity, maxHeight: 30)
            .background(.red.opacity(0.3))
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 30, trailing: -10))


            Spacer()
        }
        .navigationTitle("Редактирование")
        .sheet(item: $showModal) { modal in
            switch modal {
            case .currency:
                ChooseCurrencyView(selectedCurrency: $viewModel.selectedCurrency)
            case .balance:
                AccountBalanceView(selectedBalance: $viewModel.selectedBalance)
            case .icon:
                BankIconGridView(selectedIcon: $viewModel.selectedIcon)
            case .background:
                BackgroundCardView(selectionBackground: $viewModel.selectedBackground)
            }
        }
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Сохранить") {
                    viewModel.saveCard()
                    presentationMode.wrappedValue.dismiss()
                }
                .disabled(viewModel.name.isEmpty)
            }
        })
    }
}


//#Preview {
//    EditCardView()
//}
