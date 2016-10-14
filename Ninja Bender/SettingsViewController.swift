//
//  SettingsViewController.swift
//  Ninja Bender
//
//  Created by Jennifer Lai on 10/2/16.
//  Copyright © 2016 JenL. All rights reserved.
//

import UIKit
import AVFoundation

class SettingsViewController: UIViewController {

    
    // MARK: Properties
    var audio: AVAudioPlayer?
    
    @IBOutlet weak var switchMusic: UISwitch!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

    
    // MARK: Actions
    
    @IBAction func doneSettings(_ sender: UIBarButtonItem) {
        let isPresentingSettings = presentingViewController is UINavigationController
        
        if isPresentingSettings {
            dismiss(animated: true, completion: nil)
        }
        else {
            navigationController!.popViewController(animated: true)
        }
    }
    
    
    
    
    
    
    @IBAction func statusMusic(_ sender: UISwitch) {
        
        if switchMusic.isOn {
            audio?.play()
        }
        else {
            audio?.stop()
        }
        
    }
    
}
