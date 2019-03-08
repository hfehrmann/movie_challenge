//
//  CacheManager.swift
//  movie_challenge
//
//  Created by Laura Maldonado on 08-03-19.
//  Copyright © 2019 Hans Fehrmann. All rights reserved.
//

import Foundation

protocol CacheManager {
    func setData(forKey: String, data: Data)
    func getData(forKey: String) -> Data?
}

class InMemoryCacheManager: CacheManager {

    private var savedKeys: [String]
    private var cacheMapper: [String: Data]
    private var currentCacheNumber: Int
    private var maxCacheNumber: Int

    init(maxCacheNumber: Int = 100) {
        self.maxCacheNumber = maxCacheNumber
        self.currentCacheNumber = 0
        self.cacheMapper = [:]
    }

    func getData(forKey: String) -> Data? {
        return cacheMapper[forKey]
    }

    func setData(forKey: String, data: Data) {
        if currentCacheNumber == maxCacheNumber {
            let halfNumber = maxCacheNumber/2
            for key in savedKeys[..<halfNumber] {
                cacheMapper.removeValue(forKey: key)
            }
            var currentKeys: [String] = []
            for key in savedKeys[halfNumber...] {
                currentKeys.append(key)
            }
            self.savedKeys = currentKeys
            currentCacheNumber = halfNumber
        }
        self.cacheMapper[forKey] = data
        currentCacheNumber += 1
    }
}
