//
//  SettingCVCCollectionViewCell.swift
//  RelojLigas
//
//  Created by Rudy E Matos on 10/28/17.
//  Copyright © 2017 Bearded Gentleman. All rights reserved.
//

import UIKit

protocol SettingOperationDelegate{
    func edit(currentSetting: Setting)
    func use(currentSetting: Setting)
}

class CurrentSettingCVC: UICollectionViewCell {
    
    @IBOutlet weak var mainShadowViewCard: UIView!
    @IBOutlet weak var mainViewCard: UIView!
    @IBOutlet weak var settingNameLBL: UILabel!
    @IBOutlet weak var settingDetailsLBL: UILabel!
    @IBOutlet weak var settingDescriptionLBL: UILabel!
    @IBOutlet weak var gameTimeLBL: UILabel!
    @IBOutlet weak var startShootingCounterAtMinutesLBL: UILabel!
    @IBOutlet weak var shotClockLBL: UILabel!
    @IBOutlet weak var useSettingBTN: UIButton!
    @IBOutlet weak var editSettingBTN: UIButton!
    var delegate : SettingOperationDelegate?
    
    var currentSetting: Setting?{
        didSet{
            configureView()
        }
    }
    
    func configureView(){
        mainViewCard.layer.cornerRadius = 10
        mainViewCard.layer.borderWidth = 0.3
        mainViewCard.layer.borderColor = UIColor.black.cgColor
        mainViewCard.layer.masksToBounds = true
        useSettingBTN.layer.cornerRadius = 10
        editSettingBTN.layer.cornerRadius = 10
        
        mainShadowViewCard.layer.shadowColor = UIColor.black.cgColor
        mainShadowViewCard.layer.shadowOpacity = 0.7
        mainShadowViewCard.layer.shadowRadius = 4.0
        mainShadowViewCard.layer.shadowOffset = CGSize(width: 3, height: 3)
        mainShadowViewCard.layer.masksToBounds = false
        
        if let currentSetting = currentSetting{
            settingNameLBL.text = currentSetting.name
            settingDescriptionLBL.text = currentSetting.description
            gameTimeLBL.text = " \(currentSetting.convertToMinutes(seconds: Int(currentSetting.gameTotalSeconds))) "
            startShootingCounterAtMinutesLBL.text = " \(currentSetting.convertToMinutes(seconds: Int(currentSetting.startShootingCountingAtSecond))) "
            shotClockLBL.text =  " \(currentSetting.convertToMinutes(seconds: Int(currentSetting.maxShootingTime))) "
            
            settingDetailsLBL.text = "En este modo los jugadores tienen \(currentSetting.convertToMinutes(seconds: Int(currentSetting.gameTotalSeconds),minimumText: false)) de juego donde se empezara el reloj de tiro en los ultimos \(currentSetting.convertToMinutes(seconds: Int(currentSetting.startShootingCountingAtSecond),minimumText: false)) restantes del partido y se le otorgaran \(currentSetting.convertToMinutes(seconds: Int(currentSetting.maxShootingTime),minimumText: false)) a cada equipo por posesion "
            
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
