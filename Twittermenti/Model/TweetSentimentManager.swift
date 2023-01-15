//
//  TweetSentimentManager.swift
//  Twittermenti
//
//  Created by Gustavo Dias on 15/01/23.
//  Copyright © 2023 London App Brewery. All rights reserved.
//

import Foundation
import CoreML

struct TweetSentimentManager {
    
    let config = MLModelConfiguration()
    
    init() {
        config.computeUnits = .all
    }
    
    func getScores(input: [TweetSentimentClassifierInput]) -> Double {
        var score = 0.0
        do {
            let sentimentClassifier = try TweetSentimentClassifier(configuration: config)
            let preds = try sentimentClassifier.predictions(inputs: input)
            for pred in preds {
                let sentiment = pred.label
                
                if sentiment == "Pos" {
                    score += 1.0
                } else if sentiment == "Neg" {
                    score -= 1.0
                }
            }
        } catch {
            print("Error making the prediction: \(error)")
        }
        
        return score
    }
}
