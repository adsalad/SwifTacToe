//
//  HomeView.swift
//  SwifTacToe
//
//  Created by Adam S on 2022-03-25.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel : GameViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.gamePurple
                .ignoresSafeArea()
            VStack{
                GameTextView(title: "SwifTacToe", size: 50, color: .white)
                GameTextView(title: "Select Difficulty", size: 20, color: .white)
                    .padding(.top, -8)
                
                HStack {
                    DifficultyButton(title: "Easy") {
                        viewModel.selected = .easy
                        viewModel.activeSheet = false
                        dismiss()
                    }
                    DifficultyButton(title: "Hard") {
                        viewModel.selected = .hard
                        viewModel.activeSheet = false
                        dismiss()
                    }
                }
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .center
            )
        }
    }
}

enum Difficulty {
    case easy, hard
}
