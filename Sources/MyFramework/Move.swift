//
//  Move.swift
//  TicTacToe
//
//  Created by Yaroslav Valentyi on 06.12.2022.
//

import Foundation

public enum xPosition {
    case left
    case center
    case right
}

public enum yPosition {
    case top
    case middle
    case bottom
}

public struct Position: Equatable, Hashable {
    var x: xPosition
    var y: yPosition
    
    init(_ x: xPosition, _ y: yPosition) {
        self.x = x
        self.y = y
    }
    
    public var description: String {
        return "[\(x),\(y)]"
    }
}

public struct Move {
    private var player: PlayerType
    private var position: Position
    
    init(player: PlayerType, position: Position) {
        self.player = player
        self.position = position
    }
    
    public func getPlayer() -> PlayerType {
        return player
    }
    
    public func getPosition() -> Position {
        return position
    }
    
    public var description: String {
        return "This move has made by \(player) and position is \(position)"
    }
}
