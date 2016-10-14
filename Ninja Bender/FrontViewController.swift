//
//  FrontViewController.swift
//  Ninja Bender
//
//  Created by Jennelle Lai on 10/2/16.
//  Copyright © 2016 JenL. All rights reserved.
//

import UIKit
import AVFoundation

class FrontViewController: UIViewController {

    
    // MARK: Properties
    
    var audioPlayer: AVAudioPlayer?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        playBackgroundMusic()
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        Thread.sleep(forTimeInterval: 3)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "settings" {
            let destinationVC: SettingsViewController = segue.destination as! SettingsViewController
            destinationVC.audio = audioPlayer
        }
    }
    
    
    func playBackgroundMusic() {
        do {
            if let bundle = Bundle.main.path(forResource: "song", ofType: "mp3") {
                let alertSound = NSURL(fileURLWithPath: bundle)
                try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
                try AVAudioSession.sharedInstance().setActive(true)
                try audioPlayer = AVAudioPlayer(contentsOf: alertSound as URL)
                audioPlayer?.numberOfLoops = -1
                audioPlayer?.prepareToPlay()
                audioPlayer?.play()
                
            }
        } catch {
            print(error)
        }
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    

}
