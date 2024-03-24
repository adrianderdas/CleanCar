//
//  ServicesViewController.swift
//  Czyste Auto
//
//  Created by Adrian Derdaś on 04/06/2023.
//

import UIKit

class ServicesViewController: UIViewController  {
        
    var data: Displayable?
    
    init(serviceName: String) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        title = data?.serviceDescriptionText
       
        if let sheetPresentationController = self.presentationController as? UISheetPresentationController {
            sheetPresentationController.detents = [.medium(), .large()]
            sheetPresentationController.prefersGrabberVisible = true
        }
        
  
        view.backgroundColor = .red
    }
    


}
