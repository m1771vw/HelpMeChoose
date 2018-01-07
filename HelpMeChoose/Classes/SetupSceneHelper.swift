//
//  SetupSceneHelper.swift
//  HelpMeChoose
//
//  Created by William Yang on 1/5/18.
//  Copyright © 2018 WMA Games. All rights reserved.
//

import SpriteKit

class SetupSceneHelper {
    
    func setupChosenNodeArray(chosenNodeArray _chosenNodeArray: inout [SKSpriteNode], spriteNodeArray _spriteNodeArray: [SKSpriteNode], numberOfImages _numberOfImages: CGFloat) {
        
        var uniqueNumbers = Set<Int>()
        
        while(uniqueNumbers.count != Int(_numberOfImages))
        {
            uniqueNumbers.insert(Int(arc4random_uniform(UInt32(_spriteNodeArray.count)) + 0))
        }
        print(uniqueNumbers)
        for number in uniqueNumbers {
            _chosenNodeArray.append(_spriteNodeArray[number])
        }
    }
    
    func setupPictureBorders(scene: SKScene, pictureBorderNode _pictureBorderNode: SKSpriteNode, pictureBorder _pictureBorder: SKSpriteNode, position _position: CGPoint, numberOfImages _numberOfImages: CGFloat) {
        // Need to be refactored to be more dynamic
        _pictureBorder.position = _position
        _pictureBorder.zPosition = -20
        _pictureBorder.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        let borderSize = CGSize(width: _pictureBorderNode.size.width * CGFloat(1 + (1 / (_numberOfImages + 1))), height: _pictureBorderNode.size.height * CGFloat(1 + (1 / (_numberOfImages + 1))))
        let fillColor = UIColor.clear
        let borderColor = UIColor.black
        // Start UI Graphics
        UIGraphicsBeginImageContextWithOptions(borderSize, false, 0)
        let context = UIGraphicsGetCurrentContext()
        borderColor.setStroke()
        let borderRect = CGRect(origin: .zero, size: CGSize(width: _pictureBorderNode.size.width * CGFloat(1 + (1 / (_numberOfImages + 1))), height: _pictureBorderNode.size.height * CGFloat(1 + (1 / (_numberOfImages + 1)))))
        context!.stroke(borderRect, width: 3)
        fillColor.setFill()
        let barWidth = (borderSize.width)
        let barRect = CGRect(x: 0.5, y: 0.5, width: barWidth, height: borderSize.height - 1)
        context!.fill(barRect)
        // extract image
        let spriteImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        // set sprite texture and size
        _pictureBorder.texture = SKTexture(image: spriteImage!)
        _pictureBorder.name = "Picture Border"
        _pictureBorder.size = borderSize
        scene.addChild(_pictureBorder)
        
    }
}
