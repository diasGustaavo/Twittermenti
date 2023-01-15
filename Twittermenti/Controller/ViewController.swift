//
//  ViewController.swift
//  Twittermenti
//
//  Created by Angela Yu on 17/07/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var tweetsManager = TweetsManager()
    
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetsManager.delegate = self
    }
    
    @IBAction func predictPressed(_ sender: Any) {
        tweetsManager.getScore()
    }
}

extension ViewController: TweetsManagerDelegate {
    func didUpdateScore(_ tweetsManager: TweetsManager, score: Double) {
        print(score)
    }
    
    func didFailWithError(error: Error) {
        print("error getting tweets and/or its score: \(error)")
    }
}

