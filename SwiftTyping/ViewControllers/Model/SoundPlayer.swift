//
//  SoundPlayer.swift
//  SwiftTyping
//
//  Created by Tobias Sörensson on 2023-03-30.
//

import Foundation
import AVFoundation

/*
 This is used to play sounds. It appends new AVAudioPlayers to an array
 to allow for overlapping sounds. If a player has stopped playing, it will be removed
 the next time playSound() is called.
 */
class SoundPlayer {
    var players: [AVAudioPlayer]
    var currentPlayer: AVAudioPlayer?
    var playerIndex = 0
    
    init() {
        players = []
    }
    
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
