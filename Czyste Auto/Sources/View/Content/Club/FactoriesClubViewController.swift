//
//  FactoriesClubViewController.swift
//  Czyste Auto
//
//  Created by Adrian Derdaś on 11/02/2024.
//

import UIKit

class FactoriesClubViewController {
    func makeLabel(withText text: String, withFontSize fontSize: CGFloat) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.backgroundColor = .red
        return label
    }
    
     
    func makeSubLabel(withText text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 0
        label.text = text
        label.textColor = .systemGray
        
        return label
    }
    
    func makeLabelInFirstHalfPointsView(withText text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 1
        label.text = text
        label.textColor = .white
        return label
    }
    
    
}
