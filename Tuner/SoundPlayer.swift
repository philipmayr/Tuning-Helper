//
//  SoundPlayer.swift
//  Tuner
//
//  Created by on 11/30/23.
//

import Foundation
import AVFoundation

class SoundPlayer: NSObject, AVAudioPlayerDelegate  {
    // An array to hold the AVAudioPlayer instances
    private var audioPlayers: [AVAudioPlayer] = []
    
    var delegate: SoundPlayerDelegate?
    
    // Function to play a sound given a file name
    func playSound(file: String) {
        // Use the locateSoundFile function to get the URL of the sound file
        guard let soundURL = locateSoundFile(file) else {
            // If the sound file URL is nil, print an error message and return
            print("Sound file not found")
            return
        }
        
        do {
            // Create an AVAudioPlayer instance with the sound file URL
            let audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            
            // Set the delegate of the audioPlayer to self (SoundPlayer)
            audioPlayer.delegate = self
            
            // Prepare the audioPlayer for playback
            audioPlayer.prepareToPlay()
            
            // Start playing the audio
            audioPlayer.play()
            
            // Add the audioPlayer to the array
            audioPlayers.append(audioPlayer)
        } catch {
            // If there is an error initializing the AVAudioPlayer, print the error message
            print("Failed to play sound: \(error.localizedDescription)")
        }
    }
    
    func hushSound() {
        audioPlayers.removeAll()
    }
    
    // Function to locate the sound file URL given a file name
    private func locateSoundFile(_ fileName: String) -> URL? {
        // Get the URL of the sound file from the main bundle
        return Bundle.main.url(forResource: fileName, withExtension: nil)
    }
    
    // Delegate method called when the AVAudioPlayer finishes playing a sound
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        // Find the index of the finished audioPlayer in the array
        if let index = audioPlayers.firstIndex(of: player) {
            // Remove the finished audioPlayer from the array
            audioPlayers.remove(at: index)
        }
        delegate?.didFinishPlay()
        
    }
    
    
    
}


protocol SoundPlayerDelegate {
    func didFinishPlay()
}
