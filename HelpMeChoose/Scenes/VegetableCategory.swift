//
//  VegetableCategory.swift
//  HelpMeChoose
//
//  Created by William Yang on 12/31/17.
//  Copyright © 2017 WMA Games. All rights reserved.
//

import SpriteKit
import GameKit

class VegetableCategory : GameScene {
    let broccoli = SKSpriteNode(imageNamed: "broccoli.png")
    let carrot = SKSpriteNode(imageNamed: "carrot.jpg")
    let corn = SKSpriteNode(imageNamed: "corn.jpg")
    //let cucumber = SKSpriteNode(imageNamed: "cucumber.jpg")
    let potato = SKSpriteNode(imageNamed: "potato.png")
    let tomato = SKSpriteNode(imageNamed: "tomato.jpg")
    lazy override var spriteNodeArray: [SKSpriteNode] = [broccoli, carrot, corn, potato, tomato]
//    lazy override var correctImage: String = self.chosenNodeArray[0].name!
//    lazy override var correctSpriteNode: SKSpriteNode = self.chosenNodeArray[0]
            
    
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
        
        spriteNodeHelper.setupSpriteNode(spriteNode: broccoli, position: position1, anchorPoint: standardAnchorPoint, zPosition : 10, scale: 0.35, name: "Broccoli")
        spriteNodeHelper.setupSpriteNode(spriteNode: carrot, position: position1, anchorPoint: standardAnchorPoint, zPosition : 10, scale: 0.35, name: "Carrot")
        spriteNodeHelper.setupSpriteNode(spriteNode: corn, position: position1, anchorPoint: standardAnchorPoint, zPosition: 10, scale: 0.35, name: "Corn")
        //spriteNodeHelper.setupSpriteNode(spriteNode: cucumber, position: position1, anchorPoint: standardAnchorPoint, zPosition: 10, scale: 0.35, name: "Cucumber")
        spriteNodeHelper.setupSpriteNode(spriteNode: potato, position: position1, anchorPoint: standardAnchorPoint, zPosition: 10, scale: 0.45, name: "Potato")
        spriteNodeHelper.setupSpriteNode(spriteNode: tomato, position: position1, anchorPoint: standardAnchorPoint, zPosition: 10, scale: 0.35, name: "Tomato")
        for i in 0..<Int(numberOfImages) {
            addChild(chosenNodeArray[i])
        }
        shuffleImages()
        
        spriteNodeHelper.setupLabelNode(labelNode: pickLabel, text: "Pick \(correctImage)!", fontColor: SKColor.black, fontSize: 150, zPosition: 10, horizontalAlignmentMode: .center, verticalAlignmentMode: .center, position: CGPoint(x: self.size.width / 2, y: self.size.height * 0.75))
        addChild(pickLabel)
    }
    
}
