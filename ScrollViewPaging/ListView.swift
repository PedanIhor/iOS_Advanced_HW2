//
//  ListView.swift
//  ScrollViewPaging
//
//  Created by Ihor Pedan on 18.12.2019.
//  Copyright © 2019 Ihor Pedan. All rights reserved.
//

import SwiftUI

struct ListView: View {
  @EnvironmentObject var viewModel: MainViewModel

  var body: some View {
    return List(viewModel.articles) { article in
      VStack {
        Text(article.title ?? "Untitled")
      }.onAppear {
        self.onItemShowed(article)
      }
    }
  }
}

extension ListView {
  func onItemShowed<T: Identifiable>(_ item: T) {
    if viewModel.articles.isLastItem(item) {
      viewModel.loadNewPage()
    }
  }
}

// MARK: - Article+Identifiable
extension Article: Identifiable {
  public var id: String { url ?? title ?? UUID().uuidString }
}
