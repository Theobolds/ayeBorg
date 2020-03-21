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
    
    var player: AVAudioPlayer!
    var soundPlayers = [AVAudioPlayer]()  // Array to hold multiple player for poliphony
    let gridSpacing: CGFloat = 10.0
    let borgInstrumentArray = ["HighTom","MedTom","LowTom","RimShot","Clap","CowBell","Kick","Snare","HiHat"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        PadsStackViewGrid(rows: 3, columns: 3, buttonArray: borgInstrumentArray as NSArray, rootView: view)
    }

    @objc func onButton(button: CustomButton) {
           playSound(soundName: (button.titleLabel?.text!)!)
       }
       
    func PadsStackViewGrid(rows: Int, columns: Int, buttonArray: NSArray ,rootView: UIView) {
          
          // Initialise StackView
          let padStackview = UIStackView()
          padStackview.axis = .vertical
          padStackview.alignment = .fill
          padStackview.distribution = .fillEqually
          padStackview.spacing = gridSpacing
          
          for row in 0 ..< rows {
              let horizSpace = UIStackView()
              horizSpace.axis = .horizontal
              horizSpace.alignment = .fill
              horizSpace.distribution = .fillEqually
              horizSpace.spacing = gridSpacing
              
              for col in 0 ..< columns {
                  let button = CustomButton()
                  button.backgroundColor = .systemTeal
                 
                  button.showsTouchWhenHighlighted = true
                  button.layer.cornerRadius = 6
                  button.setTitle("\(buttonArray[row*columns + col])", for: .normal)
                  button.addTarget(self, action: #selector(onButton), for: .touchUpInside)
                  horizSpace.addArrangedSubview(button)
              }
              padStackview.addArrangedSubview(horizSpace)
          }
          
          rootView.addSubview(padStackview)
          
          // add constraints
          padStackview.translatesAutoresizingMaskIntoConstraints = false
          padStackview.topAnchor.constraint(equalTo: rootView.layoutMarginsGuide.topAnchor , constant: gridSpacing).isActive = true
          padStackview.leftAnchor.constraint(equalTo: rootView.layoutMarginsGuide.leftAnchor, constant: gridSpacing).isActive = true
          padStackview.rightAnchor.constraint(equalTo: rootView.layoutMarginsGuide.rightAnchor, constant: -gridSpacing).isActive = true
          padStackview.bottomAnchor.constraint(equalTo: rootView.layoutMarginsGuide.bottomAnchor, constant: -gridSpacing).isActive = true
          
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


