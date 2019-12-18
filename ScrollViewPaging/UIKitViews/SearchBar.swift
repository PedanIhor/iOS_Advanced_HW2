//
//  SearchBar.swift
//  ScrollViewPaging
//
//  Created by Ihor Pedan on 17.12.2019.
//  Copyright © 2019 Ihor Pedan. All rights reserved.
//

import SwiftUI
import UIKit

extension SearchBar {
  enum Scope: Int, CaseIterable {
    case swiftUI
    case uiKit
    
    var title: String {
      switch self {
      case .swiftUI: return "SwiftUI"
      case .uiKit: return "UIKit"
      }
    }
    
    var scopeIndex: Int { rawValue }
  }
}

struct SearchBar: UIViewRepresentable {
  @Binding var text: String
  @Binding var selectedScope: Scope
  var searchAction: (() -> Void)?
  
  // MARK: - UIViewRepresentable
  func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
    let bar = UISearchBar(frame: .zero)
    bar.delegate = context.coordinator
    bar.placeholder = "Search"
    bar.scopeButtonTitles = Scope.allCases.map { $0.title }
    bar.selectedScopeButtonIndex = selectedScope.scopeIndex
    bar.showsScopeBar = true
    return bar
  }
  
  func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
    uiView.text = text
    uiView.selectedScopeButtonIndex = selectedScope.scopeIndex
  }
  
  func makeCoordinator() -> Coordinator {
    Coordinator(text: $text, selectedScope: $selectedScope, searchAction: searchAction)
  }
  
  // MARK: - Coordinator
  class Coordinator: NSObject, UISearchBarDelegate {
    @Binding var text: String
    @Binding var selectedScope: SearchBar.Scope
    private let searchAction: (() -> Void)?
    
    init(text : Binding<String>, selectedScope: Binding<SearchBar.Scope>, searchAction: (() -> Void)? = nil) {
      _text = text
      _selectedScope = selectedScope
      self.searchAction = searchAction
    }
    
    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String) {
      text = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
      searchBar.endEditing(false)
      searchAction?()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
      guard let scope = SearchBar.Scope(rawValue: selectedScope) else { return }
      self.selectedScope = scope
    }
  }
}
