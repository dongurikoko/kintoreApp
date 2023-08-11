//
//  SoundPlayer.swift
//  MyTimer
//
//  Created by 大本詩織
//

import UIKit
import AVFoundation

class SoundPlayer: NSObject {
    let cymbalData = NSDataAsset(name: "cymbalSound")!.data
    
    var cymbalPlayer: AVAudioPlayer!
    
    func cymbalPlay(){
        do{
            cymbalPlayer = try AVAudioPlayer(data: cymbalData)
            
            cymbalPlayer.play()
        }catch{
            print("エラー発生")
        }
    }
}
