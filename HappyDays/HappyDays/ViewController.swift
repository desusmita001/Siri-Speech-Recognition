//
//  ViewController.swift
//  HappyDays
//
//  Created by Susmita De on 10/9/25.
//

import UIKit
import AVFoundation
import Photos
import Speech

class ViewController: UIViewController {

    @IBOutlet weak var helpLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    func requestPhotoPermission() {
        PHPhotoLibrary.requestAuthorization { [unowned self]
            authStatus in
            
            DispatchQueue.main.async {
                if authStatus == .authorized {
                    self.requestRecordPermission()
                    
                } else {
                    self.helpLabel.text = "Please grant permission to access your photos."
                }
            }
        }
    }
    
    
    func requestRecordPermission() {
        AVAudioSession.sharedInstance().requestRecordPermission { [unowned self] allowed in
            DispatchQueue.main.async {
                if allowed {
                    self.requestTranscribePermission()
                } else {
                    self.helpLabel.text = "Please grant permission to record audio."
                }
            }
        }
    }
    
    func requestTranscribePermission() {
        SFSpeechRecognizer.requestAuthorization { [unowned self] authStatus in
            DispatchQueue.main.async {
                if authStatus == .authorized {
                    self.authorizationComplete()
                } else {
                    self.helpLabel.text = "Please grant permission to use Speech Recognition."
                }
            }
        }
    }
    
    func authorizationComplete() {
        dismiss(animated: true)
    }

    @IBAction func requestPermission(_ sender: UIButton) {
        requestPhotoPermission()
    }
}

