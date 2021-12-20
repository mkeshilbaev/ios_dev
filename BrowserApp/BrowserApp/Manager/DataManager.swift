//
//  DataManager.swift
//  BrowserApp
//
//  Created by Madi Keshilbayev on 25.02.2021.
//  Copyright © 2021 Madi Keshilbayev. All rights reserved.
//

import Foundation

class DataManager {
    
    private var websites = [
        Website(title: "VK", url: URL(string: "https://vk.com")!),
        Website(title: "Google", url: URL(string: "https://google.com")!),
        Website(title: "Instagram", url: URL(string: "https://instagram.com")!)
    ]
    
    private var favourites = [Website]()
    
    var isFavourites = false
    
    var numberOfWebsites: Int {
        get {
            return isFavourites ? favourites.count : websites.count
        }
    }
    
    func add(website: Website) {
        websites.append(website)
    }
    
    func addToFavourites(website: Website) {
        favourites.append(website)
    }
    
    func getWebsite(at index: Int) -> Website {
        return isFavourites ? favourites[index] : websites[index]
    }
    
}
