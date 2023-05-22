//
//  CleanCarViewController.swift
//  Czyste Auto
//
//  Created by Adrian Derdaś on 22/05/2023.
//

import UIKit

class CleanCarViewController: UIViewController, UISearchBarDelegate {

    
    
    //private var completion: ((SearchResult) -> (Void))?
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Wyszukaj usługę"
        searchBar.showsCancelButton = true
        searchBar.showsScopeBar = true
        
        //searchBar.showsBookmarkButton = true
        //searchBar.showsSearchResultsButton = true
        //searchBar.showsLargeContentViewer = true
        
        return searchBar
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        view.backgroundColor = .red
        title = "Umyj auto"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //bez tego nie działa reakcja na cancel
        searchBar.delegate = self
        
        
        view.addSubview(scrollView)
        scrollView.addSubview(searchBar)
        
        scrollView.isUserInteractionEnabled = true
        

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = view.bounds
        
        let size = scrollView.width
        
        searchBar.frame = CGRect(x: 0, y: 0, width: size, height: 100)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let cancelButton = searchBar.value(forKey: "cancelButton") as? UIButton {
            cancelButton.setTitle("Anuluj", for: .normal)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.text = nil
            searchBar.resignFirstResponder()
        }

}
