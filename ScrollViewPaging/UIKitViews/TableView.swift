//
//  TableView.swift
//  ScrollViewPaging
//
//  Created by Ihor Pedan on 17.12.2019.
//  Copyright © 2019 Ihor Pedan. All rights reserved.
//

import SwiftUI
import UIKit
import Combine

struct TableView: UIViewRepresentable {
  @EnvironmentObject var viewModel: MainViewModel
  
  func makeUIView(context: UIViewRepresentableContext<TableView>) -> UITableView {
    let table = UITableView(frame: .zero, style: .plain)
    table.delegate = context.coordinator
    table.dataSource = context.coordinator
    table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    return table
  }
  
  func updateUIView(_ uiView: UITableView, context: UIViewRepresentableContext<TableView>) {
    print("update")
    let coordinator = context.coordinator
    if viewModel.articles != coordinator.items {
      let indexPaths = (coordinator.items.count ..< viewModel.articles.count).map { IndexPath(row: $0, section: 0) }
      coordinator.items = viewModel.articles
      uiView.insertRows(at: indexPaths, with: .right)
    }
  }
  
  func makeCoordinator() -> Coordinator {
    Coordinator(viewModel: viewModel)
  }
  
  class Coordinator: NSObject, UITableViewDataSource, UITableViewDelegate {
    let viewModel: MainViewModel
    var items: [Article]
    
    init(viewModel: MainViewModel) {
      self.viewModel = viewModel
      items = viewModel.articles
    }
    
//    func appendListWith(_ newItems: [Article]) {
//
//    }
    
    // MARK: - UITableViewDataSource, UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      guard
        let text = items[indexPath.row].title else { return 0 }
      let width = tableView.bounds.insetBy(dx: 16, dy: 0).width
      return text.height(withConstrainedWidth: width, font: .systemFont(ofSize: 18)) + 16
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else { fatalError() }
      cell.textLabel?.numberOfLines = 0
      cell.textLabel?.text = items[indexPath.row].title
      cell.textLabel?.font = .systemFont(ofSize: 18)
      return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
      if items.isLastItem(items[indexPath.row]) {
        viewModel.loadNewPage()
      }
    }
  }
}

extension Article: Equatable {
  public static func == (lhs: Article, rhs: Article) -> Bool {
    lhs.id == rhs.id
  }
}
