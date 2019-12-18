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
    let selectedScopeBind = Binding(get: { self.viewModel.selectedScope },
                                    set: { self.viewModel.selectedScope = $0 })
    let isLoadingBind = Binding(get: { self.viewModel.isLoadingPage },
                                set: { self.viewModel.isLoadingPage = $0 })
    return NavigationView {
      VStack {
        SearchBar(text: searchKeyBind, selectedScope: selectedScopeBind) {
          self.viewModel.performSearch()
        }
        listView()
      }
      .navigationBarItems(trailing: ActivityIndicator(isAnimating: isLoadingBind))
      .navigationBarTitle("News")
    }
  }
}

extension MainView {
  private func listView() -> AnyView {
    switch viewModel.selectedScope {
    case .swiftUI:
      return AnyView(ListView().environmentObject(viewModel))
    case .uiKit:
      return AnyView(TableView().environmentObject(viewModel))
    }
  }
}

// MARK: - Preview
struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView().environmentObject(MainViewModel(newsService: NewsService()))
  }
}
