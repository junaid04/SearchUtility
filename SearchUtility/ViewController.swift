//
//  ViewController.swift
//  SearchUtility
//
//  Created by Hafiz Muhammad Junaid on 07/10/2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var searchView: SearchView?
    var countries = [CountryModel]()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadJSONFromFile()
        tableView.dataSource = self
    }

    // MARK: - Actions
    @IBAction func searchAction(_ sender: Any) {
        if let searchView = searchView {
            searchView.isHidden = true
        } else {
            searchView = SearchView.load(with: CGRect(x: 0, y: self.view.safeAreaInsets.top, width: self.view.frame.size.width, height: 40))
            searchView?.dataArray = countries
            self.view.addSubview(searchView!)
            
            searchView?.onTextChange = { [weak self] resultArray in
                self?.countries = resultArray as? [CountryModel] ?? []
                self?.tableView.reloadData()
            }
            
            searchView?.onCancelTap = { [weak self] resultArray in
                self?.countries = resultArray as? [CountryModel] ?? []
                self?.tableView.reloadData()
            }
        }
        searchView?.showKeyboard()
    }
    
    // MARK: - Methods
    func loadJSONFromFile() {
        guard let fileUrl = Bundle.main.url(forResource: "countries", withExtension: "json") else {
            print("File not found")
            return
        }
        
        do {
            let data = try Data(contentsOf: fileUrl)
            let decoder = JSONDecoder()
            countries = try decoder.decode([CountryModel].self, from: data)
            
        } catch {
            print("Error reading or parsing JSON: \(error)")
        }
    }

}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = countries[indexPath.row].name
        return cell
    }
}
