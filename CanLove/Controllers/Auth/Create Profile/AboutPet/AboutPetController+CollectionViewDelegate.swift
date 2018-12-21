//
//  AboutPetController+CollectionViewDelegate.swift
//  CanLove
//
//  Created by Alex on 26/10/18.
//  Copyright © 2018 Techlatam. All rights reserved.
//

import Foundation
import UIKit

extension AboutPetController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    //--Collectionview methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count = Int()
        switch collectionView {
        case sizeCollectionView:
            count = selectedBreed.count > 0 ? selectedBreed.count : 0
        case canTypeCollectionView:
            count = selectedListBreed.count > 0 ? selectedListBreed.count : 0
        default:
            print("error")
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell : UICollectionViewCell!
        
        
        switch collectionView {
        case sizeCollectionView:
            
            //canSizeCollectionCell
             guard let canSizeCollectionCell = sizeCollectionView.dequeueReusableCell(withReuseIdentifier: K.cellsIdentifiers.collection.canSizeCollectionCell, for: indexPath) as? CanSizeCollectionCell else { return UICollectionViewCell() }
             
             if selectedBreed.count > 0{
                canSizeCollectionCell.setBreed = selectedBreed[indexPath.row]
                cell = canSizeCollectionCell
             }
            
        case canTypeCollectionView:
            
            //canTypeCollectionCell
            guard let canTypeCollectionCell = canTypeCollectionView.dequeueReusableCell(withReuseIdentifier: K.cellsIdentifiers.collection.canTypeCollectionCell, for: indexPath) as? CanTypeCollectionCell else { return UICollectionViewCell() }
            if selectedListBreed.count > 0{
                canTypeCollectionCell.setBreed = selectedListBreed[indexPath.row]
                cell = canTypeCollectionCell
            }
            
        default:
            print("Error")
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        switch collectionView {
            
        case sizeCollectionView:
            
            let listBreed = selectedBreed[indexPath.row].listBreeds
            selectedListBreed = listBreed
            canTypeCollectionView.reloadData()
            
        case canTypeCollectionView:
            
            guard lastSelectedIndexPath != indexPath else {
                return
            }
            
            if lastSelectedIndexPath != nil {
                canTypeCollectionView.deselectItem(at: lastSelectedIndexPath!, animated: false)
            }
            if selectedListBreed.count > 0{
                let breed = selectedListBreed[indexPath.row]
                breedID = breed.id
            }
            
        default:
            print("Error")
        }
        
    }
    


    
    
}
