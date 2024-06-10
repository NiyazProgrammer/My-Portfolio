import SwiftUI

struct AccountBalanceView: View {
    @Binding var selectedBalance: String
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView {
            VStack {
                TextField("Текущий остаток", text: $selectedBalance)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.blue, lineWidth: 2)
                    )
                    .padding()
                Button(action: { presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Применить")
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity, maxHeight: 45)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .padding(.horizontal)

                Spacer()
            }
            .navigationTitle("Остаток")
        }
    }
}
