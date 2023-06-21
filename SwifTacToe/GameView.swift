//
//  GameView.swift
//  SwifTacToe
//
//  Created by Adam S on 2022-03-07.
//

import SwiftUI

struct GameView: View {
    
    @StateObject var viewModel = GameViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        GeometryReader { geo in
            VStack{
                Spacer()
                GameTextView(title: "SwifTacToe", size: 50, color: Color.gamePurple)
                LazyVGrid(columns: viewModel.columns, spacing: 5) {
                    ForEach(0..<9) { i in
                        ZStack {
                            GameCircleView(proxy: geo)
                            PlayerMarkView(imageName: viewModel.moves[i]?.indicator ?? "")
                        }
                        .onTapGesture {
                            viewModel.processMove(for: i)
                        }
                    }
                }
                Spacer()
            }
            .sheet(isPresented: $viewModel.activeSheet, content: {
                HomeView(viewModel: viewModel)
            .interactiveDismissDisabled()

            })
            .padding()
            .disabled(viewModel.disabledBoard)
            .alert(item: $viewModel.alertItem, content: { alertItem in
                Alert(title: alertItem.title, message: alertItem.message, dismissButton: .default(alertItem.buttonTitle, action: {
                    viewModel.resetGame()
                    viewModel.activeSheet.toggle()
                }))
            })
        }
    }
    
}

enum Player {
    case humanPlayer, opponentPlayer, computer
}

struct Move {
    let player: Player
    let boardIndex: Int
    var indicator: String {
        if player == .humanPlayer {
            return "xmark"
        } else  {
            return "circle"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}

