//
//  ContentView.swift
//  SwifTacToe
//
//  Created by Adam S on 2022-03-07.
//

import SwiftUI

//allow difficulty selection
//display status after board is filled


struct ContentView: View {
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    
    @State private var moves: [Move?] = Array(repeating: nil, count: 9)
    @State private var disabledBoard : Bool = false
    
    var body: some View {
        GeometryReader { geo in
            VStack{
                Spacer()
                LazyVGrid(columns: columns, spacing: 5) {
                    ForEach(0..<9) { i in
                        ZStack {
                            Circle()
                                .foregroundColor(.blue).opacity(0.5)
                                .frame(width: geo.size.width/3 - 15, height: geo.size.width/3 - 15)
                                .padding()
                            
                            Image(systemName: moves[i]?.indicator ?? "")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.white)
                        }
                        .onTapGesture {
                            if isOccupied(in: moves, forIndex: i) {
                                return //exit case
                            }
                            moves[i] = Move(player: .human, boardIndex: i)
                            
                            disabledBoard.toggle()
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                let computerPosition = determineComputerMove(in: moves)
                                moves[computerPosition] = Move(player: .computer, boardIndex: computerPosition)
                                disabledBoard.toggle()
                            }
                        }
                    }
                }
                Spacer()
            }.padding()
                .disabled(disabledBoard)
        }
    }
    
    
    func isOccupied(in moves: [Move?], forIndex index: Int) -> Bool {
        return moves.contains(where: {$0?.boardIndex == index}) // if unoccupied, it would be null anyways
    }
    
    
    func determineComputerMove(in moves: [Move?]) -> Int {
        var movePosition = Int.random(in: 0..<9)
        
        while isOccupied(in: moves, forIndex: movePosition) {
            movePosition = Int.random(in: 0..<9)
        }
        return movePosition
    }
}

enum Player {
    case human, computer
}

struct Move {
    let player: Player
    let boardIndex: Int
    var indicator: String {
        return player == .human ? "xmark" : "circle"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
