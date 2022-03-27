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
                Color(UIColor(red: 75/255, green: 0/255, blue: 226/255, alpha: 1))
                    .ignoresSafeArea()
                VStack{
                    
                    //extract this also
                    Text("SwifTacToe")
                        .font(.custom("Courier", size: 50))
                        .foregroundColor(.white)
                        .bold()
                    
                    Text("Select Difficulty")
                        .font(.custom("Courier", size: 20))
                        .foregroundColor(.white)
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

struct DifficultyButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(title, action: action)
            .frame(width: 40, height: 10)
            .foregroundColor(Color(UIColor(red: 75/255, green: 0/255, blue: 226/255, alpha: 1)))
            .padding()
            .background(.white)
            .cornerRadius(8)
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView(viewModel: viewModel)
//    }
//}
