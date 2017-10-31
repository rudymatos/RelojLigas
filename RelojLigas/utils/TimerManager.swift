//
//  TimerManager.swift
//  RelojLigas
//
//  Created by Rudy E Matos on 10/3/17.
//  Copyright © 2017 Bearded Gentleman. All rights reserved.
//

import Foundation
import UIKit

class TimerManager{
    
    typealias CompletionBlock = () -> Void
    private var timer : Timer?
    private var timerState : TimerState = .HAS_NOT_STARTED_YET
    
    func getTimerCurrentState() -> TimerState{
        return timerState
    }
    
    func shouldResetCounters() -> Bool{
        return timerState != .HAS_NOT_STARTED_YET
    }
    
    public func pauseEndTimer(timerState : TimerState, completion: CompletionBlock){
        timer?.invalidate()
        self.timerState = timerState
        completion()
    }
    
    public func startTimer(completion : @escaping CompletionBlock){
        self.timerState = .RUNNING
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            completion()
        }
    }
}

enum TimeDisplay{
    case seconds
    case minutes
    
    static func getTimeString(seconds : Int) -> String{
        let minutes  = getTimeString(seconds: seconds, byTimeDisplay: .minutes)
        let seconds  = getTimeString(seconds: seconds, byTimeDisplay: .seconds)
        return "\(minutes):\(seconds)"
    }
    
    static func getTimeString(seconds : Int, byTimeDisplay : TimeDisplay) -> String{
        return String(format : "%02d", byTimeDisplay == .seconds ? seconds % 60 : seconds / 60 % 60)
    }
    
}

enum TimerState{
    case HAS_NOT_STARTED_YET
    case RUNNING
    case PAUSE
    case CANCELLED
    case DONE
    
    func getStateMedia() -> (text: String, imageName: String){
        var result = (text : "", imageName : "")
        switch self{
        case .DONE:
            result.text = "JUEGO TERMINADO"
            result.imageName = "done"
        case .CANCELLED:
            result.text = "JUEGO CANCELADO"
            result.imageName = "cancel"
        case .HAS_NOT_STARTED_YET:
            result.text = "JUEGO NO HA INICIADO"
            result.imageName = "power"
        case .PAUSE:
            result.text = "JUEGO PAUSADO"
            result.imageName = "pause"
        case . RUNNING:
            result.text = "JUEGO EN CURSO"
            result.imageName = "running"
        }
        return result
    }
}

