//
//  ClobViewController.swift
//  Czyste Auto
//
//  Created by Adrian Derdaś on 07/02/2024.
//

import UIKit

class ClubViewController: UIViewController {
    
    private let Factory = FactoriesClubViewController()
    

    private let agreeSwitch: UISwitch = {
        let theSwitch = UISwitch()
        theSwitch.translatesAutoresizingMaskIntoConstraints = false
        theSwitch.isOn = false
    
        return theSwitch
    }()
    
    
    private let firstHalfPointsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
               

        view.layer.cornerRadius = 8
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.masksToBounds = true
        
        return view
    }()
    
    private let secondHalfPointsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .brown

        
//        view.layer.borderWidth = 2
//        view.layer.borderColor = UIColor.systemRed.cgColor
        
           view.layer.cornerRadius = 8
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        return view
    }()
    
    private let pointsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Twoje punkty w klubie"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        
        return label
        
    }()
    
    private let pointsAmount: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 32)
        
        return label
        
    }()
    
    private let pointsLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
    
        
        guard let systemImage = UIImage(systemName: "car.fill") else {
            fatalError("Expected the car system image to be available")
        }
        imageView.image = systemImage.withTintColor(UIColor.white, renderingMode: .alwaysOriginal)
        
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
 
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .systemGreen
        title = "Twoje punkty"
        navigationController?.navigationBar.prefersLargeTitles = true
     
        setUpViews()
     

    }
    
    private func setUpViews() {
        
  
        
        
        let agreeLabel = Factory.makeLabel(withText: "Powiadomienia o promocjach", withFontSize: 17)
        
        let agreeSubLabel = Factory.makeSubLabel(withText: "Jeżeli zaznaczysz zgodę to na Twoje urządzenia przesyłane będą powiadomienia na temat nowych promocji, w których możesz wykorzystać zebrane punkty.")
        
        view.addSubview(agreeLabel)
        view.addSubview(agreeSwitch)
        view.addSubview(agreeSubLabel)
        
        view.addSubview(firstHalfPointsView)
        view.addSubview(secondHalfPointsView)
        
        view.addSubview(pointsLogo)
        view.addSubview(pointsLabel)
        view.addSubview(pointsAmount)
        
        NSLayoutConstraint.activate([
            agreeLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            agreeLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 21),
            
            agreeSwitch.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            agreeSwitch.centerYAnchor.constraint(equalTo: agreeLabel.centerYAnchor),
            
            agreeSubLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            agreeSubLabel.leadingAnchor.constraint(equalTo: agreeLabel.leadingAnchor),
            agreeSubLabel.topAnchor.constraint(equalTo: agreeLabel.bottomAnchor,constant: 20),
            
         
            
            firstHalfPointsView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            firstHalfPointsView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            firstHalfPointsView.topAnchor.constraint(equalTo: agreeSubLabel.bottomAnchor, constant: 20),
            firstHalfPointsView.heightAnchor.constraint(equalToConstant: 100),
            
            secondHalfPointsView.leadingAnchor.constraint(equalTo: firstHalfPointsView.leadingAnchor),
            secondHalfPointsView.trailingAnchor.constraint(equalTo: firstHalfPointsView.trailingAnchor),
            secondHalfPointsView.topAnchor.constraint(equalTo: firstHalfPointsView.bottomAnchor),
            secondHalfPointsView.heightAnchor.constraint(equalToConstant: 100),
            
            pointsLogo.leadingAnchor.constraint(equalTo: firstHalfPointsView.leadingAnchor, constant: 15),
            pointsLogo.widthAnchor.constraint(equalToConstant: 20),
            pointsLogo.topAnchor.constraint(equalTo: firstHalfPointsView.topAnchor, constant: 15),
            
            pointsLabel.leadingAnchor.constraint(equalTo: pointsLogo.trailingAnchor, constant: 10),
            pointsLabel.trailingAnchor.constraint(equalTo: firstHalfPointsView.trailingAnchor, constant: -10),
            pointsLabel.centerYAnchor.constraint(equalTo: pointsLogo.centerYAnchor),
            
            pointsAmount.topAnchor.constraint(equalTo: pointsLogo.bottomAnchor, constant: 10),
            pointsAmount.leadingAnchor.constraint(equalTo: pointsLogo.leadingAnchor),
            
        ])
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = firstHalfPointsView.bounds
        gradientLayer.colors = [UIColor(red: 233/255.0, green: 30/255.0, blue: 99/255.0, alpha: 1.0).cgColor,
                                UIColor(red: 156/255.0, green: 39/255.0, blue: 176/255.0, alpha: 1.0).cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        
        firstHalfPointsView.layer.insertSublayer(gradientLayer, at: 0)
         
    }
    


}

extension ClubViewController {
   
   

}
