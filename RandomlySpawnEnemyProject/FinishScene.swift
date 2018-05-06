//
//  FinishScene.swift
//  RandomlySpawnEnemyProject
//
//  Created by Samaneh Fathieh on 6/5/18.
//  Copyright © 2018 SkyVan Labs. All rights reserved.
//

import SpriteKit

struct ScoreRecord: Codable {
    let playerName: String
    let score: Double
    init(playerName: String, score: Double) {
        self.playerName = playerName
        self.score = score
    }
}

class FinishScene: SKScene {
    override func didMove(to view: SKView) {
        let documentsDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
        print(documentsDir)
        let r = ScoreRecord(playerName: "jafar",score: 10.0)
        let records = [r]
        saveData(records: records)
    }
  
    func saveData(records: [ScoreRecord]) {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
        let archiveURL = documentsDirectory.appendingPathComponent("high_scores").appendingPathExtension("json")
        do {
            let data = try JSONEncoder().encode(records)
            try data.write(to: archiveURL, options: .noFileProtection)
        }
        catch {
            print("Error saving data")
        }
    }
//
//    func loadData() {
//        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
//        let archiveURL = documentsDirectory.appendingPathComponent("high_scores").appendingPathExtension("json")
//        let jsonDecoder = JSONDecoder()
//        if let highScoresData = try? Data(contentsOf: archiveURL),
//            let decodedHighScores = try? jsonDecoder.decode([ScoreRecord].self, from: highScoresData) {
//            self.records = decodedHighScores
//            self.tableView.reloadData()
//        }
//    }
    
}
