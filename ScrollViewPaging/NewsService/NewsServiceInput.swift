//
//  NewsServiceInput.swift
//  ScrollViewPaging
//
//  Created by Ihor Pedan on 16.12.2019.
//  Copyright © 2019 Ihor Pedan. All rights reserved.
//

import Foundation

protocol NewsServiceInput {
  func loadNewsForKey(_ key: String, page: Int, completion: @escaping NewsHandler)
}
