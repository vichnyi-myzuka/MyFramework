//
//  TicTacToeEngine.swift
//  TicTacToe
//
//  Created by Yaroslav Valentyi on 06.12.2022.
//

import Foundation

protocol TicTacToeDelegate {
    func callWhenMoveIsMade()
    func callWhenResigned()
    func callWhenGameReset()
    func callWhenGameEnded()
    func callWhenPlayerChanged()
}

public class TicTacToeEngine: ObservableObject {
    var delegate: TicTacToeDelegate?
    
    @Published public private(set) var currentPlayer: PlayerType
    @Published public private(set) var gameEnded: Bool = false
    @Published public private(set) var resigned: Bool = false
    
    private var gameTimer: Timer?
    private var moveTimer: Timer?
    
    private var gameTime: GameTime
    private var moveTime: MoveTime
    
    private(set) var gameTimerEnded: Bool = false
    private(set) var moveTimerEnded: Bool = false
    
    public var canMove: Bool {
        return !gameTimerEnded && !moveTimerEnded && moveEngine.canMove && !gameEnded
    }
    
    public var availableMoves: [Int] {
        return getAvailableMoves()
    }
    
    public var gameTimeRemaining: TimeInterval? {
        if let gameTimer = gameTimer {
            return getTimerRemainingTime(timer: gameTimer)
        }
        return nil
    }
    
    public var moveTimeRemaining: TimeInterval? {
        if let moveTimer = moveTimer {
            return getTimerRemainingTime(timer: moveTimer)
        }
        return nil
    }
    
    public var currentLogs: Logs {
        return getLogs()
    }
    
    public var gameState: [Int] {
        return getGameState()
    }
    
    public var hasWinner: Bool {
        return moveEngine.hasWinner || resigned
    }
    
    public var gameTimerIsNeeded: Bool {
        return gameTime != .withoutTimer
    }
    
    public var moveTimerIsNeeded: Bool {
        return moveTime != .withoutTimer
    }
    
    private let logs: Logs
    private let moveEngine: MoveEngine
    
    public init() {
        self.gameTime = .withoutTimer
        self.moveTime = .withoutTimer
        self.currentPlayer = .first
        self.logs = Logs()
        self.moveEngine = MoveEngine()
        
        prepareGame(gameTime, moveTime)
    }
    
    public init(_ gameTime: GameTime, _ moveTime: MoveTime) {
        self.gameTime = gameTime
        self.moveTime = moveTime
        self.currentPlayer = .first
        self.logs = Logs()
        self.moveEngine = MoveEngine()
        
        prepareGame(gameTime, moveTime)
    }
    
    public func reset() {
        logs.reset()
        moveEngine.reset()
        prepareGame(gameTime, moveTime)
        delegate?.callWhenGameEnded()
    }
    
    public func resign() {
        if (!gameEnded) {
            resigned = true
            changePlayer(nil)
            endGame()
            delegate?.callWhenResigned()
        }
    }
    
    public var winner: PlayerType? {
        return moveEngine.winner ?? (resigned ? currentPlayer : nil)
    }
    
    public func moveAction(_ index: Int) -> Move? {
        if canMove {
            if let position = moveEngine.indexToPosition(index) {
                let move = moveEngine.moveAction(move: Move(player: currentPlayer, position: position))
                if let move = move {
                    let log = addLog(move: move)
                    delegate?.callWhenMoveIsMade()
                    print(log)
                    self.moveTimer?.invalidate()
                    self.moveTimer = initMoveTimer(moveTime)
                    if (hasWinner || !canMove) {
                        endGame()
                    } else {
                        self.changePlayer(nil)
                    }
                    
                    
                    return move
                }
            }
        } else if moveTimerEnded {
            self.changePlayer(nil)
            print("Player \(currentPlayer.rawValue) is ready to make a move!")
            return nil
        }
        return nil
    }
    
    public func rollBackAction() {}
    
    public func rollForwardAction() {}
    
    public func getGameState() -> [Int] {
        return moveEngine.gameState
    }
    
    public func getLogs() -> Logs {
        return logs
    }
    
    private func getAvailableMoves() -> [Int] {
        let availablePositions: [Position] = moveEngine.getAvailablePositions()
        var availableMoves: [Int] = []
        
        for availablePosition in availablePositions {
            if let move = moveEngine.positionToIndex(availablePosition) {
                availableMoves.append(move)
            }
        }
        return availableMoves
    }
    
    private func changePlayer(_ player: PlayerType?) {
        if let player = player {
            currentPlayer = player
        } else {
            if (currentPlayer == .first) {
                currentPlayer = .second
            } else {
                currentPlayer = .first
            }
            print("Player has been changed. Current Player is \(currentPlayer)")
        }
        delegate?.callWhenPlayerChanged()
    }
    
    private func endGame() {
        gameEnded = true
        gameTimer?.invalidate()
        moveTimer?.invalidate()
        if let winner = winner {
            print("Game is ended! Winner is \(winner)")
        }
        delegate?.callWhenGameEnded()
    }
    
    private func initGameTimer (_ gameTime: GameTime) -> Timer {
        self.gameTimerEnded = false
        return Timer.scheduledTimer(withTimeInterval: gameTime.rawValue, repeats: false, block: { timer in
            self.gameTimerEnded = true
            timer.invalidate()
            print("Game ends! Tie!")
            self.endGame()
        })
    }
    
    private func initMoveTimer (_ moveTime: MoveTime) -> Timer {
        self.moveTimerEnded = false
        return Timer.scheduledTimer(withTimeInterval: moveTime.rawValue, repeats: false, block: { timer in
            self.moveTimerEnded = true
            print("Move time has ended! Next player's move!")
            timer.invalidate()
            self.moveTimer = self.initMoveTimer(moveTime)
            self.changePlayer(nil)
        })
    }
    
    private func prepareGame(_ gameTime: GameTime, _ moveTime: MoveTime) {
        if(gameTime != .withoutTimer) {
            gameTimer = initGameTimer(gameTime)
        }
        
        if(moveTime != .withoutTimer) {
            moveTimer = initMoveTimer(moveTime)
        }
    }
    
    private func addLog(move: Move) -> Log {
        var gameTimer: Timer?;
        var moveTimer: Timer?;
        
        if gameTimerIsNeeded {
            gameTimer = self.gameTimer
        }
        
        if moveTimerIsNeeded {
            moveTimer = self.moveTimer
        }
        
        return logs.createLog(move: move, states: moveEngine.getMoves(), gameTimer: gameTimer, moveTimer: moveTimer)
    }
}
