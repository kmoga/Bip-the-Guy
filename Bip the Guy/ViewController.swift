//
//  ViewController.swift
//  Bip the Guy
//
//  Created by SBAUser on 9/26/19.
//  Copyright © 2019 Kyle Moga. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    // MARK: PROPERTIES
    @IBOutlet weak var imagetoPunch: UIImageView!
    
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

    // MARK: Actions
    @IBAction func libraryPressed(_ sender: UIButton) {
    }
    
    @IBAction func cameraPressed(_ sender: UIButton) {
    }
    
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
      animateImage()
    }
    
}

