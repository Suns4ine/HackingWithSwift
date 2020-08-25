//
//  ViewController.swift
//  Consolidation 6
//
//  Created by Vyacheslav Pronin on 25/08/2020.
//  Copyright © 2020 Vyacheslav Pronin. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var countries = [Country]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countries.append(Country(name: "USA", capitalSity: "Wachington", peoples: 300_000_000, size: 9_834_000, value: "$", bio: "Соединённые Штаты — высокоразвитая страна, обладающая первой экономикой мира по номинальному ВВП и второй по ВВП (ППС). Хотя население страны составляет лишь 4,3 % от общемирового[9], американцам принадлежит около 40 % совокупного мирового богатства[10]."))
        countries.append(Country(name: "Russia", capitalSity: "Moscow", peoples: 148_000_000, size: 17_100_000, value: "RUB", bio: "Россия — многонациональное государство с широким этнокультурным многообразием[17]. Бо́льшая часть населения (около 75 %) относит себя к православию[18], что делает Россию страной с самым многочисленным православным населением в мире."))
        // Do any additional setup after loading the view.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let country = countries[indexPath.row]
        cell.textLabel?.text = country.name
        cell.detailTextLabel?.text = country.bio
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.country = countries[indexPath.row]
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}

