//
//  ClobViewController.swift
//  Czyste Auto
//
//  Created by Adrian Derdaś on 07/02/2024.
//

import UIKit

class ClubViewController: UIViewController {
    

    private let agreeSwitch: UISwitch = {
        let theSwitch = UISwitch()
        theSwitch.translatesAutoresizingMaskIntoConstraints = false
        theSwitch.isOn = false
    
        return theSwitch
    }()
    
    private let agreeSubLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 0
        label.text = "Jeżeli zaznaczysz zgodę to na Twoje urządzenia przesyłane będą powiadomienia na temat nowych promocji, w których możesz wykorzystać zebrane punkty."
        label.textColor = .systemGray
        
        return label
    }()
    
    private let agreeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17)
        
        label.text = "Powiadomienia o promocjach"
        
        return label
    }()
    
    

    private let pointsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .red
        title = "Twoje punkty"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(agreeLabel)
        view.addSubview(agreeSwitch)
        view.addSubview(agreeSubLabel)
        
        view.addSubview(pointsView)
        
      
        setConstraints()

     

    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            agreeLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            agreeLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 21),
            
            agreeSwitch.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            agreeSwitch.centerYAnchor.constraint(equalTo: agreeLabel.centerYAnchor),
            
            agreeSubLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            agreeSubLabel.leadingAnchor.constraint(equalTo: agreeLabel.leadingAnchor),
            agreeSubLabel.topAnchor.constraint(equalTo: agreeLabel.bottomAnchor,constant: 20)

        ])
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
      
    }
    

    
    


}

extension ClubViewController {
    

}
