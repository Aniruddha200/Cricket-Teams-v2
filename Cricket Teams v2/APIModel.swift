//
//  File.swift
//  Cricket Teams v2
//
//  Created by administrator on 03/09/2021.
//

import Foundation

protocol APIUpdateDelegate{
	func updateAPIResult(_ controller: APIController, _ cricketTeams: [String: [CountryModel]])
}

class APIController{
	var apiUpdateDelegate: APIUpdateDelegate?
	var playerList: [String: [CountryModel]] = [String: [CountryModel]]()
	func fetchData(){
	guard let url = URL(string: "https://test.oye.direct/players.json")
	else{
		print("URL Fomation Failed")
		return
	}
		let req = URLRequest(url: url)
		URLSession.shared.dataTask(with: req){data, _, error in
			DispatchQueue.main.async {
				guard let realData = data else{
					print("No Data found! \n\n \(error?.localizedDescription ?? "Unknown error")")
					return
				}
				
				guard let decoded = try? JSONDecoder().decode(Dictionary<String, [CountryModel]>.self, from: realData) else{
					print("Decoding Failed!")
					return
				}
				self.apiUpdateDelegate?.updateAPIResult(self, decoded)
			}
			
		}.resume()
	}
}

struct CountryModel: Codable, Identifiable{
	let name: String
	let captain: Bool?
	var id: UUID {return UUID()}
	var firstName: String {return String(name.split(separator: " ")[0])}
	var lastName: String{return String((name.split(separator: " ").count >= 2) ? name.split(separator: " ").last! : " ")}
}
