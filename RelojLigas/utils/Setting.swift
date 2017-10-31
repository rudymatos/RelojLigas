//
//  Setting.swift
//  RelojLigas
//
//  Created by Rudy E Matos on 10/8/17.
//  Copyright © 2017 Bearded Gentleman. All rights reserved.
//

import Foundation
import UIKit

struct Setting{
    
    var name : String
    var description : String
    var gameTotalSeconds: CGFloat
    var startShootingCountingAtSecond : CGFloat
    var maxShootingTime : CGFloat
    
    func convertToMinutes(seconds : Int, minimumText : Bool = true) -> String{
        if seconds >= 60{
            return "\(seconds / 60) \(minimumText ? "mins" : "minutos")"
        }else{
            return "\(seconds) \(minimumText ? "secs" : "segundos")"
        }
    }
    
    
    
}
