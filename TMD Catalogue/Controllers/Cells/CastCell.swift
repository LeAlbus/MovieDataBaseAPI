//
//  CastCell.swift
//  TMD Catalogue
//
//  Created by Pedro Lopes on 11/03/18.
//  Copyright © 2018 Pedro Lopes. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage


class CastCell: UICollectionViewCell{
    
    
    @IBOutlet weak var castName: UILabel!
    @IBOutlet weak var castPicture: UIImageView!
    
    func setActorData(name: String, character: String, imagePath: String){
        
        self.castName.text = "\(name) as \(character)"
        self.castName.sizeToFit()
        let placeholderImage = UIImage(named: "PlaceholderPoster")!
        self.castPicture.af_setImage(withURL: URL(string: imagePath)!, placeholderImage: placeholderImage)
    }
}
