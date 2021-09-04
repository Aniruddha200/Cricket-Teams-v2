//
//  teamViewViewController.swift
//  Cricket Teams v2
//
//  Created by administrator on 03/09/2021.
//

import UIKit

class teamViewViewController: UIViewController {
	
	@IBOutlet weak var teamTableView: UITableView!
	
	//list of player in a team
	var playerList = [CountryModel]()
	
	override func viewDidLoad() {
        super.viewDidLoad()
		self.teamTableView.delegate = self
		self.teamTableView.dataSource = self

}
	//sorting button action
	@IBAction func sortButtonPressed(_ sender: UIBarButtonItem) {
		
		actionSheet()
	}
	//this method fireup the action sheet
	func actionSheet(){
		let actionSheet = UIAlertController(title: "Sort", message: "Select the below options", preferredStyle: .actionSheet)
		actionSheet.addAction(UIAlertAction(title: "Firstname", style: .default, handler: { _ in
			self.playerList.sort(by: {$0.firstName < $1.firstName})
			self.teamTableView.reloadData()
		}))
		actionSheet.addAction(UIAlertAction(title: "Surname", style: .default, handler: { _ in
			self.playerList.sort(by: {$0.lastName < $1.lastName})
			self.teamTableView.reloadData()
		}))
		
		actionSheet.addAction(UIAlertAction(title: "Cancel", style: .destructive))
		present(actionSheet, animated: true)
	}
	
	
}

//tableView's operations is configured here.
extension teamViewViewController: UITableViewDelegate{
	
	//this method ensure what to do when a user selects a table cell
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
}

//tableView's Data is configured here
extension teamViewViewController: UITableViewDataSource{
	//this method returns the number of cells in a table
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		self.playerList.count
	}
	
	//this method configure each table view cells and their content
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell(style: .default, reuseIdentifier: "teamCell")
		var captainLevel : String {
			return self.playerList[indexPath.row].captain ?? false ? " (c)" : ""
		}
		cell.textLabel?.text = self.playerList[indexPath.row].name + captainLevel
		
		return cell
	}
	
	
}
