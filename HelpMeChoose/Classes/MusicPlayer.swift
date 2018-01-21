//
//  MusicPlayer.swift
//  HelpMeChoose
//
//  Created by William Yang on 1/21/18.
//  Copyright © 2018 WMA Games. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

class MusicPlayer: SKScene {
    
    func playSound(fileName: String) {
        run(SKAction.playSoundFileNamed(fileName, waitForCompletion: false))
    }
    
    
}
