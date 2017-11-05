//
//  ConfirmationDialogVC.swift
//  RelojLigas
//
//  Created by Rudy E Matos on 10/30/17.
//  Copyright © 2017 Bearded Gentleman. All rights reserved.
//

import UIKit
import ChameleonFramework

class ConfirmationDialogVC: UIViewController {
    
    @IBOutlet weak var mainShadowView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var yesDialogButtonView: UIView!
    @IBOutlet weak var noDialogButtonView: UIView!
    
    var currentColorSetting : ColorSetting?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    @IBAction func dismissCurrentView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    
    }
    fileprivate func addAlarmIV() {
        let alarmIconImage = UIImage(named: "alarm_icon")
        let y = mainShadowView.frame.minY - 30
        let x =  self.view.bounds.width / 2 - (258 / 2)
        
        let imageFrame = CGRect(x: x, y: y, width: 258, height: 265)
        let imageView = UIImageView(frame: imageFrame)
        imageView.image = alarmIconImage
        self.view.addSubview(imageView)
    }
    
    func configureView(){
        
        let initialColor = UIColor(hexString: "35C9F4")
        let finalColor = UIColor(hexString:"D8F650")
        let bgColor = UIColor(hexString:"425BFB")
        currentColorSetting = ColorSetting(initialGradientColor: initialColor!, finalGradientColor: finalColor!, backgroundColor: bgColor!)
        
        gradientView.backgroundColor = GradientColor(gradientStyle: .topToBottom, frame: gradientView.bounds, colors: [(currentColorSetting?.initialGradientColor)!, (currentColorSetting?.finalGradientColor)!])

        mainShadowView.layer.shadowColor = UIColor.black.cgColor
        mainShadowView.layer.shadowOffset = CGSize(width: 3, height: 3)
        mainShadowView.layer.shadowRadius = 4
        mainShadowView.layer.shadowOpacity = 0.7
        mainShadowView.layer.masksToBounds = false

        mainView.layer.cornerRadius = 10
        mainView.layer.masksToBounds = true

        yesDialogButtonView.layer.borderColor = UIColor(hexString: "455D71").cgColor
        yesDialogButtonView.layer.borderWidth = 0.6
        yesDialogButtonView.layer.cornerRadius = 16
        yesDialogButtonView.layer.masksToBounds = true
        
        
        noDialogButtonView.layer.borderColor = UIColor(hexString: "D3D3D3").cgColor
        noDialogButtonView.layer.borderWidth = 0.6
        noDialogButtonView.layer.cornerRadius = 16
        noDialogButtonView.layer.masksToBounds = true
        addAlarmIV()
        
    }

  
    
    @IBAction func dismissDialog(_ sender: UIButton) {
    }
    
    @IBAction func initTimer(_ sender: UIButton) {
    }
}
