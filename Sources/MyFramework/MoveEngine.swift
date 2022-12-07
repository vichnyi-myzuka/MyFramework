//
//  MoveEngine.swift
//  TicTacToe
//
//  Created by Yaroslav Valentyi on 06.12.2022.
//

import Foundation

internal class MoveEngine {
    var count: Int = 0
    var gameState: [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    let winningCombinations: [[Int]] = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    
    internal var canMove: Bool {
        return self.count < 9
    }
    
    internal var winner: PlayerType? {
        for combination in winningCombinations {
            if(gameState[combination[0]] != 0 && gameState[combination[0]] == gameState[combination[1]] && gameState[combination[0]] == gameState[combination[2]]) {
                return PlayerType(rawValue: gameState[combination[0]])
            }
        }
        return nil
    }
    
    internal var hasWinner: Bool {
        if winner != nil {
            return true
        }
        return false
    }
    
    internal func getMoves() -> [Int] {
        return gameState
    }
 
    internal func indexToPosition(_ index: Int) -> Position? {
        switch index {
        case 0:
            return Position(.left, .top)
        case 1:
            return Position(.center, .top)
        case 2:
            return Position(.right, .top)
        case 3:
            return Position(.left, .middle)
        case 4:
            return Position(.center, .middle)
        case 5:
            return Position(.right, .middle)
        case 6:
            return Position(.left, .bottom)
        case 7:
            return Position(.center, .bottom)
        case 8:
            return Position(.right, .bottom)
        default:
            return nil
        }
    }
    
    internal func positionToIndex(_ position: Position) -> Int? {
        switch position {
        case .init(.left, .top):
            return 0
        case .init(.center, .top):
            return 1
        case .init(.right, .top):
            return 2
        case .init(.left, .middle):
            return 3
        case .init(.center, .middle):
            return 4
        case .init(.right, .middle):
            return 5
        case .init(.left, .bottom):
            return 6
        case .init(.center, .bottom):
            return 7
        case .init(.right, .bottom):
            return 8
        default:
            return nil
        }
    }
    
    internal func getAvailablePositions() -> [Position] {
        var availablePositions: [Position] = []
        for (index, position) in gameState.enumerated() {
            if (position == 0) {
                if let availablePosition = indexToPosition(index) {
                    availablePositions.append(availablePosition)
                }
            }
        }
        return availablePositions
    }
    
    private func positionIsAvailable(position: Position) -> Bool {
        return getAvailablePositions().contains(where: { availablePosition in
            return availablePosition.x == position.x && availablePosition.y == position.y
        })
    }
    
    internal func moveAction(move: Move) -> Move? {
        let position = move.getPosition()
        let player = move.getPlayer()
        
        if(positionIsAvailable(position: position) && canMove && !hasWinner) {
            if let index = positionToIndex(position) {
                gameState[index] = player.rawValue
                count += 1
                return move
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    internal func reset() {
        count = 0
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    }
}
