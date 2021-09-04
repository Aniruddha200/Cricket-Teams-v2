//
//  teamViewViewController.swift
//  Cricket Teams v2
//
//  Created by administrator on 03/09/2021.
//

import UIKit

class teamViewViewController: UIViewController {
	
	@IBOutlet weak var teamTableView: UITableView!
	
	
	var playerList = [CountryModel]()
	override func viewDidLoad() {
        super.viewDidLoad()
		self.teamTableView.delegate = self
		self.teamTableView.dataSource = self

}
	
	@IBAction func sortButtonPressed(_ sender: UIBarButtonItem) {
		
		actionSheet()
	}
	
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


extension teamViewViewController: UITableViewDelegate{
	
}

extension teamViewViewController: UITableViewDataSource{
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		self.playerList.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell(style: .default, reuseIdentifier: "teamCell")
		var captainLevel : String {
			return self.playerList[indexPath.row].captain ?? false ? " (c)" : ""
		}
		cell.textLabel?.text = self.playerList[indexPath.row].name + captainLevel
		
		return cell
	}
	
	
}
