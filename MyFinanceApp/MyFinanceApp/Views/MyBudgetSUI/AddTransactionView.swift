import SwiftUI

struct AddTransactionView: View {
    @ObservedObject var viewModel: AddTransactionViewModel
    @Environment(\.presentationMode) var presentationMode
    var onTransactionAdded: (Transaction) -> Void

    var body: some View {
        VStack {
            operationTypePicker

            amountTextField

            descriptionTextField

            categorySelector

            dateSelector

            saveButton

            Spacer()
        }
        .sheet(isPresented: $viewModel.showTypePicker) {
            categoryPickerView
        }
        .sheet(isPresented: $viewModel.showDatePicker) {
            datePickerView
        }
        .navigationTitle("Добавить операцию")
        .padding()
    }

    private var operationTypePicker: some View {
        Picker("", selection: $viewModel.selectedTransactionType) {
            ForEach(TransactionType.allCases, id: \.self) { type in
                Text(type.rawValue)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
    }

    private var amountTextField: some View {
        TextField("Сумма", text: $viewModel.amount)
            .keyboardType(.decimalPad)
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).stroke(Color(.darkGray), lineWidth: 1))
            .padding(.horizontal)
    }

    private var descriptionTextField: some View {
        TextField(
            viewModel.selectedTransactionType == .expense ? "На что потратили" : "Откуда был совершен заработок",
            text: $viewModel.description)
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).stroke(Color(.darkGray), lineWidth: 1))
            .padding(.horizontal)
    }

    private var categorySelector: some View {
        HStack {
            Text(viewModel.selectedTransactionType == .expense ? "Тип расхода:" : "Тип дохода")
                .font(.system(size: 16))
            Spacer()
            Text(viewModel.selectedTypeCategory?.rawValue ?? "Выбрать")
                .foregroundColor(.gray)
            Image(systemName: "chevron.down")
                .foregroundColor(.gray)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).stroke(Color(.darkGray), lineWidth: 1))
        .padding(.horizontal)
        .onTapGesture {
            viewModel.showTypePicker.toggle()
        }
    }

    private var dateSelector: some View {
        HStack {
            Text("Время")
                .font(.system(size: 16))
            Spacer()

            Button(action: {
                viewModel.showDatePicker.toggle()
            }) {
                Text("\(DateFormatter.dateFormatter.string(from: viewModel.selectedDate)), \(DateFormatter.timeFormatter.string(from: viewModel.selectedDate))")
                    .foregroundStyle(.black)

                Image(systemName: "calendar")
                    .foregroundColor(.black)
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).stroke(Color(.darkGray), lineWidth: 1))
        .padding(.horizontal)
    }

    private var saveButton: some View {
        Button(action: {
            if viewModel.isFormValid() {
                viewModel.addTransaction()
                presentationMode.wrappedValue.dismiss()
            }
        }) {
            Text("Сохранить")
                .font(.title)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: 50)
        .background(LinearGradient(colors: [.purple, .blue], startPoint: .leading, endPoint: .trailing))
        .clipShape(RoundedRectangle(cornerRadius: 25.0))
        .padding()
        .disabled(!viewModel.isFormValid())
    }

    var categoryPickerView: some View {
        VStack {
            Text(viewModel.selectedTransactionType == .expense ? "Выберите тип расхода" : "Выберите тип дохода")
                .font(.headline)
                .padding()

            List(viewModel.categories, id: \.self) { category in
                HStack {
                    CategoryIconView(category: category)
                    Text(category.rawValue)
                    Spacer()
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    viewModel.updateSelectedCategory(category.rawValue)
                    viewModel.showTypePicker = false
                }
            }
        }
    }

    var datePickerView: some View {
        VStack {
            Text("Выберите дату и время")
                .font(.headline)
                .padding()

            DatePicker("", selection: $viewModel.selectedDate, displayedComponents: [.date, .hourAndMinute])
                .datePickerStyle(GraphicalDatePickerStyle())
                .environment(\.locale, Locale(identifier: "ru_RU"))
                .padding()

            Spacer()
        }
    }
}

//#Preview {
//    AddTransactionView()
//}
