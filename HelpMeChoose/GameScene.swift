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
    
    lazy var position1 = CGPoint(x: size.width * 0.20, y: size.height * 0.25)
    lazy var position2 = CGPoint(x: size.width * 0.40, y: size.height * 0.25)
    lazy var position3 = CGPoint(x: size.width * 0.60, y: size.height * 0.25)
    lazy var position4 = CGPoint(x: size.width * 0.80, y: size.height * 0.35)
    let apple = SKSpriteNode(imageNamed: "apple.png")
    let banana = SKSpriteNode(imageNamed: "banana.jpeg")
    let orange = SKSpriteNode(imageNamed: "orange.jpg")
    let grape = SKSpriteNode(imageNamed: "grape.jpg")
    let pictureBorder = SKSpriteNode()
    let shuffleButton = SKSpriteNode(imageNamed: "Red Button.png")
    let homeButton = SKSpriteNode(imageNamed: "Home Button.png")
    let nextButton = SKSpriteNode(imageNamed: "Next Button.png")
    let label1 = SKLabelNode(fontNamed: "Menlo")
    
    let standardAnchorPoint = CGPoint(x: 0.5, y: 0.5)
    let numberOfImages = 3
    
//    override init(size: CGSize) {
//        super.init()
//    }
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
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
                
                banana.removeFromParent()
                orange.removeFromParent()
                apple.position = CGPoint(x: self.size.width * 0.50, y: self.size.height / 2)
                apple.setScale(0.75)
                pictureBorder.position = CGPoint(x: apple.position.x, y: apple.position.y)
                
            }
            
            if touchedNode.name == "Shuffle Button" {
                print("Shuffle Button has been pressed")
                shuffle()
            }
        }
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
    }
    func shuffle() {
        let arrayTest = [position1, position2, position3]
        let shuffled = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: arrayTest) as! [CGPoint]
        apple.position = shuffled[0]
        banana.position = shuffled[1]
        orange.position = shuffled[2]
        
    }
    func setupNodes(){
    
        setupSpriteNode(spriteNode: apple, position: position1, anchorPoint: standardAnchorPoint, zPosition : 10, scale: 0.75, name : "Apple")
        setupSpriteNode(spriteNode: banana, position: position2, anchorPoint: standardAnchorPoint, zPosition : 10, scale: 0.75, name : "Banana")
        setupSpriteNode(spriteNode: orange, position: position3, anchorPoint: standardAnchorPoint, zPosition : 10, scale: 0.50, name : "Orange")
        setupSpriteNode(spriteNode: grape, position: position4, anchorPoint: standardAnchorPoint, zPosition: 10, scale: 0.50, name: "Grape")
        setupLabelNode(labelNode: label1, text: "Pick Apple!", fontColor: SKColor.black, fontSize: 150, zPosition: 10, horizontalAlignmentMode: .center, verticalAlignmentMode: .center, position: CGPoint(x: self.size.width / 2, y: self.size.height * 0.75))
        setupSpriteNode(spriteNode: shuffleButton, position: CGPoint(x: self.size.width * 0.9, y: self.size.height * 0.9), anchorPoint: standardAnchorPoint, zPosition: 10, scale: 0.10, name: "Shuffle Button")
        setupSpriteNode(spriteNode: homeButton, position: CGPoint(x: self.size.width * 0.1, y: self.size.height * 0.1), anchorPoint: standardAnchorPoint, zPosition: 10, scale: 0.10, name: "Home Button")
        setupSpriteNode(spriteNode: nextButton, position: CGPoint(x: self.size.width * 0.9, y: self.size.height * 0.1), anchorPoint: standardAnchorPoint, zPosition: 10, scale: 0.10, name: "Next Button")
        setupPictureBorders()
        
    }
    
    func setupPictureBorders() {
        // Need to be refactored to be more dynamic
        pictureBorder.position = CGPoint(x: apple.position.x, y: apple.position.y)
        pictureBorder.zPosition = -20
        pictureBorder.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        let borderSize = CGSize(width: apple.size.width + 100, height: apple.size.height + 100)
        let fillColor = UIColor.clear
        let borderColor = UIColor.black
        
        // Start UI Graphics
        UIGraphicsBeginImageContextWithOptions(borderSize, false, 0)
        let context = UIGraphicsGetCurrentContext()
        borderColor.setStroke()
        let borderRect = CGRect(origin: .zero, size: CGSize(width: apple.size.width + 100, height: apple.size.height + 100))
        context!.stroke(borderRect, width: 3)
        fillColor.setFill()
        let barWidth = (borderSize.width)
        let barRect = CGRect(x: 0.5, y: 0.5, width: barWidth, height: borderSize.height - 1)
        context!.fill(barRect)
        // extract image
        let spriteImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        // set sprite texture and size
        pictureBorder.texture = SKTexture(image: spriteImage!)
        pictureBorder.size = borderSize
        addChild(pictureBorder)
    }
    
    // Helper functions
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
