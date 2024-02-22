//
//  FactoriesCartViewController.swift
//  Czyste Auto
//
//  Created by Adrian Derdaś on 22/02/2024.
//

import Foundation
import UIKit

class FactoriesCartViewController {
    static func makeButton(withText text: String) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .link
        button.setTitle(text, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        
        return button
    }
}
