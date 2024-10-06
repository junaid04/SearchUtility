//
//  SearchView.swift
//  SearchUtility
//
//  Created by Hafiz Muhammad Junaid on 07/10/2024.
//

import UIKit

protocol Searchable {
    var searchValue: String? { get }
}

class SearchView: UIView {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var dataArray = [Searchable]()
    var onTextChange: ((_ searchResult: [Searchable]) -> ())? = nil
    var onCancelTap: ((_ searchResult: [Searchable]) -> ())? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        searchBar.delegate = self
    }
    
    // MARK: - Methods
    class func load(with frame: CGRect) -> SearchView {
        let view = Bundle.main.loadNibNamed("SearchView", owner: self)?.first as! SearchView
        view.frame = frame
        return view
    }
    
    func showKeyboard() {
        searchBar.becomeFirstResponder()
    }
    
    func hideKeyboard() {
        searchBar.resignFirstResponder()
    }
}

// MARK: - UISearchBarDelegate
extension SearchView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            let searchResult = dataArray.filter {
                if $0.searchValue?.range(of: searchText, options: .caseInsensitive) != nil {
                    return true
                } else {
                    return false
                }
            }
            onTextChange?(searchResult)
        } else {
            onTextChange?(dataArray)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.isHidden = true
        searchBar.text = ""
        searchBar.resignFirstResponder()
        onCancelTap?(dataArray)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
