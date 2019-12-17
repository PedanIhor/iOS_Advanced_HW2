//
//  SearchBar.swift
//  ScrollViewPaging
//
//  Created by Ihor Pedan on 17.12.2019.
//  Copyright © 2019 Ihor Pedan. All rights reserved.
//

import SwiftUI
import UIKit

struct SearchBar: UIViewRepresentable {
  @Binding var text: String
  var searchAction: (() -> Void)?
  
  // MARK: - UIViewRepresentable
  func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
    let bar = UISearchBar(frame: .zero)
    bar.delegate = context.coordinator
    return bar
  }
  
  func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
    uiView.text = text
  }
  
  func makeCoordinator() -> Coordinator {
    return Coordinator(text: $text, searchAction: searchAction)
  }
  
  // MARK: - Coordinator
  class Coordinator: NSObject, UISearchBarDelegate {
    @Binding var text: String
    private let searchAction: (() -> Void)?
    
    init(text : Binding<String>, searchAction: (() -> Void)? = nil) {
      _text = text
      self.searchAction = searchAction
    }
    
    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String) {
      text = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
      UIApplication.shared.endEditing(false)
      searchAction?()
    }
  }
}
