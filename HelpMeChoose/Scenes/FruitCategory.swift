//
//  FruitCategory.swift
//  HelpMeChoose
//
//  Created by William Yang on 12/31/17.
//  Copyright © 2017 WMA Games. All rights reserved.
//

import SpriteKit
import GameplayKit
import GameKit

class FruitCategory : GameScene {

    let apple = SKSpriteNode(imageNamed: "apple-real.jpg")
    let banana = SKSpriteNode(imageNamed: "banana.jpeg")
    let orange = SKSpriteNode(imageNamed: "orange.jpg")
    let grape = SKSpriteNode(imageNamed: "grapes.jpg")
    let watermelon = SKSpriteNode(imageNamed: "watermelon.jpg")
    let strawberry = SKSpriteNode(imageNamed: "strawberry.jpg")
    let pear = SKSpriteNode(imageNamed: "pear.png")
    lazy override var spriteNodeArray: [SKSpriteNode] = [apple, banana, orange, grape, watermelon, strawberry, pear]
    
    
    override func didMove(to view: SKView) {
        setupSceneHelper.setupChosenNodeArray(chosenNodeArray: &chosenNodeArray, spriteNodeArray: spriteNodeArray, numberOfImages: numberOfImages)
        setupMenuNodes()
        setupNodes()
        backgroundColor = SKColor.white
        nextImages()
    }
    override func nextImages() {
        super.nextImages()
        setupNodes()
    }
    
    func setupNodes(){
        spriteNodeHelper.setupSpriteNode(spriteNode: apple, position: position1, anchorPoint: standardAnchorPoint, zPosition : 10, scale: 0.15, name: "Apple")
        spriteNodeHelper.setupSpriteNode(spriteNode: banana, position: position1, anchorPoint: standardAnchorPoint, zPosition : 10, scale: 0.75, name: "Banana")
        spriteNodeHelper.setupSpriteNode(spriteNode: orange, position: position1, anchorPoint: standardAnchorPoint, zPosition : 10, scale: 0.40, name: "Orange")
        spriteNodeHelper.setupSpriteNode(spriteNode: grape, position: position1, anchorPoint: standardAnchorPoint, zPosition: 10, scale: 0.35, name: "Grape")
        spriteNodeHelper.setupSpriteNode(spriteNode: watermelon, position: position1, anchorPoint: standardAnchorPoint, zPosition: 10, scale: 0.35, name: "Watermelon")
        spriteNodeHelper.setupSpriteNode(spriteNode: strawberry, position: position1, anchorPoint: standardAnchorPoint, zPosition: 10, scale: 0.75, name: "Strawberry")
        spriteNodeHelper.setupSpriteNode(spriteNode: pear, position: position1, anchorPoint: standardAnchorPoint, zPosition: 10, scale: 0.35, name: "Pear")
        for i in 0..<Int(numberOfImages) {
            addChild(chosenNodeArray[i])
        }
        shuffleImages()
        
        spriteNodeHelper.setupLabelNode(labelNode: pickLabel, text: "Pick \(correctImage)!", fontColor: SKColor.black, fontSize: 150, zPosition: 10, horizontalAlignmentMode: .center, verticalAlignmentMode: .center, position: CGPoint(x: self.size.width / 2, y: self.size.height * 0.75))
        addChild(pickLabel)
    }
    
}


