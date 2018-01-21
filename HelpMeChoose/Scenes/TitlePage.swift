//
//  TitlePage.swift
//  HelpMeChoose
//
//  Created by William Yang on 12/26/17.
//  Copyright © 2017 WMA Games. All rights reserved.
//

import SpriteKit

class TitlePage: SKScene {
    let categoryButton = SKSpriteNode(imageNamed: "apple")
    let titleLabel = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
    let settingsButton = SKSpriteNode(imageNamed: "settings-gear.png")
    override func didMove(to view: SKView) {
        setupNodes()
        backgroundColor = SKColor.white
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            let touchedLocation = touch.location(in: self)
            let touchedNode = self.atPoint(touchedLocation)
            if touchedNode.name == "Category"{
                self.run(SKAction.playSoundFileNamed("Menu Button.mp3", waitForCompletion: false))
                goToCategories()
            }
            if touchedNode.name == "Settings"{
                self.run(SKAction.playSoundFileNamed("Menu Button.mp3", waitForCompletion: false))
                goToSettings()
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    func goToSettings(){
        let scene = SettingsScene(size: CGSize(width: 1334, height: 750))
        scene.scaleMode = .aspectFill
        view?.presentScene(scene)
    }
    
    func goToCategories(){
        let scene = CategoryPage(size: CGSize(width: 1334, height: 750))
        scene.scaleMode = .aspectFill
        view?.presentScene(scene)
    }
    func setupNodes() {
        let snh = SpriteNodeHelper()
        snh.setupSpriteNode(spriteNode: categoryButton, position: CGPoint(x: self.size.width / 2, y: self.size.height / 2), anchorPoint: CGPoint(x: 0.5, y: 0.5), zPosition: 10, scale: 0.50, name: "Category")
        addChild(categoryButton)
        
        snh.setupSpriteNode(spriteNode: settingsButton, position: CGPoint(x: self.size.width / 2, y: self.size.height * 0.25), anchorPoint: CGPoint(x: 0.5, y: 0.5), zPosition: 10, scale: 0.25, name: "Settings")
        addChild(settingsButton)
        
         snh.setupLabelNode(labelNode: titleLabel, text: "Help Me Choose!", fontColor: SKColor.black, fontSize: 150, zPosition: 10, horizontalAlignmentMode: .center, verticalAlignmentMode: .center, position: CGPoint(x: self.size.width / 2, y: self.size.height * 0.75))
        addChild(titleLabel)
    }
}
