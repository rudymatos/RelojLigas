//
//  ShootingTimerView.swift
//  RelojLigas
//
//  Created by Rudy E Matos on 10/8/17.
//  Copyright © 2017 Bearded Gentleman. All rights reserved.
//

import UIKit

@IBDesignable
class ShootingTimerView: UIView {

    @IBInspectable
    var stText : String = "12 minutos"{
        didSet{
            setNeedsDisplay()
        }
    }
    
    
    @IBInspectable
    var stCurrent : CGFloat = 0{
        didSet{
            setNeedsDisplay()
        }
    }
 
    @IBInspectable
    var stMax : CGFloat = 0{
        didSet{
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        RelojLigaComponents.drawShootingTime(frame: rect, resizing: .aspectFit, shootingSecsCurrentSeconds: stCurrent, shootingSecsMaxSeconds: stMax,shootingTimeText: stText)
    }
    
}
