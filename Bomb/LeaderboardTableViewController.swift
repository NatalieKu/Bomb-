//
//  LeaderboardTableViewController.swift
//  Bomb
//
//  Created by MEI KU on 2019/9/8.
//  Copyright © 2019 Natalie KU. All rights reserved.
//

import UIKit

class LeaderboardTableViewController: UITableViewController {
     
    var players = [Player]()
    
  @IBAction func goBackToLoverTable(segue: UIStoryboardSegue) {
            let controller = segue.source as? RegisterTableViewController
    
            if  let player = controller?.player {
                if let row = tableView.indexPathForSelectedRow?.row {
                    players[row] = player
                } else {
                    players.insert(player, at: 0)
                }
                
                Player.saveToFile(players: players)
                
                
                tableView.reloadData()
            }
            
     
            
            
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(true)
            sort()
            tableView.reloadData()
            
        
        }
     


        override func viewDidLoad() {
            super.viewDidLoad()

        
                  
        
            
            // Uncomment the following line to preserve selection between presentations
            // self.clearsSelectionOnViewWillAppear = false

            // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
           
         
            
            if let players = Player.readPlayersFromFile() {
                self.players = players
            }
            
            sort()
            tableView.reloadData()
        }
        
        func sort()
        {
        
            players.sort{ (lhs: Player, rhs: Player) -> Bool in
                // you can have additional code here
                var double1 = (lhs.score as NSString).doubleValue
                var double2 = (rhs.score as NSString).doubleValue
                return double1 > double2
            }
            print(players)
        }
        

        
        // MARK: - Table view data source

        /////////////////////////////////////
     
  
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            
            players.remove(at: indexPath.row)
            Player.saveToFile(players: players)
            tableView.reloadData()
        }
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return players.count
        }
        
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as! LeaderboardTableViewCell
            
            let player = players[indexPath.row]
            cell.nameLabel.text = player.name
            cell.scoreLabel.text = String(player.score)
           // cell.numberLabel.text = String(indexPath.row+1)
            cell.view.image = UIImage(named: player.imageName)
            //cell.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
    
           
            
            
            if cell.nameLabel.text?.count == 0 {
                cell.nameLabel.text = "Unknown"
                cell.view.image = UIImage(named: "Unknown")
                
        }
           return cell
    }
            /*
            if indexPath.row == 0 {
                cell.backgroundColor = #colorLiteral(red: 1, green: 0.3379347649, blue: 0.7747731852, alpha: 1)
                cell.numberLabel.isHidden = true
                cell.view.isHidden = false
                //cell.view.image = UIImage(named:"top")
                   
            }else {
               
                cell.backgroundColor = #colorLiteral(red: 0.8591583576, green: 0.9081166964, blue: 1, alpha: 1)
            }
         
            return cell
        }
 */
        //////////////////////

        /*
        // Override to support conditional editing of the table view.
        override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            // Return false if you do not want the specified item to be editable.
            return true
        }
        */

        /*
        // Override to support editing the table view.
        override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                // Delete the row from the data source
                tableView.deleteRows(at: [indexPath], with: .fade)
            } else if editingStyle == .insert {
                // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            }
        }
        */

        /*
        // Override to support rearranging the table view.
        override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

        }
        */

        /*
        // Override to support conditional rearranging of the table view.
        override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
            // Return false if you do not want the item to be re-orderable.
            return true
        }
        */

        
        // MARK: - Navigation

        // In a storyboard-based application, you will often want to do a little preparation before navigation
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Get the new view controller using segue.destinationViewController.
            // Pass the selected object to the new view controller.
            
            if let row = tableView.indexPathForSelectedRow?.row {
                let player = players[row]
                let controller = segue.destination as? RegisterTableViewController
                controller?.player =  player
                
            }

        }
        

    }
