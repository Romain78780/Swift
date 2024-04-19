//
//  UserViewModel.swift
//  TestSubDeVinci
//
//  Created by COURS on 19/04/2024.
//
import Foundation


class UserViewModel: ObservableObject {
    var userDataController = UserDataController.shared

    func connexionUser(pseudo: String, password: String) -> ResultConnect {
        return userDataController.connexionUser(pseudo: pseudo, password: password)
    }

    func getAllUsers() -> [User] {
        return userDataController.getAllUsers()
    }
    func addUser(pseudo: String, firstName: String, familyName: String, isAdmin: Bool, password: String) {
           userDataController.addUser(pseudo: pseudo, firstName: firstName, familyName: familyName, isAdmin: isAdmin, password: password)
       }
}
