//
//  Alert.swift
//  SwifTacToe
//
//  Created by Adam S on 2022-03-23.
//

import SwiftUI

struct AlertItem : Identifiable {
    let id = UUID()
    var title: Text
    var message: Text
    var buttonTitle: Text
}

struct AlertContext {
    static let humanWin = AlertItem(title: Text("You Win!"), message: Text("Great Job"), buttonTitle: Text("Rematch"))
    static let computerWin = AlertItem(title: Text("You Lost!"), message: Text("Better Luck Next Time!"), buttonTitle: Text("Rematch"))
    static let draw = AlertItem(title: Text("It's a Draw!"), message: Text("What a Battle of Wits!"), buttonTitle: Text("Rematch"))
}
