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
    lazy var spriteNodeArray: [SKSpriteNode] = [apple]
    var chosenNodeArray: [SKSpriteNode] = []
    let pictureBorder1 = SKSpriteNode()
    let pictureBorder2 = SKSpriteNode()
    let pictureBorder3 = SKSpriteNode()
    let pictureBorder4 = SKSpriteNode()
    let shuffleButton = SKSpriteNode(imageNamed: "Red Button.png") // Need to have better picture
    let homeButton = SKSpriteNode(imageNamed: "Home Button.png") // Need to have better picture
    let nextButton = SKSpriteNode(imageNamed: "Next Button.png") // Need to have better picture
    let pickLabel = SKLabelNode(fontNamed: "ChalkboardSE-Bold") // Need to be a picture
    
    let standardAnchorPoint = CGPoint(x: 0.5, y: 0.5)
    var numberOfImages: CGFloat = 3  // This will need to be changed later
//    lazy var correctImage: String = self.chosenNodeArray[0].name!
//    lazy var correctSpriteNode: SKSpriteNode = self.chosenNodeArray[0]
    var correctImage = "apple"
    lazy var correctSpriteNode = self.apple
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
                selectedCorrect()
            }
            if touchedNode.name == "Shuffle Button" {
                shuffleImages()
            }
            if touchedNode.name == "Next Button" {
                nextImages()
            }
            if touchedNode.name == "Home Button" {
                goHome()
            }
        }
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    func shuffleImages() {
        var positionArray = [position1, position2, position3]
        if(numberOfImages == 4){
            positionArray.append(position4)
        }
        let shuffled = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: positionArray) as! [CGPoint]
        for i in 0..<Int(numberOfImages) {
            chosenNodeArray[i].position = shuffled[i]
        }
    }
    
    func nextImages() {
        chosenNodeArray.removeAll()
        removeAllChildren()
        setupChosenNodeArray()
        setupNodes()
        setupMenuNodes()
        correctImage = chosenNodeArray[0].name!
        updatePickLabel()
        updateCorrectNode()
    }
    
    func selectedCorrect() {
        pickLabel.text = "Good job!"
        for i in 1..<Int(numberOfImages) {
            chosenNodeArray[i].removeFromParent()
        }
//        chosenNodeArray[1].removeFromParent()
//        chosenNodeArray[2].removeFromParent()
        pictureBorder2.removeFromParent()
        pictureBorder3.removeFromParent()
        pictureBorder4.removeFromParent()
        correctSpriteNode.position = CGPoint(x: self.size.width * 0.50, y: self.size.height * 0.30)
        pictureBorder1.position = CGPoint(x: correctSpriteNode.position.x, y: correctSpriteNode.position.y)
    }
    func setupNodes() {
        
    }
    func setupMenuNodes(){
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
        if(numberOfImages == 4){
            setupPictureBorders(pictureBorder: pictureBorder4, position: position4)
        }
        
    }
    
    func setupPictureBorders(pictureBorder: SKSpriteNode, position: CGPoint) {
        // Need to be refactored to be more dynamic
        pictureBorder.position = position
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
        pictureBorder.name = "Picture Border"
        pictureBorder.size = borderSize
        addChild(pictureBorder)
    }
    
    func setupChosenNodeArray() {
        var uniqueNumbers = Set<Int>()
        while(uniqueNumbers.count != Int(numberOfImages))
        {
            uniqueNumbers.insert(Int(arc4random_uniform(UInt32(spriteNodeArray.count)) + 0))
        }
        print(uniqueNumbers)
        for number in uniqueNumbers {
            chosenNodeArray.append(spriteNodeArray[number])
        }
    }
    
    func updatePickLabel() {
        pickLabel.text = "Pick \(correctImage)"
    }
    
    func updateCorrectNode() {
        correctSpriteNode = chosenNodeArray[0]
    }
    
    func goHome() {
        let scene = TitlePage(size: CGSize(width: 1334, height: 750))
        scene.scaleMode = .aspectFill
        view?.presentScene(scene)
    }
    // Helper functions
    func setupSpriteNode(spriteNode _spriteNode: SKSpriteNode, position _position: CGPoint, anchorPoint _anchorPoint: CGPoint, zPosition _zPosition: CGFloat, scale _scale: CGFloat, name _name: String) {
        _spriteNode.position = _position
        _spriteNode.anchorPoint = _anchorPoint
        _spriteNode.zPosition = _zPosition
        _spriteNode.setScale(_scale)
        _spriteNode.name = _name
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
