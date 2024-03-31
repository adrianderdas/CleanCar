//
//  ServiceViewController.swift
//  Czyste Auto
//
//  Created by Adrian Derdaś on 04/06/2023.
//

import UIKit

class ServiceViewController: UIViewController  {
        
    var data: Displayable?
    
    init(serviceName: String) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
 
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

      
        if let sheetPresentationController = self.presentationController as? UISheetPresentationController {
            sheetPresentationController.detents = [.medium(), .large()]
            sheetPresentationController.prefersGrabberVisible = true
        }
        
    
        view.addSubview(label)
  
        view.backgroundColor = .red
    }
    

    func setConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            

        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = data?.serviceDescriptionText
        label.text = self.data?.serviceDescriptionText
    }

}
