//
//  SoundPlayer.swift
//  SwiftTyping
//
//  Created by Tobias Sörensson on 2023-03-30.
//

import Foundation
import AVFoundation

class SoundPlayer {
    var players: [AVAudioPlayer]
    var currentPlayer: AVAudioPlayer?
    var playerIndex = 0
    
    init() {
        players = []
    }
    
//    do {
//        player = try AVAudioPlayer(contentsOf: url)
//        player?.play()
//
//    } catch let error {
//        print(error.localizedDescription)
//    }
    
        func playSound(soundPath: String) {
            if soundPath == "" {return}
            let url = URL(fileURLWithPath: soundPath)
            for player in players {
                if !player.isPlaying {
                    guard let index = players.firstIndex(of: player) else { continue }
                    players.remove(at: index)
                }
            }
            do {
                let player = try AVAudioPlayer(contentsOf: url)
                player.play()
                players.append(player)
            } catch let error {
                    print(error.localizedDescription)
                }
            }

            
        
}
