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
                GameTextView(title: "Game Mode", size: 20, color: .white)
                    .padding(.top, -8)
                HStack {
                    DifficultyButton(title: "Human", width: 80, height: 10) {
                        viewModel.opponentSelected = .humanOpponent
                        dismiss()
                    }
                    DifficultyButton(title: "Computer", width: 80, height: 10) {
                        viewModel.opponentSelected = .computerOpponent
                    }
                }
                
                if viewModel.opponentSelected == .computerOpponent {
                    
                    GameTextView(title: "Select Difficulty", size: 20, color: .white)
                        .padding(.top, 4)
                    
                    HStack {
                        DifficultyButton(title: "Easy", width: 40, height: 10) {
                            viewModel.difficultySelected = .easy
                            viewModel.activeSheet = false
                            dismiss()
                        }
                        DifficultyButton(title: "Hard", width: 40, height: 10) {
                            viewModel.difficultySelected = .hard
                            viewModel.activeSheet = false
                            dismiss()
                        }
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


enum DifficultySelected {
    case easy, hard
}

enum OpponentSelected {
    case computerOpponent, humanOpponent, noSelection
}


