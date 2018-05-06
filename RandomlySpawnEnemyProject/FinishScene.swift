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

class GameRoomTableView: UITableView,UITableViewDelegate,UITableViewDataSource {
//    var items: [String] = ["Player1", "Player2", "Player3"]
    var items: [ScoreRecord] = [ScoreRecord(playerName: "jafar",score: 10.0)]
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.delegate = self
        self.dataSource = self
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        cell.textLabel?.text = "\(self.items[indexPath.row].score) - \(self.items[indexPath.row].playerName)"
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section)"
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }
}

class FinishScene: SKScene {
    var records: [ScoreRecord] = []
    var gameTableView = GameRoomTableView()
    
    override func didMove(to view: SKView) {
        let documentsDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
        print(documentsDir)
        let r = ScoreRecord(playerName: "jafar",score: 10.0)
        records = [r]
        //        saveData(records: records)
        gameTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        gameTableView.frame=CGRect(x:20,y:50,width:280,height:200)
        self.scene?.view?.addSubview(gameTableView)
        gameTableView.reloadData()
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
    
    func loadData() {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
        let archiveURL = documentsDirectory.appendingPathComponent("high_scores").appendingPathExtension("json")
        let jsonDecoder = JSONDecoder()
        if let highScoresData = try? Data(contentsOf: archiveURL),
            let decodedHighScores = try? jsonDecoder.decode([ScoreRecord].self, from: highScoresData) {
            self.records = decodedHighScores
            //            self.tableView.reloadData()
        }
    }
    
}
