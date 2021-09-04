//
//  ViewController.swift
//  Cricket Teams v2
//
//  Created by administrator on 03/09/2021.
//

import UIKit

class ViewController: UIViewController {
	
	// teamList contains team's data
	var teamList = [Dictionary<String, [CountryModel]>.Element]()
	
	//playerList contains players data of a team
	var playerList = [CountryModel]()
	
	//this is instance is used for api controls(making request and getting data)
	var apiController  = APIController()
	
	@IBOutlet weak var tableView: UITableView!
	
	//this method is called just before view starts loading.
	override func viewWillAppear(_ animated: Bool) {
		apiController.fetchData()
	}

	//this method is called when view is finished loading.
	override func viewDidLoad() {
		super.viewDidLoad()
		apiController.apiUpdateDelegate = self
		tableView.delegate = self
		tableView.dataSource = self
		
	}


}
//tableView's Data is configured here
extension ViewController: UITableViewDataSource{
	
	//this method returns the number of cells in a table
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.teamList.count
	}
	
	//this method configure each table view cells and their content
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell(style: .default, reuseIdentifier: "countryCell")
		cell.textLabel?.text = self.teamList[indexPath.row].key
		return cell
	}
	
}

//tableView's operations is configured here.
extension ViewController: UITableViewDelegate{
	
	// this section is to configure what to send to the segue
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let destination = segue.destination as? teamViewViewController
		destination?.playerList = self.playerList
		
	}
	
	//this method ensure what to do when a user selects a table cell
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
		self.playerList = self.teamList[indexPath.row].value
		performSegue(withIdentifier: "detailSegue", sender: nil)
	}
}

// api related controlls and uiUpdate is done here
extension ViewController: APIUpdateDelegate{
	
	//this method get the result update the teamlist
	func updateAPIResult(_ controller: APIController, _ cricketTeams: [String : [CountryModel]]) {
		DispatchQueue.main.async {
			self.teamList = cricketTeams.sorted(by: {$0.key < $1.key})
			self.tableView.reloadData()
		}
	}
	
	
}

