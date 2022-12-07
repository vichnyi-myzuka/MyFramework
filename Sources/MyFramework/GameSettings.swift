//
//  GameSettings.swift
//  TicTacToe
//
//  Created by Yaroslav Valentyi on 06.12.2022.
//

import Foundation

public enum GameTime: Double {
    case oneMinute = 60.0
    case fiveMinutes = 300.0
    case tenMinutes = 600.0
    case withoutTimer = 0.0
}

public enum MoveTime: Double {
    case tenSeconds = 10.0
    case fifteenSeconds = 15.0
    case oneMinute = 60.0
    case withoutTimer = 0.0
}
