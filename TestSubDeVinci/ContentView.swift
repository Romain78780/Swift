//
//  ContentView.swift
//  TestSubDeVinci
//
//  Created by Guillaume on 16/04/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = UserViewModel()
    @State private var usernameLogin: String = ""
    @State private var passwordLogin: String = ""
    @State private var usernameRegister: String = ""
    @State private var passwordRegister: String = ""
    @State private var firstnameRegister: String = ""
    @State private var lastnameRegister : String = "" // Corrected the typo here
    @State private var isAdmin : Bool = false
    @State private var isLoggedIn = false

    
    var body: some View {
        NavigationStack {
            NavigationView {
                ScrollView {
                    VStack {
                        if !isLoggedIn {
                            // Login Form
                            VStack {
                                Text("Login")
                                    .font(.largeTitle)
                                    .bold()

                                TextField("Username", text: $usernameLogin)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding()

                                SecureField("Password", text: $passwordLogin)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding()
                                    .textContentType(.oneTimeCode) // Disable strong password suggestions

                                Button("Login") {
                                    let loginconnection = viewModel.connexionUser(pseudo: usernameLogin, password: passwordLogin)
                                    switch loginconnection {
                                    case .connected:
                                        print("Réussis")
                                        isLoggedIn = true
                                    case .badPassword:
                                        print("Réessaie")
                                    case .loginUnavailable:
                                        print("No login")
                                    }
                                }
                                .padding()
                            }
                            .padding()

                            Divider() // Separate Login and Register

                            // Register Form
                            VStack {
                                Text("Register")
                                    .font(.largeTitle)
                                    .bold()

                                TextField("Username", text: $usernameRegister)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding()
                                TextField("FirstName", text: $firstnameRegister)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding()
                                TextField("LastName", text: $lastnameRegister)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding()
                                SecureField("Password", text: $passwordRegister)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding()
                                    .textContentType(.oneTimeCode) // Disable strong password suggestion
                                Toggle("Administrateur", isOn: $isAdmin)
                                    .padding()
                                Button("Register") {
                                    viewModel.addUser(pseudo: usernameRegister, firstName: firstnameRegister, familyName: lastnameRegister, isAdmin: isAdmin, password: passwordRegister)
                                }
                                .padding()
                            }
                            .padding()

                            Spacer()
                        }
                        if isLoggedIn {
                            NavigationLink("QCM", destination: QCMView(questions: Model().questions)).padding()
                        }
                    }
                }
                .navigationBarTitle("Home", displayMode: .inline)
            }
        }
    }
}
