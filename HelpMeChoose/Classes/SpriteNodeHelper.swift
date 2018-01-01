//
//  SpriteNodeHelper.swift
//  HelpMeChoose
//
//  Created by William Yang on 12/26/17.
//  Copyright © 2017 WMA Games. All rights reserved.
//

import SpriteKit

class SpriteNodeHelper {
   
    public func setupSpriteNode(spriteNode _spriteNode: SKSpriteNode, position _position: CGPoint, anchorPoint _anchorPoint: CGPoint, zPosition _zPosition: CGFloat, scale _scale: CGFloat, name _name: String) {
        _spriteNode.position = _position
        _spriteNode.anchorPoint = _anchorPoint
        _spriteNode.zPosition = _zPosition
        _spriteNode.setScale(_scale)
        _spriteNode.name = _name
    }
    
    public func setupLabelNode(labelNode _labelNode: SKLabelNode, text _text: String, fontColor _fontColor: SKColor, fontSize _fontSize: CGFloat, zPosition _zPosition: CGFloat, horizontalAlignmentMode _horizontalAlignmentMode: SKLabelHorizontalAlignmentMode, verticalAlignmentMode _verticalAlignmentMode: SKLabelVerticalAlignmentMode, position _position: CGPoint) {
        _labelNode.text = _text
        _labelNode.fontColor = _fontColor
        _labelNode.fontSize = _fontSize
        _labelNode.zPosition = _zPosition
        _labelNode.horizontalAlignmentMode = _horizontalAlignmentMode
        _labelNode.verticalAlignmentMode = _verticalAlignmentMode
        _labelNode.position = _position
        
    }

}
