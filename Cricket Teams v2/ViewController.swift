//
//  ViewController.swift
//  Cricket Teams v2
//
//  Created by administrator on 03/09/2021.
//

import UIKit
import Combine

class ViewController: UIViewController {
	var teamList = [Dictionary<String, [CountryModel]>.Element]()
	var playerList = [CountryModel]()
	var apiController  = APIController()
	@IBOutlet weak var tableView: UITableView!
	override func viewWillAppear(_ animated: Bool) {
		apiController.fetchData()
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		apiController.apiUpdateDelegate = self
		tableView.delegate = self
		tableView.dataSource = self
		
	}


}

extension ViewController: UITableViewDataSource{
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.teamList.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell(style: .default, reuseIdentifier: "countryCell")
		cell.textLabel?.text = self.teamList[indexPath.row].key
		return cell
	}
	
}

extension ViewController: UITableViewDelegate{
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let destination = segue.destination as? teamViewViewController
		destination?.playerList = self.playerList
		
	}
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
		self.playerList = self.teamList[indexPath.row].value
		performSegue(withIdentifier: "detailSegue", sender: nil)
	}
}

extension ViewController: APIUpdateDelegate{
	func updateAPIResult(_ controller: APIController, _ cricketTeams: [String : [CountryModel]]) {
		DispatchQueue.main.async {
			self.teamList = cricketTeams.sorted(by: {$0.key < $1.key})
			self.tableView.reloadData()
		}
	}
	
	
}

