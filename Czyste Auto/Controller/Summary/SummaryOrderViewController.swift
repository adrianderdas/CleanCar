//
//  SummaryOrderViewController.swift
//  Czyste Auto
//
//  Created by Adrian Derdaś on 19/06/2023.
//

import UIKit

class SummaryOrderViewController: UIViewController, UITableViewDataSource {
    
    
    public var selectedServices: [Service] = []

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedServices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCellForOrders
        
        let service = selectedServices[indexPath.row]
        
        cell.serviceImage.image = UIImage(named: service.image)
        cell.serviceName.text = service.name
        cell.servicePrice.text = "\(service.price) PLN"
        
        return cell
    }
    
    
    private var tableView: UITableView = {
        let table = UITableView()
        table.allowsSelection = false
        return table
    }()

    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        title = "Podsumowanie"
        
        print("selected Services in SummaryOrderViewController: \(selectedServices)")
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height/2)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.addSubview(tableView)
        
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.register(CustomCellForOrders.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 80
    }
    
}
