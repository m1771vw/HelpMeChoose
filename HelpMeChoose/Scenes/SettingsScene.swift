//
//  SettingsScene.swift
//  HelpMeChoose
//
//  Created by William Yang on 1/19/18.
//  Copyright © 2018 WMA Games. All rights reserved.
//

import SpriteKit

class SettingsScene: SKScene {
    let categoryButton = SKSpriteNode(imageNamed: "apple")
    let titleLabel = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
    let homeButton = SKSpriteNode(imageNamed: "Home Button.png")
    var numberOfImagesLabel = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
    var numberOfImages: CGFloat = 3
    let numberOfImagesDefault = UserDefaults.standard
    
    override func didMove(to view: SKView) {
        setupNodes()
        backgroundColor = SKColor.white
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            let touchedLocation = touch.location(in: self)
            let touchedNode = self.atPoint(touchedLocation)

            if touchedNode.name == "Home Button" {
                run(SKAction.playSoundFileNamed("Menu Button.mp3", waitForCompletion: false))
                goHome()
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
  
    
    func goHome() {
        let scene = TitlePage(size: CGSize(width: 1334, height: 750))
        scene.scaleMode = .aspectFill
        view?.presentScene(scene)
    }
    
    func setupNodes() {
        let snh = SpriteNodeHelper()

        snh.setupLabelNode(labelNode: titleLabel, text: "Settings", fontColor: SKColor.black, fontSize: 150, zPosition: 10, horizontalAlignmentMode: .center, verticalAlignmentMode: .center, position: CGPoint(x: self.size.width / 2, y: self.size.height * 0.75))
        addChild(titleLabel)
        
        snh.setupSpriteNode(spriteNode: homeButton, position: CGPoint(x: self.size.width * 0.10, y: self.size.height * 0.1), anchorPoint: CGPoint(x: 0.5, y: 0.5), zPosition: 10, scale: 0.10, name: "Home Button")
        addChild(homeButton)
        
    }
}
