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
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    }

    // MARK: Actions
    @IBAction func libraryPressed(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary
        
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func cameraPressed(_ sender: UIButton) {
        
        // Check to see if the camera is available.  If we didn't have this & clicked the "Camera" button in the simulator, our app would crash.
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
        } else {
            showAlert(title: "Camera Not Available", message: "There is no camera available on this device.")
        }
    }
    
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
      animateImage()
        playSound(soundName: "punchSound", audioPlayer: &audioPlayer)
    }
    
}

