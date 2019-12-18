//
//  ActivityIndicator.swift
//  ScrollViewPaging
//
//  Created by Ihor Pedan on 17.12.2019.
//  Copyright © 2019 Ihor Pedan. All rights reserved.
//

import UIKit
import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
  @Binding var isAnimating: Bool
  
  func makeUIView(context: Context) -> UIActivityIndicatorView {
    let v = UIActivityIndicatorView(style: .medium)
    v.hidesWhenStopped = true
    return v
  }
  
  func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
    if isAnimating {
      uiView.startAnimating()
    } else {
      uiView.stopAnimating()
    }
  }
}
