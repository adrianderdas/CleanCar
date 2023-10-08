//
//  OrdersViewController.swift
//  Czyste Auto
//
//  Created by Adrian Derdaś on 22/05/2023.
//

import UIKit
import FirebaseCore
import FirebaseFirestore

class OrdersViewController: UIViewController {
    
    func setSummaryLabelPriceText(totalPrice: Int) {
        summaryLabel.text = "Suma: \(totalPrice) PLN"
    }
    static let shared = OrdersViewController()
    
    private let viewModel = OrdersViewModel()

    weak var delegate: OrdersViewControllerDelegate?
    
    func setEmptyCart() {
        noSelectedServices.isHidden = false
        orderButton.isUserInteractionEnabled = false
        orderButton.backgroundColor = .gray
        tableView.isScrollEnabled = false
    }
    
    func setNoEmptyCart() {
        noSelectedServices.isHidden = true
        orderButton.isUserInteractionEnabled = true
        orderButton.backgroundColor = .link
        tableView.isScrollEnabled = true
    }
    
    private var selectedServices: [Service] = [] {
        didSet {
            print("selectedServices in OrdersViewController: \(selectedServices)")
            print("removed position")
            delegate?.didChangeServices(selectedServices.count)
            
            let totalPrice = viewModel.calculateTotalPrice(selectedServices)
             
            setSummaryLabelPriceText(totalPrice: totalPrice)
            
            if viewModel.checkIsUserSelectedAnyoneService(selectedServices) {
                setNoEmptyCart()
            } else {
                setEmptyCart()
            }
        }
    }
    
    private let noSelectedServices: UILabel = {
        let label = UILabel()
        label.text = "Twój koszyk jest pusty"
        label.textAlignment = .center
        label.textColor = .gray
        label.font = .systemFont(ofSize: 21, weight: .medium)
        return label
    }()

    private var tableView: UITableView = {
        let table = UITableView()
        table.allowsSelection = false
        
        return table
    }()
    
    let summaryLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let orderButton: UIButton = {
        let button = UIButton()
        button.setTitle("Podsumowanie", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()
    
    @objc private func orderButtonTapped() {
        let vc = SummaryOrderViewController()
        vc.hidesBottomBarWhenPushed = true
        vc.selectedServices = self.selectedServices  //Delivery data
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.clipsToBounds = true
        view.backgroundColor = .systemBackground
        
        orderButton.addTarget(self, action: #selector(orderButtonTapped), for: .touchUpInside)
        
        if let tabBarController = tabBarController as? TabBarController {
            delegate = tabBarController
        }
        
        let titleLabel = UILabel()
        titleLabel.text = "Koszyk"
        title = "Koszyk"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.topItem?.titleView = titleLabel
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let buttonHeight: CGFloat = 50
        let summaryLabelHeight: CGFloat = 50
        
        summaryLabel.frame = CGRect(x: -10 + view.width*2/3, y: view.height-buttonHeight-summaryLabelHeight, width: view.width, height: summaryLabelHeight)
        orderButton.frame = CGRect(x: 0, y: view.height-buttonHeight, width: view.width, height: buttonHeight)
        tableView.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height-summaryLabelHeight-buttonHeight)
        noSelectedServices.frame = CGRect(x: 10, y: (view.height/2), width: view.width-20, height: 100)
        
    }
    
    func loadCartItemsFromUserDefaults() {
        if let data = UserDefaults.standard.data(forKey: "SavedServices") {
            print("Data retrieved from UserDefaults: \(data)")
            do {
                selectedServices = try JSONDecoder().decode([Service].self, from: data)
                print("userdefaults import in orders: \(selectedServices)")
            } catch {
                print("error decoding selectedServices: \(error)")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("checking userfefaults")
        
        
        loadCartItemsFromUserDefaults()
        
        view.addSubview(tableView)
        view.addSubview(summaryLabel)
        view.addSubview(orderButton)
        view.addSubview(noSelectedServices)

        
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomCellForOrders.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 80
        
        tableView.reloadData()
    }
    

    
}

extension OrdersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedServices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCellForOrders
        
        let service = selectedServices[indexPath.row]
        
        print("services in let service: \(service)")
        
        cell.serviceImage.image = UIImage(named: service.image)
        cell.serviceName.text = service.name
        cell.servicePrice.text = "\(service.price) PLN"
       
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            // Delete element from datasource
            selectedServices.remove(at: indexPath.row)
            // Usuń wiersz z tabeli
            tableView.deleteRows(at: [indexPath], with: .fade)
         

            // Saving new elements to UserDefaults
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(selectedServices) {
                let defaults = UserDefaults.standard
                defaults.set(encoded, forKey: "SavedServices")
            }
        }
    }
    
    

        
}


protocol OrdersViewControllerDelegate: AnyObject {
    func didChangeServices(_ count: Int)
}

