//
//  ViewController.swift
//  RelojLigas
//
//  Created by Rudy E Matos on 10/3/17.
//  Copyright © 2017 Bearded Gentleman. All rights reserved.
//

import UIKit
import ChameleonFramework

class MainVC: UIViewController{
    
    @IBOutlet weak var expandedConstraint: NSLayoutConstraint!
    @IBOutlet weak var collapseConstraint: NSLayoutConstraint!
    @IBOutlet weak var expandeableView: UIView!
    @IBOutlet weak var gameStatusStack: UIStackView!
    @IBOutlet weak var shootingTimerView: ShootingTimerView!
    @IBOutlet weak var lastMinutesView: LastMinutesView!
    @IBOutlet weak var gameTimeView: GameTimeView!
    @IBOutlet weak var mainTimerLBL: UILabel!
    @IBOutlet weak var settingNameLBL: UILabel!
    @IBOutlet weak var settingDescriptionLBL: UILabel!
    @IBOutlet weak var settingsCounterPageControl: UIPageControl!
    
    var settings = [Setting]()
    var currentSetting = Setting(name : "REGLA POR DEFECTO",description: "REGLA CREADA POR EL SISTEMA",gameTotalSeconds: 30,startShootingCountingAtSecond: 10,maxShootingTime: 5)
    private var isMenuExpanded = false
    private var timerManager : TimerManager?
    private var currentShootingSeconds = CGFloat.init(0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    @objc private func resetTimer(longPressRecognizer : UILongPressGestureRecognizer){
        if let timerManager = timerManager, longPressRecognizer.state == .began && timerManager.shouldResetCounters(){
            
        }
    }
    
    @objc private func triggerSecondaryAction(){
        if timerManager?.getTimerCurrentState() != .DONE {
            if currentSetting.gameTotalSeconds < currentSetting.startShootingCountingAtSecond{
                if currentSetting.gameTotalSeconds > currentSetting.maxShootingTime{
                    currentShootingSeconds = currentSetting.maxShootingTime - 0.01
                }else{
                    currentShootingSeconds = currentSetting.gameTotalSeconds
                }
                shootingTimerView.stCurrent = currentShootingSeconds
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectSettingSegue"{
            let destinationVC = segue.destination as! SelectSettingDialogVC
            destinationVC.settings = settings
        }
    }
    
    private func handleShootingTimer(){
        currentShootingSeconds -= 1
        if currentSetting.gameTotalSeconds > currentSetting.maxShootingTime{
            if currentShootingSeconds <= 0 {
                currentShootingSeconds = currentSetting.maxShootingTime - 0.01
            }
        }else if currentShootingSeconds <= 0 {
            currentShootingSeconds = currentSetting.gameTotalSeconds
        }
        shootingTimerView.stCurrent = currentShootingSeconds
    }
    
    @IBAction func toggleView(_ sender: UIButton) {
        isMenuExpanded = !isMenuExpanded
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.collapseConstraint.priority  = UILayoutPriority(rawValue: UILayoutPriority.RawValue(self.isMenuExpanded ? 1 : 999))
            self.expandedConstraint.priority = UILayoutPriority(rawValue: UILayoutPriority.RawValue(self.isMenuExpanded ? 999 : 1))
            self.view.layoutIfNeeded()
        }) { (completed) in
            print("pause the timer if is running")
        }
    }
    
    private func handleLastMinutesTimer(){
        if currentSetting.gameTotalSeconds < currentSetting.startShootingCountingAtSecond{
            lastMinutesView.swCurrent = currentSetting.gameTotalSeconds
            handleShootingTimer()
        }
    }
    
    private func handleCounterStateAnimation(timerState: TimerState){
        let counterStateStack = gameStatusStack.subviews[1] as! UIStackView
        UIView.animate(withDuration: 0.2, animations: {
            counterStateStack.transform = CGAffineTransform(translationX: counterStateStack.bounds.origin.x + 200, y:counterStateStack.bounds.origin.y)
        }) { (completed) in
            (counterStateStack.subviews[0] as! UIImageView).image = UIImage(named: timerState.getStateMedia().imageName)
            (counterStateStack.subviews[1] as! UILabel).text = timerState.getStateMedia().text
            UIView.animate(withDuration: 0.3, animations: {
                counterStateStack.transform = CGAffineTransform.identity
            })
        }
    }
    
    
    
    @objc private func triggerAction(){
        
        if let timerManager = timerManager {
            let timerState = timerManager.getTimerCurrentState()
            switch(timerState){
            case .HAS_NOT_STARTED_YET, .PAUSE:
                self.handleCounterStateAnimation(timerState: .RUNNING)
                timerManager.startTimer {
                    self.currentSetting.gameTotalSeconds -= 1
                    if self.currentSetting.gameTotalSeconds >= 0 {
                        self.gameTimeView.swCurrent = self.currentSetting.gameTotalSeconds
                        self.mainTimerLBL.text = TimeDisplay.getTimeString(seconds: Int(self.currentSetting.gameTotalSeconds))
                        self.handleLastMinutesTimer()
                    }else{
                        self.handleCounterStateAnimation(timerState : .DONE)
                        timerManager.pauseEndTimer(timerState: .DONE) {
                            //PLAY SOUNDS
                        }
                    }
                }
            case .DONE:
                print("show dialog asking for new timer to start with same setting. If not, open up expandable menu")
            default:
                self.handleCounterStateAnimation(timerState : .PAUSE)
                timerManager.pauseEndTimer(timerState: .PAUSE) {
                    
                }
            }
        }
    }
    
    func configureView(){
        timerManager = TimerManager()
        self.view.backgroundColor = GradientColor(gradientStyle: .topToBottom, frame: self.view.bounds, colors: [UIColor.flatNavyBlue(), UIColor.flatWhiteColorDark()])
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(MainVC.triggerAction))
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(MainVC.triggerSecondaryAction))
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(MainVC.resetTimer(longPressRecognizer:)))
        
        doubleTapGesture.numberOfTapsRequired = 2
        tapGesture.require(toFail: doubleTapGesture)
        
        generateSettings()
        
        gameTimeView.swCurrent = currentSetting.gameTotalSeconds - 0.01
        gameTimeView.swMax = currentSetting.gameTotalSeconds
        
        shootingTimerView.stCurrent = currentSetting.maxShootingTime - 0.01
        currentShootingSeconds = currentSetting.maxShootingTime
        shootingTimerView.stMax = currentSetting.maxShootingTime
        
        lastMinutesView.swCurrent = currentSetting.startShootingCountingAtSecond - 0.01
        lastMinutesView.mtscMax = currentSetting.startShootingCountingAtSecond
        
        settingNameLBL.text = currentSetting.name
        settingDescriptionLBL.text = currentSetting.description
        
        settingsCounterPageControl.numberOfPages = settings.count 
        
        view.addGestureRecognizer(tapGesture)
        view.addGestureRecognizer(doubleTapGesture)
        view.addGestureRecognizer(longPressGesture)
        
        
    }
    
    func generateSettings(){
        settings.append(Setting(name : "LIGA SHARKS REGLA 1",
                                description: "MENOS DE 15 JUGADORES EN ESPERA",
                                gameTotalSeconds: 720,
                                startShootingCountingAtSecond: 120,
                                maxShootingTime: 20))
        
        
        settings.append(Setting(name : "LIGA SHARKS REGLA 2",
                                description: "ENTRE 15 Y 20 JUGADORES EN ESPERA",
                                gameTotalSeconds: 600,
                                startShootingCountingAtSecond: 120,
                                maxShootingTime: 20))
        
        
        settings.append(Setting(name : "LIGA SHARKS REGLA 3",
                                description: "MAS DE 20 JUGADORES EN ESPERA",
                                gameTotalSeconds: 600,
                                startShootingCountingAtSecond: 60,
                                maxShootingTime: 20))
        
    }
    
    
    
}

