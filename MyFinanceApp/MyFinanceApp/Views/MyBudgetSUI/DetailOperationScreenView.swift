import SwiftUI
import SwiftUICharts

struct DetailOperationScreenView: View {
    @State private var indexTappedOfSlice = -1
    @ObservedObject var model: DetailScreenViewModel
    @State private var isPresentingAddTransactionView = false

    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    DateSwichView(
                        currentMonth: model.currentMonth,
                        onPreviousMonthTapped: {
                            model.switchPreviousMonth()
                        },
                        onNextMonthTapped: {
                            model.switchNextMonth()
                        })
                    .padding(.horizontal)

                    Picker("", selection: $model.currentTypeTransactions) {
                        ForEach(TransactionType.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()

                    HStack {
                        chartCircleView
                            .frame(width: 100, height: 200)
                            .padding()

                        VStack {
                            chartListView
                                .frame(width: 100, alignment: .trailing)
                                .padding(8)
                        }
                        .padding(.leading, 50)
                    }
                    .padding(.leading, 20)
                }
                .padding()

                HStack {
                    Text(model.currentTypeTransactions.rawValue)
                        .font(.system(size: 20, weight: .bold))
                    Spacer()
                }
                .padding()

                TransactionsListByType(typeTransaction: model.currentTypeTransactions, viewModel: model)
            }
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    buttonAddTransactionView
                }
            })
            .navigationTitle("Транзакции")
        }
    }

}

extension DetailOperationScreenView {
    private var chartCircleView: some View {
        ZStack {
            if model.currentChartData.isEmpty {
                Circle()
                    .trim(from: 0, to: 1)
                    .stroke(.gray, lineWidth: 100)

                Circle()
                    .foregroundStyle(Color(.systemBackground))
            } else {
                ForEach(model.currentChartData.indices, id: \.self) { index in
                    Circle()
                        .trim(from: index == 0 ? 0.0 : model.currentChartData[index - 1].value,
                              to: model.currentChartData[index].value)
                        .stroke(model.currentChartData[index].color, lineWidth: 100)
                        .scaleEffect(index == indexTappedOfSlice ? 1.1 : 1.0)
                        .animation(.spring(), value: indexTappedOfSlice)

                    Circle()
                        .foregroundStyle(Color(.white))
                }
            }
        }
    }

    private var chartListView: some View {
        Group {
            if model.currentChartData.isEmpty {
                HStack {
                    Text("0.00 %")

                    RoundedRectangle(cornerRadius: 3)
                        .fill(.gray)
                        .frame(width: 20, height: 20)
                }
            } else {
                ForEach(model.currentChartData.indices, id: \.self) { index in
                    HStack {
                        Text(String(format: "%.2f", Double(model.currentChartData[index].percent)) + "%")
                            .onTapGesture {
                                indexTappedOfSlice = indexTappedOfSlice == index ? -1 : index
                            }
                            .font(indexTappedOfSlice == index ? .headline : .subheadline)

                        RoundedRectangle(cornerRadius: 3)
                            .fill(model.currentChartData[index].color)
                            .frame(width: 20, height: 20)
                    }
                }
            }
        }
    }

    private var buttonAddTransactionView: some View {
        Button(action: { isPresentingAddTransactionView = true }, label: {
            Image(systemName: "plus")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundStyle(.white)
                .padding(.trailing, 7)
        })
        .frame(width: 35, height: 35)
        .background(LinearGradient(colors: [.blue, .purple, .pink], startPoint: .leading, endPoint: .trailing))
        .clipShape(Circle())
        .contentShape(Circle())
        .fixedSize()
        .sheet(isPresented: $isPresentingAddTransactionView) {
            let transactionVireModel = AddTransactionViewModel(selectedCard: model.selectedBankCard, repository: TransactionRepositoryImpl(localService: LocalTransactionService(), remoteService: RemoteTransactionService()))
            AddTransactionView(viewModel: transactionVireModel) {
                model.addTransaction($0) 
            }
        }
    }
}

struct TransactionsListByType: View {
    var typeTransaction: TransactionType
    @ObservedObject var viewModel: DetailScreenViewModel

    var body: some View {
        VStack(alignment: .leading) {
            ForEach(Array(viewModel.groupTransactionsByDay()), id: \.key) { month, transactions in
                if !transactions.isEmpty {
                    Section {
                        ForEach(transactions) { transaction in
                            DetailActivityCell(transaction: transaction)
                        }
                    } header: {
                        Text(month)
                            .frame(alignment: .leading)
                    }
                    .listSectionSeparator(.hidden)
                } else {
                    Text("За выбранный период ничего не найдено.")
                        .padding()
                }
            }
        }
        .padding()
    }
}
