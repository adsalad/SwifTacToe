//
//  GameViewModel.swift
//  SwifTacToe
//
//  Created by Adam S on 2022-03-25.
//

import SwiftUI

final class GameViewModel: ObservableObject {
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    @Published var moves: [Move?] = Array(repeating: nil, count: 9)
    @Published var selected : Difficulty = Difficulty.easy
    @Published var disabledBoard : Bool = false
    @Published var activeSheet : Bool = true
    @Published var alertItem: AlertItem?
    
    
    func processPlayerMove(for position: Int) {
        
        // human move processing
        if isOccupied(in: moves, forIndex: position) {
            return
        }
        moves[position] = Move(player: .human, boardIndex: position) // add Move object array
                                    
        if checkWinCondition(for: .human, in: moves) {
            alertItem = AlertContext.humanWin
            return
        }
        
        if checkDrawCondition(in: moves){
            alertItem = AlertContext.draw
            return
        }
        
        disabledBoard.toggle()
        
        // computer move processing
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
            
            let computerPosition = determineComputerMove(in: moves)
            
            moves[computerPosition] = Move(player: .computer, boardIndex: computerPosition)
            disabledBoard.toggle()
            
            if checkWinCondition(for: .computer, in: moves) {
                alertItem = AlertContext.computerWin
                return
            }
            
            if checkDrawCondition(in: moves){
                alertItem = AlertContext.draw
                return
            }
        }
    }
    
    
    func determineComputerMove(in moves: [Move?]) -> Int {
        
        // if difficulty is easy, just take random square
        if selected == .easy {
            return takeRandomCircle(in: moves)
        }
        
        // if difficulty is hard, then....
        
        // if AI can win, then win
        let winPatterns: Set<Set<Int>> = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
        let computerMoves = moves.compactMap {$0}.filter{$0.player == .computer} //filter all moves for computer
        let computerPositions = Set(computerMoves.map {$0.boardIndex}) //filter the board indices taken from Moves computer made
        
        for pattern in winPatterns {
            let blockPositions = pattern.subtracting(computerPositions) // find set of winning move(s), based on moves computer has already performed
            
            // if there is only one winning move available, take it and win!
            if blockPositions.count == 1 {
                let isAvailable = !isOccupied(in: moves, forIndex: blockPositions.first!)
                if isAvailable { return blockPositions.first!}
            }
        }
        
        // if AI can't win, then block
        let humanMoves = moves.compactMap {$0}.filter{$0.player == .human}
        let humanPositions = Set(humanMoves.map {$0.boardIndex})
        
        for pattern in winPatterns {
            let winPositions = pattern.subtracting(humanPositions)
            
            // if there is a block move available, block the human player!
            if winPositions.count == 1 {
                let isAvailable = !isOccupied(in: moves, forIndex: winPositions.first!)
                if isAvailable { return winPositions.first!}
            }
        }
        
        //if AI can't block, take middle circle
        let centerCircle = 4
        if !isOccupied(in: moves, forIndex: centerCircle) {
            return 4
        }
    
        //if AI can't take middle, take random square
        return takeRandomCircle(in: moves)
    }
    
    func checkWinCondition(for player: Player, in moves: [Move?]) -> Bool {
        let winPatterns: Set<Set<Int>> = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
        let playerMoves = moves.compactMap {$0}.filter{$0.player == player}
        let playerPositions = Set(playerMoves.map {$0.boardIndex})
    
        for pattern in winPatterns where pattern.isSubset(of: playerPositions) {
            return true
        }
        return false
    }
    
    func takeRandomCircle(in moves: [Move?]) -> Int {
        var movePosition = Int.random(in: 0..<9)
        while isOccupied(in: moves, forIndex: movePosition) {
            movePosition = Int.random(in: 0..<9)
        }
        return movePosition
    }
    
    func checkDrawCondition(in moves: [Move?]) -> Bool {
        if moves.compactMap({$0}).count == 9 {
            return true
        }
        return false
    }
    
    func isOccupied(in moves: [Move?], forIndex index: Int) -> Bool {
        return moves.contains(where: {$0?.boardIndex == index}) // if unoccupied, it would be null
    }
    
    func resetGame() {
       moves = Array(repeating: nil, count: 9)
    }
    
}
