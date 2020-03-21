//
//  StackViewController.swift
//  myBorg
//
//  Created by Ira Theobold on 19/03/2020.
//  Copyright © 2020 Ira Theobold. All rights reserved.
//

import UIKit
import AVFoundation

class StackViewController: UIViewController {
    
    var SVGrids = StackViews()
    
    
    var player: AVAudioPlayer!
    var soundPlayers = [AVAudioPlayer]()  // Array to hold multiple player for poliphony
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        SVGrids.StackViewGrid(rows: 3, columns: 3, rootView: view)
    }
    

    
    // Sound player
    func playSound(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "wav")
        
        // Create a new player for the sound; it doesn't matter which sound file this is
        let soundPlayer = try! AVAudioPlayer( contentsOf: url! )
                soundPlayer.numberOfLoops = 0
                soundPlayer.volume = 1
                soundPlayer.play()
                soundPlayers.append( soundPlayer ) // Array of players

        // In an timer based loop or other callback such as display link, prune out players that are done, thus deallocating them
                checkSfx: for player in soundPlayers {
                    if player.isPlaying { continue } else {
                        if let index = soundPlayers.firstIndex(of: player) {
                            soundPlayers.remove(at: index)
                            break checkSfx
                        }
                    }
                }
                
    }
}


