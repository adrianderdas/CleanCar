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
    
    //let cleanCarViewController = CleanCarViewController()
    
    static let shared = OrdersViewController()
    
    weak var delegate: OrdersViewControllerDelegate?
    
    public var selectedServices: [Service] = [] {
        didSet {
            print("selectedServices in OrdersViewController: \(selectedServices)")
            print("removed position")
            delegate?.didChangeServices(selectedServices.count)
            
            let totalPrice = selectedServices.reduce(0) { $0 + $1.price}
            
            summaryLabel.text = "Suma: \(totalPrice) PLN"
        }
        
    }
    
    private var tableView: UITableView = {
        let table = UITableView()
        table.allowsSelection = false
        return table
    }()
    
    private let summaryLabel: UILabel = {
        let label = UILabel()

        return label
    }()

    
    private let orderButton: UIButton = {
        let button = UIButton()
        button.setTitle("Podsumowanie", for: .normal)
        button.backgroundColor = .link
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        
        return button
    }()
    
    @objc private func orderButtonTapped() {
        let vc = SummaryOrderViewController()
        vc.hidesBottomBarWhenPushed = true
        vc.selectedServices = self.selectedServices  //Przekazanie danych
        
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
        
        //orderButton.addTarget(self, action: #selector(orderButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let buttonHeight: CGFloat = 50
        let summaryLabelHeight: CGFloat = 50
        
        summaryLabel.frame = CGRect(x: -10 + view.width*2/3, y: view.height-buttonHeight-summaryLabelHeight, width: view.width, height: summaryLabelHeight)
        orderButton.frame = CGRect(x: 0, y: view.height-buttonHeight, width: view.width, height: buttonHeight)
        tableView.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height-summaryLabelHeight-buttonHeight)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("checking userfefaults")
        if let data = UserDefaults.standard.data(forKey: "SavedServices") {
            print("Data retrieved from UserDefaults: \(data)")
            do {
                selectedServices = try JSONDecoder().decode([Service].self, from: data)
                print("userdefaults import in orders: \(selectedServices)")
            } catch {
                print("error decoding selectedServices: \(error)")
            }
        }
        
        print("orderscontroller: \(selectedServices)")
        
        view.addSubview(tableView)
        view.addSubview(summaryLabel)
        view.addSubview(orderButton)
        
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
            
            // Usuń element z danych źródłowych
            selectedServices.remove(at: indexPath.row)
            // Usuń wiersz z tabeli
            tableView.deleteRows(at: [indexPath], with: .fade)
           // let serv = 55
           // delegate?.didChangeServices(serv)

            // Zapisz nowy stan danych do UserDefaults
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(selectedServices) {
                let defaults = UserDefaults.standard
                defaults.set(encoded, forKey: "SavedServices")
            }
        }
    }
    
    

        
}

class CustomCellForOrders: UITableViewCell {
    let serviceImage = UIImageView()
    let serviceName = UILabel()
    let servicePrice = UILabel()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        print("CustomCellForOrders initialised")
        addSubview(serviceImage)
        addSubview(serviceName)
        addSubview(servicePrice)
        
        serviceImage.frame = CGRect(x: 10, y: serviceImage.frame.height/2, width: 100, height: 100)
        serviceImage.layer.cornerRadius = serviceImage.frame.width/2
        serviceImage.layer.masksToBounds = true
        serviceName.frame = CGRect(x: serviceImage.width+20, y: 40, width: 120, height: 30)
        servicePrice.frame = CGRect(x: serviceImage.width+200, y: serviceName.height+20, width: 80, height: 30)
        
        serviceImage.contentMode = .scaleAspectFit

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    }


protocol OrdersViewControllerDelegate: AnyObject {
    func didChangeServices(_ count: Int)
}

