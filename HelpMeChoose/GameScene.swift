//
//  GameScene.swift
//  HelpMeChoose
//
//  Created by William Yang on 12/12/17.
//  Copyright © 2017 WMA Games. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    let picture1 = SKSpriteNode(imageNamed: "apple.png")
    let picture2 = SKSpriteNode(imageNamed: "banana.jpeg")
    let picture3 = SKSpriteNode(imageNamed: "orange.jpg")
    let label1 = SKLabelNode(fontNamed: "Menlo")
    
    override func didMove(to view: SKView) {
        setupNodes()
        backgroundColor = SKColor.white
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            let touchedLocation = touch.location(in: self)
            let touchedNode = self.atPoint(touchedLocation)
            
            if touchedNode.name == "Apple" {
                label1.text = "Good job!"
                picture2.removeFromParent()
                picture3.removeFromParent()
                picture1.position = CGPoint(x: self.size.width * 0.50, y: self.size.height / 2)
                picture1.setScale(0.75)
            }
        }
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    func setupNodes(){
        setupSpriteNode(spriteNode: picture1, position: CGPoint(x: self.size.width * 0.25, y: self.size.height / 2), anchorPoint: CGPoint(x: 0.5, y: 0.5), zPosition : 10, scale: 0.75, name : "Apple")
        setupSpriteNode(spriteNode: picture2, position: CGPoint(x: self.size.width * 0.50, y: self.size.height / 2), anchorPoint: CGPoint(x: 0.5, y: 0.5), zPosition : 10, scale: 0.75, name : "Banana")
        setupSpriteNode(spriteNode: picture3, position: CGPoint(x: self.size.width * 0.75, y: self.size.height / 2), anchorPoint: CGPoint(x: 0.5, y: 0.5), zPosition : 10, scale: 0.50, name : "Orange")
        setupLabelNode(labelNode: label1, text: "Pick Apple!", fontColor: SKColor.black, fontSize: 150, zPosition: 10, horizontalAlignmentMode: .center, verticalAlignmentMode: .center, position: CGPoint(x: self.size.width / 2, y: self.size.height * 0.75))
    }
    
    func setupSpriteNode(spriteNode _spriteNode: SKSpriteNode, position _position: CGPoint, anchorPoint _anchorPoint: CGPoint, zPosition _zPosition: CGFloat, scale _scale: CGFloat, name _name: String) {
        _spriteNode.position = _position
        _spriteNode.anchorPoint = _anchorPoint
        _spriteNode.zPosition = _zPosition
        _spriteNode.setScale(_scale)
        _spriteNode.name = _name
        addChild(_spriteNode)
        
    }
    
    func setupLabelNode(labelNode _labelNode: SKLabelNode, text _text: String, fontColor _fontColor: SKColor, fontSize _fontSize: CGFloat, zPosition _zPosition: CGFloat, horizontalAlignmentMode _horizontalAlignmentMode: SKLabelHorizontalAlignmentMode, verticalAlignmentMode _verticalAlignmentMode: SKLabelVerticalAlignmentMode, position _position: CGPoint) {
        _labelNode.text = _text
        _labelNode.fontColor = _fontColor
        _labelNode.fontSize = _fontSize
        _labelNode.zPosition = _zPosition
        _labelNode.horizontalAlignmentMode = _horizontalAlignmentMode
        _labelNode.verticalAlignmentMode = _verticalAlignmentMode
        _labelNode.position = _position
        addChild(_labelNode)
    }
}
