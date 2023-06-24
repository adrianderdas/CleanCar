//
//  FinalSummaryViewController.swift
//  Czyste Auto
//
//  Created by Adrian Derdaś on 19/06/2023.
//

import UIKit

class FinalSummaryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    public var selectedServices: [Service] = []

    var city: String = ""
    var postalCode: String = ""
    var houseNumber: String = ""
    var phone: String = ""
    

    private let summaryLabel: UILabel = {
        let label = UILabel()
        label.text = "suma"
        return label
    }()
    
    private let orderButton: UIButton = {
        let button = UIButton()
        button.setTitle("Zamów z obowiązkiem zapłaty", for: .normal)
        button.backgroundColor = .link
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        
        return button
    }()
    
    private var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.allowsSelection = false
        table.register(CustomCellForOrders.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
  
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        //view.backgroundColor = .systemBackground
        
        title = "Adres odbioru"
        
        print("selected Services in SummaryOrderViewController: \(selectedServices)")
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        let buttonHeight: CGFloat = 50
        let summaryLabelHeight: CGFloat = 50
        
       
        
        tableView.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height-buttonHeight-summaryLabelHeight)
        orderButton.frame = CGRect(x: 10, y: view.height-buttonHeight-10, width: view.width-20, height: buttonHeight)
        summaryLabel.frame = CGRect(x: 0, y: view.height-buttonHeight-summaryLabelHeight, width: view.width, height: summaryLabelHeight)
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.addSubview(tableView)
        view.addSubview(orderButton)
        view.addSubview(summaryLabel)
        
        //tableView.frame = view.bounds
        tableView.dataSource = self
       
        tableView.rowHeight = 80
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: 100))
        
        
        
        
        if section  == 0 {
            // User selectedServices section
            let imageView = UIImageView(image: UIImage(systemName: "house"))
            imageView.tintColor = .systemBlue
            imageView.contentMode = .scaleAspectFit
            header.addSubview(imageView)
            imageView.frame = CGRect(x: 5, y: 5, width: header.frame.size.height-10, height: header.frame.size.height-10)
            let label = UILabel(frame: CGRect(x: 10+imageView.frame.size.width, y: 5,
                                              width: header.frame.size.width - 15 - imageView.frame.size.width,
                                              height: header.frame.size.height-10))
            header.addSubview(label)
            label.text = "Zamówienia"
            return header
            
            
        } else {
            // User delivery data
                let imageView = UIImageView(image: UIImage(systemName: "person"))
                imageView.tintColor = .systemBlue
                imageView.contentMode = .scaleAspectFit
                header.addSubview(imageView)
                imageView.frame = CGRect(x: 5, y: 5, width: header.frame.size.height-10, height: header.frame.size.height-10)
                let label = UILabel(frame: CGRect(x: 10+imageView.frame.size.width, y: 5,
                                                  width: header.frame.size.width - 15 - imageView.frame.size.width,
                                                  height: header.frame.size.height-10))
                header.addSubview(label)
                label.text = "Twoje dane"
                return header
            

        }

      
                
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return selectedServices.count
        } else {
            return 4
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCellForOrders
            
            let service = selectedServices[indexPath.row]
            
            cell.serviceImage.image = UIImage(named: service.image)
            cell.serviceName.text = service.name
            cell.servicePrice.text = "\(service.price) PLN"
            
            return cell
        } else {
            let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
            
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Miasto"
                cell.detailTextLabel?.text = city
            case 1:
                cell.textLabel?.text = "Kod pocztowy"
                cell.detailTextLabel?.text = postalCode
            case 2:
                cell.textLabel?.text = "Numer domu"
                cell.detailTextLabel?.text = houseNumber
            case 3:
                cell.textLabel?.text = "Telefon"
                cell.detailTextLabel?.text = phone
            default:
                break
            }
            
            return cell
        }
    }

    
}






//let db = Firestore.firestore()
//
//// Add a new document with a generated ID
//var ref: DocumentReference? = nil
//ref = db.collection("orders").addDocument(data: [
//    "first": "Ada",
//    "last": "Lovelace",
//    "born": 1815,
//    "is_realized": false
//]) { err in
//    if let err = err {
//        print("Error adding document: \(err)")
//    } else {
//        print("Document added with ID: \(ref!.documentID)")
//    }
//}

