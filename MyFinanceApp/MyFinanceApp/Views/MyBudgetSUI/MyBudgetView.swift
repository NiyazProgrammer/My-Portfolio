import SwiftUI
import Slideshow

struct MyBudgetView: View {
    @ObservedObject var model: MyBudgetViewModel

    var body: some View {
        NavigationView {
            VStack {
                HeaderView(model: model)
                BankCardsView(model: model)
                AddCardButton(model: model)
                LastActivitySection(model: model)
                Spacer()
            }
            .background(Color.gray.opacity(0.1))
            .onAppear {
                model.loadData()
            }
        }.navigationBarHidden(true)
    }
}

struct HeaderView: View {
    @ObservedObject var model: MyBudgetViewModel

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("Всего денег")
                        .foregroundStyle(.gray)
                }.padding([.leading])

                Text(model.totalMoney, format: .currency(code: "RUB"))
                    .font(.headline)
                    .foregroundColor(.green)
                    .padding(.leading)
            }
            .frame(maxWidth: .infinity, maxHeight: 60, alignment: .leading)
            .background(Color.gray.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1).foregroundStyle(.gray).opacity(0.3))

            Spacer()

            Image("\(String(describing: UserDataManager.shared.getCurrentUser().avatarImageUrl))")
                .resizable()
                .clipShape(Circle())
                .frame(width: 40, height: 40)
                .padding(.leading, 10)
        }
        .padding()
    }
}

struct BankCardsView: View {
    @ObservedObject var model: MyBudgetViewModel

    var body: some View {
        VStack {
            if !model.bankCards.isEmpty {
                Slideshow(
                    $model.bankCards,
                    index: $model.selectedCardIndex
                ) { slide in
                    VStack {
                        GeometryReader { geo in
                            if let bankCards = model.selectedBankCard {
                                let destinationView = DetailOperationScreenView(
                                    model: DetailScreenViewModel(bankCard: bankCards)
                                )
                                let cardView = CardView(bankCard: slide)
                                    .scaleEffect(calculateScaleEffect(geo: geo))
                                    .opacity(calculateOpacity(geo: geo))

                                NavigationLink(destination: destinationView) {
                                    cardView
                                }
                            }
                        }
                        .frame(width: 300, height: 220)
                    }
                }
                .frame(height: 210)
                .padding(.horizontal)
                .onChange(of: model.selectedCardIndex) { _ in
                    model.updateOperationsForSelectedCard()
                }
            } else {
                Text("Нет доступных карточек")
                    .foregroundColor(.red)
            }
        }
    }

    private func calculateScaleEffect(geo: GeometryProxy) -> CGFloat {
        1.0 - abs(geo.frame(in: .global).midX - UIScreen.main.bounds.width / 2) / UIScreen.main.bounds.width
    }

    private func calculateOpacity(geo: GeometryProxy) -> Double {
        Double(1.0 - abs(geo.frame(in: .global).midX - UIScreen.main.bounds.width / 2) / UIScreen.main.bounds.width)
    }
}

struct AddCardButton: View {
    @ObservedObject var model: MyBudgetViewModel

    var body: some View {
        NavigationLink(destination: AddCardView(viewModel: AddCardViewModel(repository: BankCardRepositoryImpl(localService: LocalBankCardService(), remoteService: RemoteBankCardService())))) {
            HStack {
                Image(systemName: "plus")
                    .resizable()
                    .frame(width: 25, height: 25)
                Text("Добавить карту")
                    .font(.title)
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, maxHeight: 40)
            .background(LinearGradient(colors: [.blue, .purple, .pink],
                                       startPoint: .leading, endPoint: .trailing))
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .padding()
        }
    }
}

struct LastActivitySection: View {
    @ObservedObject var model: MyBudgetViewModel

    var body: some View {
        VStack {
            HStack {
                Text("Последние транзакции")
                    .font(.system(size: 18, weight: .bold))
                Spacer()
            }
            .padding()

            if let transactions = model.selectedBankCard?.transactions {
                if !transactions.isEmpty {
                    List(transactions) { value in
                        LastActivityRowView(
                            activityObj: Transaction(
                                id: UUID(),
                                name: value.name,
                                date: value.date,
                                price: value.signedAmount,
                                type: value.type,
                                category: value.category
                            )
                        )
                    }
                    .listStyle(.plain)
                }
            } else {
                Text("Транзакции не найдены")
            }
        }
    }
}
