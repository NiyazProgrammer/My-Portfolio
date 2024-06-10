import SwiftUI
import UIKit

struct RegisterView: View {
    @StateObject private var viewModel = RegisterViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                if viewModel.showLoading {
                    LoadingView()
                        .onAppear {
                            viewModel.goToApp()
                        }
                } else {
                    VStack(spacing: 20) {
                        Text("Регистрация")
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
                            Text("Имя пользователя")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            TextField("Придумайте имя пользователя", text: $viewModel.username)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(8)
                        }

                        VStack(alignment: .leading) {
                            Text("Пароль")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            HStack {
                                if viewModel.showPassword {
                                    TextField("Придумайте пароль", text: $viewModel.password)
                                } else {
                                    SecureField("Введите пароль занова", text: $viewModel.password)
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

                        VStack(alignment: .leading) {
                            Text("Повторите пароль")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            HStack {
                                if viewModel.showPassword {
                                    TextField("Введите пароль занова", text: $viewModel.confirmPassword)
                                } else {
                                    SecureField("Введите пароль занова", text: $viewModel.confirmPassword)
                                }
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                        }

                        Button(action: {
                            Task {
                                await viewModel.registerUser()
                            }
                        }) {
                            Text("Регистрация")
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
                            Text("Уже есть акаунт?")
                            NavigationLink(destination: LoginView().navigationBarBackButtonHidden(true)) {
                                Text("Войти")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                    .padding()
                    .onAppear {
                        if viewModel.isAuthenticated {
                            viewModel.goToApp()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    RegisterView()
}
