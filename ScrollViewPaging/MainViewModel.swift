//
//  MainViewModel.swift
//  ScrollViewPaging
//
//  Created by Ihor Pedan on 17.12.2019.
//  Copyright © 2019 Ihor Pedan. All rights reserved.
//

import Foundation

final class MainViewModel: ObservableObject {
  private let newsService: NewsServiceInput
  
  @Published var articles = [Article]()
  @Published var searchKey: String = ""
  @Published var pageNumber: Int = 1
  @Published var isLoadingPage = false
  
  init(newsService: NewsServiceInput) {
    self.newsService = newsService
  }
  
  func performSearch() {
    if searchKey.isEmpty {
      articles = []
      return
    }
    guard !isLoadingPage else { return }
    isLoadingPage = true
    pageNumber = 1
    newsService.loadNewsForKey(searchKey, page: pageNumber) { [weak self] (result) in
      defer {
        self?.isLoadingPage = false
      }
      guard let self = self else { return }
      switch result {
      case .success(let list):
        self.articles = list
      case .failure(let error):
        print(error)
      }
    }
  }
  
  func loadNewPage() {
    guard !isLoadingPage else { return }
    isLoadingPage = true
    pageNumber += 1
    newsService.loadNewsForKey(searchKey, page: pageNumber) { [weak self] (result) in
      defer {
        self?.isLoadingPage = false
      }
      guard let self = self else { return }
      switch result {
      case .success(let list):
        self.articles.append(contentsOf: list)
      case .failure(let error):
        print(error)
      }
    }
  }
}
