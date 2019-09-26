//
//  ViewController.swift
//  Bip the Guy
//
//  Created by SBAUser on 9/26/19.
//  Copyright © 2019 Kyle Moga. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: PROPERTIES
    @IBOutlet weak var imagetoPunch: UIImageView!
    
    // MARK: Variables
    var audioPlayer = AVAudioPlayer()
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    // MARK: FUNCTIONS
    
    func animateImage() {
        let bounds = self.imagetoPunch.bounds
        let shrinkvalue: CGFloat = 60
        
        //shrink imagetoPunch by 60 px
        self.imagetoPunch.bounds = CGRect (x: self.imagetoPunch.bounds.origin.x + shrinkvalue, y:self.imagetoPunch.bounds.origin.y + shrinkvalue, width: self.imagetoPunch.bounds.size.width - shrinkvalue, height: self.imagetoPunch.bounds.size.height - shrinkvalue)
        
        UIView.animate(withDuration: 0.25, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options:[], animations: { self.imagetoPunch.bounds = bounds }, completion: nil)
    }
    
    func playSound(soundName: String, audioPlayer:  inout AVAudioPlayer) {
        if let sound = NSDataAsset(name: soundName) {
            do {
                try audioPlayer = AVAudioPlayer(data: sound.data)
                audioPlayer.play()
            } catch {
                print("ERROR: data in \(soundName) couldn't be played as a sound.")
            }
        } else {
            print("ERROR: file \(soundName) didn't load")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        imagetoPunch.image = selectedImage
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    // MARK: Actions
    @IBAction func libraryPressed(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary
        
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func cameraPressed(_ sender: UIButton) {
        imagePicker.sourceType = .camera
        
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
      animateImage()
        playSound(soundName: "punchSound", audioPlayer: &audioPlayer)
    }
    
}

