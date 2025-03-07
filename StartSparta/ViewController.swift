//
//  ViewController.swift
//  StartSparta
//
//  Created by 조선우 on 3/6/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var introImageView: UIImageView!
    @IBOutlet weak var introButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        figureUI()
    }
    
    func figureUI() {
        introImageView.image = UIImage(named: "sparta.png")
        
        introButton.layer.cornerRadius = 10
        introButton.clipsToBounds = true
        
    }

}

