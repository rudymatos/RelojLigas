//
//  SelectSettingDialogVC.swift
//  RelojLigas
//
//  Created by Rudy E Matos on 11/4/17.
//  Copyright © 2017 Bearded Gentleman. All rights reserved.
//

import UIKit

class SelectSettingDialogVC: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource, SettingOperationDelegate {
    
    @IBOutlet weak var bgColor: UIView?
    @IBOutlet weak var currentSettingPageControl: UIPageControl?
    
    var settings : [Setting]?{
        didSet{
            configureView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func edit(currentSetting: Setting) {
        print("editing \(currentSetting.name)")
    }
    
    func use(currentSetting: Setting) {
        print("using \(currentSetting.name)")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        currentSettingPageControl?.currentPage = indexPath.row
        //Change this depending on the index
        
        let colorStrings = ["425BFB", "8858FB","FDB92C"]
        let currentColorString = arc4random_uniform(UInt32(colorStrings.count))
        let backgroundColor = UIColor(hexString: colorStrings[Int(currentColorString)])
        
        UIView.animate(withDuration: 0.3) {
            self.bgColor?.backgroundColor = backgroundColor
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let additionalSpace = self.view.frame.width - 326
        return additionalSpace
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let additionalSpace = (self.view.frame.width - 326) / 2
        return UIEdgeInsetsMake(0, additionalSpace, 0, additionalSpace)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "currentSettingCVC", for: indexPath) as! CurrentSettingCVC
        cell.currentSetting = settings?[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings?.count ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func configureView(){
        bgColor?.backgroundColor = UIColor.green
        currentSettingPageControl?.numberOfPages = settings?.count ?? 0
        
    }
}
