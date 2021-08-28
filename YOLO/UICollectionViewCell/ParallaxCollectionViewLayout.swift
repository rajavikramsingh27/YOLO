//
//  qqqqq.swift
//  YOLO
//
//  Created by Boons&Blessings Apps on 21/11/20.
//  Copyright © 2020 Boons&Blessings Apps. All rights reserved.
//

import Foundation
import UIKit

class ParallaxCollectionViewLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return super.layoutAttributesForElements(in: rect)?.flatMap { $0.copy() as? UICollectionViewLayoutAttributes }.flatMap(addParallaxToAttributes)
    }
    
    // We need to return true here so that everytime we scroll the collection view, the attributes are updated.
    override public func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    private func addParallaxToAttributes(_ attributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        guard let collectionView = self.collectionView else { return attributes }
        
        let width = collectionView.frame.width
        let centerX = width / 2
        let offset = collectionView.contentOffset.x
        let itemX = attributes.center.x - offset
        let position = (itemX - centerX) / width
        let contentView = collectionView.cellForItem(at: attributes.indexPath)?.contentView
        
        if abs(position) >= 1 {
            contentView?.transform = .identity
        } else {
            let transitionX = -(width * 0.5 * position)
            contentView?.transform = CGAffineTransform(translationX: transitionX, y: 0)
        }
        
        return attributes
    }
}
