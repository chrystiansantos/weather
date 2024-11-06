//
//  UIView+Extensions.swift
//  Weather App
//
//  Created by chrystiansantos.dev on 05/11/24.
//

import Foundation
import UIKit

extension UIView {
    func setContraintsToParent(_ parent: UIView){
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: parent.topAnchor),
            self.leadingAnchor.constraint(equalTo: parent.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: parent.trailingAnchor),
            self.bottomAnchor.constraint(equalTo: parent.bottomAnchor)
        ])
    }
}