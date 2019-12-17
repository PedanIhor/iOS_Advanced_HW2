//
//  MainView.swift
//  ScrollViewPaging
//
//  Created by Ihor Pedan on 16.12.2019.
//  Copyright © 2019 Ihor Pedan. All rights reserved.
//

import SwiftUI
import Combine

// MARK: - MainView
struct MainView: View {
  @EnvironmentObject var viewModel: MainViewModel
  
  var body: some View {
    let searchKeyBind = Binding(get: { self.viewModel.searchKey },
                                set: { self.viewModel.searchKey = $0 })
    let isLoadingBind = Binding(get: { self.viewModel.isLoadingPage },
                                set: { self.viewModel.isLoadingPage = $0 })
    return NavigationView {
      VStack {
        SearchBar(text: searchKeyBind) {
            self.viewModel.performSearch()
        }
        List(viewModel.articles) { article in
          VStack {
            Text(article.title ?? "Untitled")
            if self.viewModel.isLoadingPage && self.viewModel.articles.isLastItem(article) {
              Divider()
              ActivityIndicator(isAnimating: isLoadingBind)
            }
          }.onAppear {
            self.onItemShowed(article)
          }
        }
      }.navigationBarTitle("News")
    }
  }
}

extension MainView {
  func onItemShowed<T: Identifiable>(_ item: T) {
    if viewModel.articles.isLastItem(item) {
      viewModel.loadNewPage()
    }
  }
}

// MARK: - Article+Identifiable
extension Article: Identifiable {
  public var id: String { url ?? title ?? "" }
}

// MARK: - Preview
struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView().environmentObject(MainViewModel(newsService: NewsService()))
  }
}
