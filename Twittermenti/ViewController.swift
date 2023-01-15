//
//  ViewController.swift
//  Twittermenti
//
//  Created by Angela Yu on 17/07/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit
import CoreML
import Swifter

class ViewController: UIViewController {
    
    var consumerKey: String {
        var config: [String: Any]?
                
        if let infoPlistPath = Bundle.main.url(forResource: "Secrets", withExtension: "plist") {
            print("entrou")
            do {
                let infoPlistData = try Data(contentsOf: infoPlistPath)
                
                if let dict = try PropertyListSerialization.propertyList(from: infoPlistData, options: [], format: nil) as? [String: Any] {
                    config = dict
                }
            } catch {
                print(error)
            }
        }
        
        if let safeKey = config?["API Key"] as? String {
            return safeKey
        } else {
            return "404"
        }
    }
    
    var consumerSecret: String {
        var config: [String: Any]?
                
        if let infoPlistPath = Bundle.main.url(forResource: "Secrets", withExtension: "plist") {
            print("entrou")
            do {
                let infoPlistData = try Data(contentsOf: infoPlistPath)
                
                if let dict = try PropertyListSerialization.propertyList(from: infoPlistData, options: [], format: nil) as? [String: Any] {
                    config = dict
                }
            } catch {
                print(error)
            }
        }
        
        if let safeSecret = config?["API Secret"] as? String {
            return safeSecret
        } else {
            return "404"
        }
    }
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Optional(Hello)
        
//        let config = MLModelConfiguration()
//        config.computeUnits = .all
//
//        let sentimentClassifier = try! TweetSentimentClassifier(configuration: config)
//
//        let prediction = try! sentimentClassifier.prediction(text: "@Apple is the best company!")
//        let prediction2 = try! sentimentClassifier.prediction(text: "@Apple a company!")
//        let prediction3 = try! sentimentClassifier.prediction(text: "@Apple is the most hated company because they are the worst!")
//        print(prediction.label)
//        print(prediction2.label)
//        print(prediction3.label)
        
        let swifter = Swifter(consumerKey: consumerKey, consumerSecret: consumerSecret)
        
        swifter.searchTweet(using: "@Apple") { results, searchMetadata in
            print(results)
        } failure: { error in
            print("There was an error with the Twitter API Request, \(error)")
        }

        
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

