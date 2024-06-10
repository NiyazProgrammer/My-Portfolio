import SwiftUI

enum ModalType: Identifiable {
    case currency, balance, icon, background

    var id: Int {
        hashValue
    }
}

struct AddCardView: View {
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

            Spacer()
        }
        .navigationTitle("Добавить счёт")
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

struct DashedLine: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        return path
    }
}

struct OptionCardCell: View {
    var body: some View {
        HStack {
            Text("Тип счета")
                .padding(10)
            Spacer()
            Text("Дебетовый")
                .foregroundStyle(.gray)
                .padding(10)
        }
    }
}

struct DetailRow: View {
    let title: String
    let value: String
    let action: () -> Void

    var body: some View {
        HStack {
            Text(title)
                .padding(10)
            Spacer()
            Button(action: action) {
                HStack {
                    Text(value)
                        .foregroundStyle(.black)
                    Image(systemName: "chevron.right")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundStyle(.purple)
                }
                .padding([.top, .bottom, .trailing], 10)
            }
        }
    }
}

struct IconRow: View {
    let title: String
    let selectedImage: String
    let action: () -> Void

    var body: some View {
        HStack {
            Text(title)
                .padding(10)
            Spacer()
            Button(action: action) {
                Image(selectedImage)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .padding()
            }
        }
    }
}
struct BackgroundRow: View {
    let title: String
    let selectedImage: String
    let action: () -> Void

    var body: some View {
        HStack {
            Text(title)
                .padding(10)
            Spacer()
            Button(action: action) {
                Image(selectedImage)
                    .resizable()
                    .frame(width: 20, height: 23)
                    .clipShape(Circle())
                    .padding()
            }
        }
    }
}
