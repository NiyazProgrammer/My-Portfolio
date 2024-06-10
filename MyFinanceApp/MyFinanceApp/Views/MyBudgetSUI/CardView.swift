import SwiftUI

struct CardView: View {
    @Binding var bankCard: BankCard
    var body: some View {

        VStack(alignment: .leading) {
            HStack {
                Image(bankCard.labelImage)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(.white)
                    .padding(.trailing, 5)
                Text("\(bankCard.name)")
                    .font(.system(size: 19, weight: .semibold, design: .default))
                    .foregroundStyle(.white)
                Spacer()
                ZStack {
                    Circle()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.white.opacity(0.1))
                    Image(systemName: "pencil.line")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .foregroundStyle(.white)
                }
                .padding(.trailing, 10)
                .onTapGesture {

                }
            }

            Spacer()

            VStack(alignment: .leading) {
                Text("Ваш счет")
                    .foregroundStyle(.white)
                Text("\(bankCard.totalMoney, specifier: "%.2f")")
                    .foregroundStyle(.white)
                    .font(.largeTitle)
            }
        }
        .padding()
        .frame(width: 290, height: 190)
        .background(
            Image(bankCard.backImage)
                .resizable()
                .scaledToFill()
                .frame(width: 290, height: 190)
                .opacity(0.8)
                .cornerRadius(15)
        )
        .cornerRadius(15)
        .shadow(color: .accentColor.opacity(0.2), radius: 5, x: 4, y: 4)
        .padding()
    }
}

