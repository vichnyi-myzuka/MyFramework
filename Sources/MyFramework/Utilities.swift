//
//  Utilities.swift
//  TicTacToe
//
//  Created by Yaroslav Valentyi on 06.12.2022.
//

import Foundation

internal func getTimerRemainingTime(timer: Timer) -> TimeInterval {
    return timer.fireDate.timeIntervalSince(Date())
}
