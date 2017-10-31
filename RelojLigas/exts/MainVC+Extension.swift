//
//  MainVC+Extension.swift
//  RelojLigas
//
//  Created by Rudy E Matos on 10/28/17.
//  Copyright © 2017 Bearded Gentleman. All rights reserved.
//

import Foundation
import UIKit

extension MainVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SettingOperationDelegate{
    func edit(currentSetting: Setting) {
        print("editing \(currentSetting.name)")
    }
    
    func use(currentSetting: Setting) {
        print("using \(currentSetting.name)")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        settingsCounterPageControl.currentPage = indexPath.row
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let additionalSpace = self.view.frame.width - 288
        return additionalSpace
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let additionalSpace = (self.view.frame.width - 288) / 2
        return UIEdgeInsetsMake(0, additionalSpace, 0, additionalSpace)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "currentSettingCVC", for: indexPath) as! CurrentSettingCVC
        cell.currentSetting = settings[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
}
