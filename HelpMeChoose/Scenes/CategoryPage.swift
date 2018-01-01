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
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    func goToFruit(){
        let scene = FruitCategory(size: CGSize(width: 1334, height: 750))
        scene.scaleMode = .aspectFill
        view?.presentScene(scene)
    }
    
    func goToVegetable(){
        let scene = VegetableCategory(size: CGSize(width: 1334, height: 750))
        scene.scaleMode = .aspectFill
        view?.presentScene(scene)
    }
    
    func setupNodes() {
        let snh = SpriteNodeHelper()
        snh.setupSpriteNode(spriteNode: fruitCategory, position: CGPoint(x: self.size.width / 2, y: self.size.height / 2), anchorPoint: CGPoint(x: 0.5, y: 0.5), zPosition: 10, scale: 0.50, name: "Fruit")
        snh.setupSpriteNode(spriteNode: vegetableCategory, position: CGPoint(x: self.size.width / 2, y: self.size.height / 2 - 250), anchorPoint: CGPoint(x: 0.5, y: 0.5), zPosition: 10, scale: 0.50, name: "Vegetable")
        addChild(fruitCategory)
        addChild(vegetableCategory)
        
        snh.setupLabelNode(labelNode: instructionsLabel, text: "Choose a Category!", fontColor: SKColor.black, fontSize: 150, zPosition: 10, horizontalAlignmentMode: .center, verticalAlignmentMode: .center, position: CGPoint(x: self.size.width / 2, y: self.size.height * 0.75))
        addChild(instructionsLabel)
    }
    
    
}
