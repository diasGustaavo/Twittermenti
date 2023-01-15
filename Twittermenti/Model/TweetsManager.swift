//
//  TweetsManager.swift
//  Twittermenti
//
//  Created by Gustavo Dias on 15/01/23.
//  Copyright © 2023 London App Brewery. All rights reserved.
//

import Foundation
import Swifter

protocol TweetsManagerDelegate {
    func didUpdateScore(_ tweetsManager: TweetsManager, score: Double)
    func didFailWithError(error: Error)
}

struct TweetsManager {
    private let tweetSentimentManager = TweetSentimentManager()
    var delegate: TweetsManagerDelegate?
    
    private var consumerKey: String {
        var config: [String: Any]?
        
        if let infoPlistPath = Bundle.main.url(forResource: "Secrets", withExtension: "plist") {
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
    
    private var consumerSecret: String {
        var config: [String: Any]?
        
        if let infoPlistPath = Bundle.main.url(forResource: "Secrets", withExtension: "plist") {
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
    
    func getScore() {
        let swifter = Swifter(consumerKey: consumerKey, consumerSecret: consumerSecret)
        var finalResults: [TweetSentimentClassifierInput] = []
        
        swifter.searchTweet(using: "@Apple", lang: "en", count: 100, tweetMode: .extended) { results, searchMetadata in
            for i in 0...99 {
                if let tweet = results[i]["full_text"].string {
                    let tweetForClassification = TweetSentimentClassifierInput(text: tweet)
                    finalResults.append(tweetForClassification)
                }
            }
            delegate?.didUpdateScore(self, score: tweetSentimentManager.getScores(input: finalResults))
        } failure: { error in
            delegate?.didFailWithError(error: error)
        }
    }
}
