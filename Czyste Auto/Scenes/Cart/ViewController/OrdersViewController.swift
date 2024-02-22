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
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Twój koszyk jest pusty"
        label.textAlignment = .center
        label.textColor = .gray
        label.font = .systemFont(ofSize: 21, weight: .medium)
        
        return label
    }()
    
    private var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.allowsSelection = false
        
        return table
    }()
    
    let summaryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let orderButton: UIButton = {
        return FactoriesCartViewController.makeButton(withText: "Podsumowanie")
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
        
        setupConstraints()
        
    }
    
    
    func setupConstraints() {
        
        view.addSubview(orderButton)
        view.addSubview(summaryLabel)
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 120
        tableView.reloadData()
        
        NSLayoutConstraint.activate([
            orderButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            orderButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            orderButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            orderButton.heightAnchor.constraint(equalToConstant: 50),
            
            summaryLabel.bottomAnchor.constraint(equalTo: orderButton.topAnchor, constant: -20),
            summaryLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            tableView.bottomAnchor.constraint(equalTo: summaryLabel.topAnchor, constant: -20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        selectedServices = viewModel.loadCartItemsFromUserDefaults() as! [Service]
        tableView.reloadData()

    }
}

extension OrdersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedServices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        
        let service = selectedServices[indexPath.row]
        
        print("services in let service: \(service)")
        
        cell.serviceImage.image = UIImage(named: service.image)
        cell.serviceName.text = service.name
        cell.servicePrice.text = "\(service.price) PLN"
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            selectedServices.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            viewModel.saveNewServices(selectedServices)
        }
    }
}

protocol OrdersViewControllerDelegate: AnyObject {
    func didChangeServices(_ count: Int)
}

