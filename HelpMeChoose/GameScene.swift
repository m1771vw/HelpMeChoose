//
//  GameScene.swift
//  HelpMeChoose
//
//  Created by William Yang on 12/12/17.
//  Copyright © 2017 WMA Games. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation


class GameScene: SKScene {
    
    lazy var position1 = CGPoint(x: size.width * CGFloat(1 / (numberOfImages + 1)), y: size.height * 0.25)
    lazy var position2 = CGPoint(x: size.width * CGFloat(2 / (numberOfImages + 1)), y: size.height * 0.25)
    lazy var position3 = CGPoint(x: size.width * CGFloat(3 / (numberOfImages + 1)), y: size.height * 0.25)
    lazy var position4 = CGPoint(x: size.width * CGFloat(4 / (numberOfImages + 1)), y: size.height * 0.25)
    let pictureBorderNode = SKSpriteNode(imageNamed: "apple.png") // Using Apple as a temp image
//    let apple = SKSpriteNode(imageNamed: "apple.png") // Using Apple as a temp image
    var spriteNodeArray: [SKSpriteNode] = []
    var chosenNodeArray: [SKSpriteNode] = []
    var incorrectNodeStringArray: [String] = []
    let pictureBorder1 = SKSpriteNode()
    let pictureBorder2 = SKSpriteNode()
    let pictureBorder3 = SKSpriteNode()
    let pictureBorder4 = SKSpriteNode()
    let shuffleButton = SKSpriteNode(imageNamed: "repeat icon.png") // Need to have better picture
    let homeButton = SKSpriteNode(imageNamed: "Home Button.png") // Need to have better picture
    let nextButton = SKSpriteNode(imageNamed: "Next Button 2.png") // Need to have better picture
    let pickLabel = SKLabelNode(fontNamed: "ChalkboardSE-Bold") // Need to be a picture
    
    let standardAnchorPoint = CGPoint(x: 0.5, y: 0.5)
    
    
    var numberOfImages: CGFloat // This will need to be changed later
    let setupSceneHelper = SetupSceneHelper()
    let spriteNodeHelper = SpriteNodeHelper()
//    lazy var correctImage: String = self.chosenNodeArray[0].name!
//    lazy var correctSpriteNode: SKSpriteNode = self.chosenNodeArray[0]
//    var correctImage: String = "apple"
//    lazy var correctSpriteNode: SKSpriteNode = self.apple
    var correctImage: String = ""
    var correctSpriteNode: SKSpriteNode!
    var incorrectImage: String = ""
    
    var ableToShuffle: Bool = true
    let musicPlayerClass = MusicPlayer()
    init(_size: CGSize, _numberOfImages: CGFloat) {
        self.numberOfImages = _numberOfImages
        super.init(size: _size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Initialization Failed")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("Number of Images: \(numberOfImages)")
        if let touch = touches.first{
            let touchedLocation = touch.location(in: self)
            let touchedNode = self.atPoint(touchedLocation)
            if touchedNode.name == correctImage {
                selectedCorrect()
            }
            
            if checkIncorrectImage(touchedNode: touchedNode) {
                selectedIncorrect()
            }
        
            if touchedNode.name == "Shuffle Button" && ableToShuffle == true {
                //musicPlayerClass.playSound(fileName: "Menu Button.mp3")
                run(SKAction.playSoundFileNamed("Menu Button.mp3", waitForCompletion: true))
                shuffleImages()
            }
            if touchedNode.name == "Next Button" {
                //musicPlayerClass.playSound(fileName: "Menu Button.mp3")
                run(SKAction.playSoundFileNamed("Menu Button.mp3", waitForCompletion: true))
                ableToShuffle = true
                nextImages()
            }
            if touchedNode.name == "Home Button" {
                //musicPlayerClass.playSound(fileName: "Menu Button.mp3")
                run(SKAction.playSoundFileNamed("Menu Button.mp3", waitForCompletion: true))
                goBack()
            }
        }
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    func checkIncorrectImage(touchedNode _touchedNode: SKNode) -> Bool {
        if _touchedNode.name == incorrectNodeStringArray[0] || _touchedNode.name == incorrectNodeStringArray[1] {
            showTryAgain()
            return true
        } else if numberOfImages >= 4 && _touchedNode.name == incorrectNodeStringArray[2] {
            showTryAgain()
            return true
        } else {
            return false
        }
    }
    
    func showTryAgain() {
        pickLabel.text = "Try Again!"
        let when = DispatchTime.now() + 1.5 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.updatePickLabel()
        }
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
        setupChosenNodeArray(spriteNodeArray: spriteNodeArray)
        setupMenuNodes()
        setImages()
        updatePickLabel()
        updateCorrectNode()
        updateNumberOfImages()
    }
    
    func setImages() {
        correctImage = chosenNodeArray[0].name!
        incorrectNodeStringArray.removeAll()
        for x in 1..<(chosenNodeArray.count) {
            incorrectNodeStringArray.append(chosenNodeArray[x].name!)
        }
        print(incorrectNodeStringArray)
    }
    
    func selectedIncorrect() {
        run(SKAction.playSoundFileNamed("Try Again.mp3", waitForCompletion: false))
    }
    
    func selectedCorrect() {
        run(SKAction.playSoundFileNamed("Good Job.mp3", waitForCompletion: false))
        pickLabel.text = "Good job!"
        for i in 1..<Int(numberOfImages) {
            chosenNodeArray[i].removeFromParent()
        }
        pictureBorder2.removeFromParent()
        pictureBorder3.removeFromParent()
        pictureBorder4.removeFromParent()
        ableToShuffle = false
        correctSpriteNode.position = CGPoint(x: self.size.width * 0.50, y: self.size.height * 0.25)
        pictureBorder1.position = CGPoint(x: correctSpriteNode.position.x, y: correctSpriteNode.position.y)
    }

    func setupMenuNodes(){
        spriteNodeHelper.setupLabelNode(labelNode: pickLabel, text: "Pick \(correctImage)!", fontColor: SKColor.black, fontSize: 150, zPosition: 10, horizontalAlignmentMode: .center, verticalAlignmentMode: .center, position: CGPoint(x: self.size.width / 2, y: self.size.height * 0.75))
        spriteNodeHelper.setupSpriteNode(spriteNode: shuffleButton, position: CGPoint(x: self.size.width * 0.9, y: self.size.height * 0.9), anchorPoint: standardAnchorPoint, zPosition: 10, scale: 0.30, name: "Shuffle Button")
        spriteNodeHelper.setupSpriteNode(spriteNode: homeButton, position: CGPoint(x: self.size.width * 0.10, y: self.size.height * 0.1), anchorPoint: standardAnchorPoint, zPosition: 10, scale: 0.10, name: "Home Button")
        spriteNodeHelper.setupSpriteNode(spriteNode: nextButton, position: CGPoint(x: self.size.width * 0.9, y: self.size.height * 0.1), anchorPoint: standardAnchorPoint, zPosition: 10, scale: 0.10, name: "Next Button")
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
        let borderSize = CGSize(width: pictureBorderNode.size.width * CGFloat(1 + (1 / (numberOfImages + 1))), height: pictureBorderNode.size.height * CGFloat(1 + (1 / (numberOfImages + 1))))
        let fillColor = UIColor.clear
        let borderColor = UIColor.black
        // Start UI Graphics
        UIGraphicsBeginImageContextWithOptions(borderSize, false, 0)
        let context = UIGraphicsGetCurrentContext()
        borderColor.setStroke()
        let borderRect = CGRect(origin: .zero, size: CGSize(width: pictureBorderNode.size.width * CGFloat(1 + (1 / (numberOfImages + 1))), height: pictureBorderNode.size.height * CGFloat(1 + (1 / (numberOfImages + 1)))))
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
    
    func setupChosenNodeArray(spriteNodeArray _spriteNodeArray: [SKSpriteNode]) {
        var uniqueNumbers = Set<Int>()
        while(uniqueNumbers.count != Int(numberOfImages))
        {
            uniqueNumbers.insert(Int(arc4random_uniform(UInt32(_spriteNodeArray.count)) + 0))
        }
        print(uniqueNumbers)
        for number in uniqueNumbers {
            chosenNodeArray.append(_spriteNodeArray[number])
        }
    }
    
    func setupCorrectImage(correctImage _correctImage: String, correctSpriteNode _correctSpriteNode: SKSpriteNode) {
        correctImage = _correctImage
        correctSpriteNode = _correctSpriteNode
    }
    
    func updatePickLabel() {
        pickLabel.text = "Pick \(correctImage)!"
    }
    
    func updateCorrectNode() {
        correctSpriteNode = chosenNodeArray[0]
    }
    
    func updateNumberOfImages() {
        
        print(numberOfImages)
    }
    
    func goBack() {
        let scene = CategoryPage(size: CGSize(width: 1334, height: 750))
        scene.scaleMode = .aspectFill
        view?.presentScene(scene)
    }
}
