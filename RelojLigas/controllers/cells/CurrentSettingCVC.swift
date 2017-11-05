//
//  SettingCVCCollectionViewCell.swift
//  RelojLigas
//
//  Created by Rudy E Matos on 10/28/17.
//  Copyright © 2017 Bearded Gentleman. All rights reserved.
//

import UIKit
import ChameleonFramework

protocol SettingOperationDelegate{
    func edit(currentSetting: Setting)
    func use(currentSetting: Setting)
}

class CurrentSettingCVC: UICollectionViewCell {
    
    @IBOutlet weak var cardShadowView: UIView!
    @IBOutlet weak var cardMainView: UIView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var settingDescriptionLBL: UILabel!
    @IBOutlet weak var timesUsedLBL: UILabel!
    @IBOutlet weak var settingTitleLBL: UILabel!
    @IBOutlet weak var gameTimeLBL: UILabel!
    @IBOutlet weak var startShootingTimeLBL: UILabel!
    @IBOutlet weak var shootingTimeLBL: UILabel!
    
    @IBOutlet weak var editConfigurationView: UIView!
    @IBOutlet weak var useConfigurationView: UIView!
    var delegate : SettingOperationDelegate?
    
    var currentSetting: Setting?{
        didSet{
            configureView()
        }
    }
    
    func configureView(){
        
        cardShadowView.layer.shadowColor = UIColor.black.cgColor
        cardShadowView.layer.shadowOffset = CGSize(width: 3, height: 3)
        cardShadowView.layer.shadowRadius = 4
        cardShadowView.layer.shadowOpacity = 0.7
        cardShadowView.layer.masksToBounds = false
        
        
        cardMainView.layer.cornerRadius = 15
        cardMainView.layer.masksToBounds = true
        
        let initialColor = UIColor(hexString: "35C9F4")
        let finalColor = UIColor(hexString:"D8F650")
        let bgColor = UIColor(hexString:"425BFB")
        let currentColorSetting = ColorSetting(initialGradientColor: initialColor!, finalGradientColor: finalColor!, backgroundColor: bgColor!)
        
        gradientView.backgroundColor = GradientColor(gradientStyle: .topToBottom, frame: gradientView.bounds, colors: [currentColorSetting.initialGradientColor, currentColorSetting.finalGradientColor])
        gradientView.layer.borderWidth = 0
        
        editConfigurationView.layer.cornerRadius = 16
        editConfigurationView.layer.borderWidth = 0.5
        editConfigurationView.layer.borderColor = UIColor.white.cgColor
        
        useConfigurationView.layer.cornerRadius = 21
        useConfigurationView.layer.borderColor = UIColor.blue.cgColor
        useConfigurationView.layer.borderWidth = 0.5

        
        if let currentSetting = currentSetting{
            settingTitleLBL.text = currentSetting.name
            let descriptionText = "En este modo los jugadores tienen \(currentSetting.convertToMinutes(seconds: Int(currentSetting.gameTotalSeconds),minimumText: false)) de juego donde se empezara el reloj de tiro en los ultimos \(currentSetting.convertToMinutes(seconds: Int(currentSetting.startShootingCountingAtSecond),minimumText: false)) restantes del partido y se le otorgaran \(currentSetting.convertToMinutes(seconds: Int(currentSetting.maxShootingTime),minimumText: false)) a cada equipo por posesion "
            settingDescriptionLBL.text = descriptionText
            gameTimeLBL.text = currentSetting.convertToMinutes(seconds: Int(currentSetting.gameTotalSeconds))
            startShootingTimeLBL.text = currentSetting.convertToMinutes(seconds: Int(currentSetting.startShootingCountingAtSecond))
            shootingTimeLBL.text = currentSetting.convertToMinutes(seconds: Int(currentSetting.maxShootingTime))
        }
    }
    
    
    
    
    @IBAction func editCurrentSetting(_ sender: UIButton) {
        if let currentSetting = currentSetting{
            delegate?.edit(currentSetting: currentSetting)
        }
    }
    
    @IBAction func useCurrentSetting(_ sender: UIButton) {
        if let currentSetting = currentSetting{
            delegate?.use(currentSetting: currentSetting)
        }
    }
    
}
