import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                if viewModel.showLoading {
                    LoadingView()
                        .onAppear {
                            viewModel.goToApp()
                        }
                } else {
                    Text("Авторизация")
                        .font(.largeTitle)
                        .fontWeight(.semibold)

                    VStack(alignment: .leading) {
                        Text("E-mail")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        TextField("Введите свой email", text: $viewModel.email)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .keyboardType(.emailAddress)
                    }

                    VStack(alignment: .leading) {
                        Text("Пароль")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        HStack {
                            if viewModel.showPassword {
                                TextField("Введите свой пароль", text: $viewModel.password)
                            } else {
                                SecureField("Введите свой пароль", text: $viewModel.password)
                            }
                            Button(action: {
                                viewModel.showPassword.toggle()
                            }) {
                                Image(systemName: viewModel.showPassword ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    }

                    Button(action: {
                        Task {
                            await viewModel.loginUser()
                        }
                    }) {
                        Text("Войти")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.purple)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .alert(isPresented: $viewModel.showAlert) {
                        Alert(title: Text("Error"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
                    }

                    Spacer()

                    HStack {
                        Text("Нет акаунта?")
                        NavigationLink(destination: RegisterView().navigationBarBackButtonHidden(true)) {
                            Text("Регистрация")
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    LoginView()
}
