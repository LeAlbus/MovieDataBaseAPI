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
    
    let characters = ["Jhon", "Bob", "Ema", "Lucius", "Mary", "Jack", "Harley"]
    static let sharedInstance = CastCollectionViewController()

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: CastCell = collectionView.dequeueReusableCell(withReuseIdentifier: "castCell", for: indexPath) as! CastCell

        cell.setActorData(name: characters[indexPath.row], imagePath: "wololo")
        
        return cell
    }
    
    func setCastData(_ cast: [Dictionary<String, String>] = []){
        
        
    }
    
    
}
