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
        countries.append(Country(name: "USA", society: "Wachngton", peoples: 300_000_000, size: 9_834_000, value: "$", bio: "Соединённые Штаты — высокоразвитая страна, обладающая первой экономикой мира по номинальному ВВП и второй по ВВП (ППС). Хотя население страны составляет лишь 4,3 % от общемирового[9], американцам принадлежит около 40 % совокупного мирового богатства[10]."))
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

}

