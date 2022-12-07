//
//  Log.swift
//  TicTacToe
//
//  Created by Yaroslav Valentyi on 06.12.2022.
//

import Foundation

public struct Log {
    private var gameTimerRemaining: TimeInterval?
    private var moveTimerRemaining: TimeInterval?
    private var move: Move
    private var states: [Int]
    
    init(move: Move, states: [Int] ,gameTimerRemaining: TimeInterval?, moveTimerRemaining: TimeInterval?) {
        self.move = move
        self.states = states
        self.gameTimerRemaining = gameTimerRemaining
        self.moveTimerRemaining = moveTimerRemaining
    }
    
    public var description: String {
        var gameTimerString = ""
        var moveTimerString = ""
        if let gameTimerRemaining = gameTimerRemaining {
            gameTimerString = "\(gameTimerRemaining)"
        }
        if let moveTimerRemaining = moveTimerRemaining {
            moveTimerString = "\(moveTimerRemaining)"
        }
        return "Log action of \(move.getPlayer()) player, game timer remaining:  \(gameTimerString), move timer remaining: \(moveTimerString), move position: \(move.getPosition())"}
}

public class Logs {
    private var logs: [Log]
    
    internal init(logs: [Log]) {
        self.logs = logs
    }
    
    internal init() {
        self.logs = []
    }
    
    private func addLog(_ log: Log) {
        logs.append(log)
    }
    
    internal func getContent() -> [Log] {
        return logs
    }
    
    internal func reset() {
        logs = []
    }
    
    internal func createLog(move: Move, states: [Int], gameTimer: Timer?, moveTimer: Timer?) -> Log {
        var gameTimerRemaining: TimeInterval?
        var moveTimerRemaining: TimeInterval?
        
        if let gameTimer = gameTimer {
            gameTimerRemaining = getTimerRemainingTime(timer: gameTimer)
        }
        
        if let moveTimer = moveTimer {
            moveTimerRemaining = getTimerRemainingTime(timer: moveTimer)
        }
        
        var log = Log(move: move, states: states, gameTimerRemaining: gameTimerRemaining, moveTimerRemaining: moveTimerRemaining)
        
        addLog(log)
        return log
    }
}
