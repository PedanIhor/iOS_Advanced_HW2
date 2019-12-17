//
//  NewsService.swift
//  ScrollViewPaging
//
//  Created by Ihor Pedan on 16.12.2019.
//  Copyright © 2019 Ihor Pedan. All rights reserved.
//

import Foundation

typealias NewsHandler = (Swift.Result<[Article], ErrorModel>) -> Void

final class NewsService: NewsServiceInput {
  private let apiKey = "a9b0a70b40c7497fae2f6cff41567103"
  
  func loadNewsForKey(_ key: String, page: Int, completion: @escaping NewsHandler) {
    ArticlesAPI.everythingGet(q: key, from: "2019-12-01", sortBy: "publishedAt", apiKey: apiKey, page: page) { (list, error) in
      if let list = list {
        completion(.success(list.articles ?? []))
      } else if let error = error as? ErrorModel {
        completion(.failure(error))
      }
    }
  }
}
