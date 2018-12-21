//
//  ScheduledWalkthroughController+CollectionViewDelegate.swift
//  CanLove
//
//  Created by Alex on 11/12/18.
//  Copyright © 2018 Techlatam. All rights reserved.
//

import Foundation
import UIKit

extension ScheduledWalkthroughController: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myDogs.count > 0 ? myDogs.count : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let canTypeCollectionCell = petsCollectionView.dequeueReusableCell(withReuseIdentifier: K.cellsIdentifiers.collection.choosePetCollectionCell, for: indexPath) as? ChoosePetCollectionCell else { return UICollectionViewCell() }
        if myDogs.count > 0{
            canTypeCollectionCell.setMyPet = myDogs[indexPath.row]
        }
        return canTypeCollectionCell
    }
    
    
    
}
