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
    
    lazy var position1 = CGPoint(x: size.width * CGFloat(1 / (numberOfImages + 1)), y: size.height * 0.25)
    lazy var position2 = CGPoint(x: size.width * CGFloat(2 / (numberOfImages + 1)), y: size.height * 0.25)
    lazy var position3 = CGPoint(x: size.width * CGFloat(3 / (numberOfImages + 1)), y: size.height * 0.25)
    lazy var position4 = CGPoint(x: size.width * CGFloat(4 / (numberOfImages + 1)), y: size.height * 0.25)
    let apple = SKSpriteNode(imageNamed: "apple.png")
    let banana = SKSpriteNode(imageNamed: "banana.jpeg")
    let orange = SKSpriteNode(imageNamed: "orange.jpg")
    let grape = SKSpriteNode(imageNamed: "grapes.jpg")
    lazy var spriteNodeArray: [SKSpriteNode] = [apple, banana, orange, grape]
    var chosenNodeArray: [SKSpriteNode] = []
    let pictureBorder1 = SKSpriteNode()
    let pictureBorder2 = SKSpriteNode()
    let pictureBorder3 = SKSpriteNode()
    let pictureBorder4 = SKSpriteNode()
    let shuffleButton = SKSpriteNode(imageNamed: "Red Button.png")
    let homeButton = SKSpriteNode(imageNamed: "Home Button.png")
    let nextButton = SKSpriteNode(imageNamed: "Next Button.png")
    let pickLabel = SKLabelNode(fontNamed: "Menlo")
    
    let standardAnchorPoint = CGPoint(x: 0.5, y: 0.5)
    var numberOfImages: CGFloat = 3
    lazy var correctImage: String = self.chosenNodeArray[0].name!
    lazy var correctSpriteNode: SKSpriteNode = apple
//    override init() {
//        super.init()
//    }
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    override func didMove(to view: SKView) {
        setupChosenNodeArray()
        setupNodes()
        backgroundColor = SKColor.white
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            let touchedLocation = touch.location(in: self)
            let touchedNode = self.atPoint(touchedLocation)
            
            if touchedNode.name == correctImage {
                pickLabel.text = "Good job!"
                
                banana.removeFromParent()
                orange.removeFromParent()
                grape.removeFromParent()
                pictureBorder2.removeFromParent()
                pictureBorder3.removeFromParent()
                correctSpriteNode.position = CGPoint(x: self.size.width * 0.50, y: self.size.height / 2)
                correctSpriteNode.setScale(0.75)
                pictureBorder1.position = CGPoint(x: correctSpriteNode.position.x, y: correctSpriteNode.position.y)
                
            }
            
            if touchedNode.name == "Shuffle Button" {
                print("Shuffle Button has been pressed")
                shuffle()
            }
            
            if touchedNode.name == "Next Button" {
                print("Next button has been pressed")
                next()
            }
        }
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
    }
    func shuffle() {
        let arrayTest = [position1, position2, position3]
        let shuffled = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: arrayTest) as! [CGPoint]
        chosenNodeArray[0].position = shuffled[0]
        chosenNodeArray[1].position = shuffled[1]
        chosenNodeArray[2].position = shuffled[2]
        
    }
    
    func next() {
        chosenNodeArray.removeAll()
        
        removeAllChildren()
        setupChosenNodeArray()
        
        setupNodes()
    }
    func setupNodes(){
        
        setupSpriteNode(spriteNode: apple, position: position1, anchorPoint: standardAnchorPoint, zPosition : 10, scale: 0.75, name: "Apple")
        setupSpriteNode(spriteNode: banana, position: position1, anchorPoint: standardAnchorPoint, zPosition : 10, scale: 0.75, name: "Banana")
        setupSpriteNode(spriteNode: orange, position: position1, anchorPoint: standardAnchorPoint, zPosition : 10, scale: 0.40, name: "Orange")
        setupSpriteNode(spriteNode: grape, position: position1, anchorPoint: standardAnchorPoint, zPosition: 10, scale: 0.35, name: "Grape")
        
        addChild(chosenNodeArray[0])
        addChild(chosenNodeArray[1])
        addChild(chosenNodeArray[2])
        shuffle()
        
        setupLabelNode(labelNode: pickLabel, text: "Pick \(correctImage)!", fontColor: SKColor.black, fontSize: 150, zPosition: 10, horizontalAlignmentMode: .center, verticalAlignmentMode: .center, position: CGPoint(x: self.size.width / 2, y: self.size.height * 0.75))
        setupSpriteNode(spriteNode: shuffleButton, position: CGPoint(x: self.size.width * 0.9, y: self.size.height * 0.9), anchorPoint: standardAnchorPoint, zPosition: 10, scale: 0.10, name: "Shuffle Button")
        setupSpriteNode(spriteNode: homeButton, position: CGPoint(x: self.size.width * 0.1, y: self.size.height * 0.1), anchorPoint: standardAnchorPoint, zPosition: 10, scale: 0.10, name: "Home Button")
        setupSpriteNode(spriteNode: nextButton, position: CGPoint(x: self.size.width * 0.9, y: self.size.height * 0.1), anchorPoint: standardAnchorPoint, zPosition: 10, scale: 0.10, name: "Next Button")
        addChild(homeButton)
        addChild(nextButton)
        addChild(shuffleButton)
        setupPictureBorders(pictureBorder: pictureBorder1, position: position1)
        setupPictureBorders(pictureBorder: pictureBorder2, position: position2)
        setupPictureBorders(pictureBorder: pictureBorder3, position: position3)
        
        
    }
    
    func setupPictureBorders(pictureBorder: SKSpriteNode, position: CGPoint) {
        // Need to be refactored to be more dynamic
        pictureBorder.position = position
        pictureBorder.zPosition = -20
        pictureBorder.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        let borderSize = CGSize(width: banana.size.width + 100, height: banana.size.height + 100)
        let fillColor = UIColor.clear
        let borderColor = UIColor.black
        // Start UI Graphics
        UIGraphicsBeginImageContextWithOptions(borderSize, false, 0)
        let context = UIGraphicsGetCurrentContext()
        borderColor.setStroke()
        let borderRect = CGRect(origin: .zero, size: CGSize(width: banana.size.width + 100, height: banana.size.height + 100))
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
        pictureBorder.name = "Picture Border"
        pictureBorder.size = borderSize
        addChild(pictureBorder)
        
    }
    
    func setupChosenNodeArray() {
        // Going to have two arrays
        // One will have ALL the items
        // One will just have up to the settings
        // Will choose 3 random
        var uniqueNumbers = Set<Int>()
        
        while(uniqueNumbers.count != Int(numberOfImages))
        {
            uniqueNumbers.insert(Int(arc4random_uniform(UInt32(spriteNodeArray.count)) + 0))
            print(uniqueNumbers)
        }
        
        for number in uniqueNumbers {
            chosenNodeArray.append(spriteNodeArray[number])
            
        }
//        chosenNodeArray.append(apple)
//        chosenNodeArray.append(orange)
//        chosenNodeArray.append(banana)
//        chosenNodeArray.append(grape)
        
    }
    
    
    
    
    // Helper functions
    func setupSpriteNode(spriteNode _spriteNode: SKSpriteNode, position _position: CGPoint, anchorPoint _anchorPoint: CGPoint, zPosition _zPosition: CGFloat, scale _scale: CGFloat, name _name: String) {
        _spriteNode.position = _position
        _spriteNode.anchorPoint = _anchorPoint
        _spriteNode.zPosition = _zPosition
        _spriteNode.setScale(_scale)
        _spriteNode.name = _name
        //addChild(_spriteNode)
        
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
