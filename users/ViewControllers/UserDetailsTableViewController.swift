//
//  UserDetailsTableViewController.swift
//  users
//
//  Created by User on 12.11.2022.
//

import UIKit




class UserDetailsTableViewController: UITableViewController {

    var user: User!
    var sections: [UserDetailsSections] = [.fullNameAndPhoto, .birthday, .contactInfo, .adress]
    
    var userInfo: Dictionary<UserDetailsSections, [UserInfo:String]>!
    
    override func loadView() {
        super.loadView()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YYYY"
        let birthday = dateFormatter.string(from: user.dob.date)
    
        userInfo = [
            .fullNameAndPhoto: [.birthday: ""], // for rowCount = 1 (check numberOfRowsInSection)
            .birthday: [.birthday: birthday],
            .contactInfo: [
                .phone: user.phone,
                .email: user.email
            ],
            .adress: [
                .street: user.location.street.fullName,
                .city: user.location.city
            ]
        
        ]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let info = userInfo[sections[section]] else {
            return 0
        }
        return info.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].rawValue
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RequsitesTableViewCell", for: indexPath) as! RequsitesTableViewCell
            cell.firstNameLabel.text = user.name.first
            cell.lastNameLabel.text = user.name.last
            guard let userPhotoUrl = URL(string: user.picture.large) else {
                fatalError("failed to get url user's photo")
            }

            let userPhotoData = try? Data(contentsOf: userPhotoUrl)
            cell.photoImageView.image = UIImage(data: userPhotoData!)
            
            tableView.rowHeight = 150
            
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserDetailsTableViewCell", for: indexPath) as! UserDetailsTableViewCell
            let info = userInfo[sections[indexPath.section]]
            var i = 0
            for (k, v) in info! {
                if i == indexPath.row {
                    cell.info.text = k.rawValue + ": " + v
                }
                i += 1
            }
            tableView.rowHeight = 45
            return cell
        }
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
