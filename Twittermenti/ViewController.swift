//
//  ViewController.swift
//  Twittermenti
//
//  Created by Angela Yu on 17/07/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit
import CoreML

class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let config = MLModelConfiguration()
        config.computeUnits = .all
        
        let sentimentClassifier = try! TweetSentimentClassifier(configuration: config)
        
        let prediction = try! sentimentClassifier.prediction(text: "@Apple is the best company!")
        let prediction2 = try! sentimentClassifier.prediction(text: "@Apple a company!")
        let prediction3 = try! sentimentClassifier.prediction(text: "@Apple is the worst company!")
        print(prediction.label)
        print(prediction2.label)
        print(prediction3.label)
    }

    @IBAction func predictPressed(_ sender: Any) {
        detect()
    }
    
    func detect() {
//        guard let model = try? MyModel(configuration: config) else {
//            fatalError("Loading CoreML Model Failed.")
//        }
//
//        print(model)
////
//        let request = CoreMLRequest(model: model) { request, error in
//            guard let results = request.results as? [VNClassificationObservation] else {
//                fatalError("Model failed to process image.")
//            }
//
//            if let firstResult = results.first {
//                if firstResult.identifier.contains("hotdog") {
//                    self.navigationItem.title = "Hotdog ✅"
//                    self.navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = .systemGreen
//                } else {
//                    self.navigationItem.title = "🚨🚨 Not Hotdog 🚨🚨"
//                    self.navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = .systemRed
//                }
//            }
//        }
//
//        let handler = VNImageRequestHandler(ciImage: image)
//
//        do {
//            try handler.perform([request])
//        } catch {
//            print(error)
//        }
    }
}

