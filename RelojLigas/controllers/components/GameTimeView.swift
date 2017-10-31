//
//  GameTimeView.swift
//  RelojLigas
//
//  Created by Rudy E Matos on 10/8/17.
//  Copyright © 2017 Bearded Gentleman. All rights reserved.
//

import UIKit

@IBDesignable
class GameTimeView: UIView {

    
    @IBInspectable
    var gtText : String = "12 minutos"{
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
    var swMax : CGFloat = 0{
        didSet{
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        RelojLigaComponents.drawGameTime(frame: rect, resizing: .aspectFit, stopWatchCurrentSeconds: swCurrent, stopWatchMaxSeconds: swMax, stopWatchText: gtText)
    }
    

}
