//
//  CastCollectionViewController.swift
//  TMD Catalogue
//
//  Created by Pedro Lopes on 10/03/18.
//  Copyright © 2018 Pedro Lopes. All rights reserved.
//

import Foundation
import UIKit

class CastCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
 
    var castData: [CastBaseData] = []

    static let sharedInstance = CastCollectionViewController()

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.castData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: CastCell = collectionView.dequeueReusableCell(withReuseIdentifier: "castCell", for: indexPath) as! CastCell

        let castPicture = "\(posterURL)\(self.castData[indexPath.row].profilePic!)"
        
        cell.setActorData(name: self.castData[indexPath.row].name, character: self.castData[indexPath.row].character, imagePath: castPicture)
        
        return cell
    }
    
    func setCastData(_ cast: [CastBaseData] = []){
        
        var fixedCastList = cast
        
        for (index, object) in fixedCastList.enumerated().reversed(){
            if object.profilePic == nil{
                fixedCastList.remove(at: index)
            }
        }
        
        self.castData = fixedCastList
        
    }
    
    
}
