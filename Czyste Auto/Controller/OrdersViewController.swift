//
//  OrdersViewController.swift
//  Czyste Auto
//
//  Created by Adrian Derdaś on 22/05/2023.
//

import UIKit

class OrdersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //let cleanCarViewController = CleanCarViewController()
    

    weak var delegate: OrdersViewControllerDelegate?
    
    var selectedServices: [Service] = [] {
        didSet {
            print("selectedServices in OrdersViewController: \(selectedServices)")
            print("removed position")
            delegate?.didChangeServices(selectedServices.count)
        }
        
    }
    
    
    
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
    
    class CustomCell: UITableViewCell {
        let serviceImage = UIImageView()
        let serviceName = UILabel()
        let servicePrice = UILabel()
    
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            print("CustomCell initialised")
            addSubview(serviceImage)
            addSubview(serviceName)
            addSubview(servicePrice)
            
            serviceImage.frame = CGRect(x: 10, y: serviceImage.frame.height/2, width: 100, height: 100)
            serviceName.frame = CGRect(x: serviceImage.width+20, y: 40, width: 120, height: 30)
            servicePrice.frame = CGRect(x: serviceImage.width+230, y: serviceName.height+20, width: 80, height: 30)

        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        }
        
    private let tableView: UITableView = {
        let table = UITableView()
        table.allowsSelection = false
        return table
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.clipsToBounds = true
        view.backgroundColor = .systemBackground
        
        if let tabBarController = tabBarController as? TabBarController {
            delegate = tabBarController
        }
        
        let titleLabel = UILabel()
        titleLabel.text = "Koszyk"
        //title = "Koszyk"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.titleView = titleLabel
        
       

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
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 120
        
        tableView.reloadData()
    }
    

}


protocol OrdersViewControllerDelegate: AnyObject {
    func didChangeServices(_ count: Int)
}

