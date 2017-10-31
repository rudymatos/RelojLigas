//
//  LastMinutesView.swift
//  RelojLigas
//
//  Created by Rudy E Matos on 10/8/17.
//  Copyright © 2017 Bearded Gentleman. All rights reserved.
//

import UIKit

@IBDesignable
class LastMinutesView: UIView {

    @IBInspectable
    var lmText : String = "a los 2 minutos"{
        didSet{
            setNeedsDisplay()
        }
    }
    
    
    @IBInspectable
    var swCurrent : CGFloat = 0{
        didSet{
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var mtscMax : CGFloat = 0{
        didSet{
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        RelojLigaComponents.drawMinutesToStartCounting(frame: rect, resizing: .aspectFit, stopWatchCurrentSeconds: swCurrent, minutesToStartCountingMaxSeconds: mtscMax,minutesToStartCountingText: lmText)
    }
    
}
