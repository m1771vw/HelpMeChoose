//
//  CategoryPage.swift
//  HelpMeChoose
//
//  Created by William Yang on 12/26/17.
//  Copyright © 2017 WMA Games. All rights reserved.
//

import SpriteKit

class CategoryPage: SKScene {
    let fruitCategory = SKSpriteNode(imageNamed: "apple")
    let vegetableCategory = SKSpriteNode(imageNamed: "broccoli")
    let instructionsLabel = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
    let homeButton = SKSpriteNode(imageNamed: "Home Button.png")
    var numberOfImagesLabel = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
    var numberOfImages: CGFloat = 3
    let musicPlayerClass = MusicPlayer()
    override func didMove(to view: SKView) {
        setupNodes()
        backgroundColor = SKColor.white
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            let touchedLocation = touch.location(in: self)
            let touchedNode = self.atPoint(touchedLocation)
            if touchedNode.name == "Fruit"{
                goToFruit()
            }
            if touchedNode.name == "Vegetable" {
                goToVegetable()
            }
            if touchedNode.name == "Home Button" {
                //musicPlayerClass.playSound(fileName: "Menu Button.mp3")
                run(SKAction.playSoundFileNamed("Menu Button.mp3", waitForCompletion: false))
                goHome()
            }
            
            if touchedNode.name == "Number Of Images" {
                if numberOfImages == 3 {
                    setNumberOfImagesToFour()
                } else if numberOfImages == 4 {
                    setNumberOfImagesToThree()
                }
            }
        }
    }
    
    func setNumberOfImagesToThree() {
        print("Number of Images: \(getNumberOfImages())")
        numberOfImages = 3
        
    }
    
    func setNumberOfImagesToFour() {
        print("Number of Images: \(getNumberOfImages())")
        numberOfImages = 4
        
    }
    
    func getNumberOfImages() -> CGFloat {
        
        return numberOfImages
    }
    
    override func update(_ currentTime: TimeInterval) {
        numberOfImagesLabel.text = "Click to choose number of images: \(Int(numberOfImages))"
    }
    
    func goToFruit(){
        let scene = FruitCategory(_size: CGSize(width: 1334, height: 750), _numberOfImages: numberOfImages)
        scene.scaleMode = .aspectFill
        view?.presentScene(scene)
    }
    
    func goToVegetable(){
        let scene = VegetableCategory(_size: CGSize(width: 1334, height: 750), _numberOfImages: numberOfImages)
        scene.scaleMode = .aspectFill
        view?.presentScene(scene)
    }
    
    func goHome() {
        let scene = TitlePage(size: CGSize(width: 1334, height: 750))
        scene.scaleMode = .aspectFill
        view?.presentScene(scene)
    }
    
    func setupNodes() {
        let snh = SpriteNodeHelper()
        snh.setupSpriteNode(spriteNode: fruitCategory, position: CGPoint(x: self.size.width / 2, y: self.size.height / 2), anchorPoint: CGPoint(x: 0.5, y: 0.5), zPosition: 10, scale: 0.50, name: "Fruit")
        snh.setupSpriteNode(spriteNode: vegetableCategory, position: CGPoint(x: self.size.width / 2, y: self.size.height / 2 - 250), anchorPoint: CGPoint(x: 0.5, y: 0.5), zPosition: 10, scale: 0.50, name: "Vegetable")
        addChild(fruitCategory)
        addChild(vegetableCategory)
        
        snh.setupLabelNode(labelNode: instructionsLabel, text: "Choose a Category!", fontColor: SKColor.black, fontSize: 125, zPosition: 10, horizontalAlignmentMode: .center, verticalAlignmentMode: .center, position: CGPoint(x: self.size.width / 2, y: self.size.height * 0.85))
        addChild(instructionsLabel)
        snh.setupSpriteNode(spriteNode: homeButton, position: CGPoint(x: self.size.width * 0.10, y: self.size.height * 0.1), anchorPoint: CGPoint(x: 0.5, y: 0.5), zPosition: 10, scale: 0.10, name: "Home Button")
        addChild(homeButton)
        
        snh.setupLabelNode(labelNode: numberOfImagesLabel, text: "Click to choose number of images: \(Int(numberOfImages))", fontColor: SKColor.black, fontSize: 50, zPosition: 10, horizontalAlignmentMode: .center, verticalAlignmentMode: .center, position: CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.70))
        numberOfImagesLabel.name = "Number Of Images"
        addChild(numberOfImagesLabel)
    }
    
    
}
