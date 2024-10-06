//
//  CountryModel.swift
//  SearchUtility
//
//  Created by Hafiz Muhammad Junaid on 07/10/2024.
//

final class CountryModel: Codable, Searchable {
    let name: String
    let code: String
    
    var searchValue: String? {
        return name
    }
}
