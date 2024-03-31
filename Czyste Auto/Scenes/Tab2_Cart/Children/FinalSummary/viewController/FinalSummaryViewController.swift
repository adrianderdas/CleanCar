//
//  FinalSummaryViewController.swift
//  Czyste Auto
//
//  Created by Adrian Derdaś on 19/06/2023.
//

import UIKit
import AlamofireImage

class FinalSummaryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let viewModel = FinalSummaryViewModel()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        return indicator
    }()
    
    public var selectedServices: [DownloadedService] = []
    
    var totalPrice: Int = 0

    var city: String = ""
    var postalCode: String = ""
    var houseNumber: String = ""
    var phone: String = ""
    

    private let summaryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let orderButton: UIButton = {
        return FactoriesCartViewController.makeButton(withText: "Zamów z obowiązkiem zapłaty")
    }()
    
    let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
    
    private var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.allowsSelection = false
        table.register(CustomCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        title = "Sprawdź dane"
        orderButton.addTarget(self, action: #selector(orderButtonTapped), for: .touchUpInside)
        print("selected Services in SummaryOrderViewController: \(selectedServices)")
        
        viewModel.delegate = self
        setConstraints()
    }
    

    func setConstraints() {
        view.addSubview(tableView)
        view.addSubview(summaryLabel)
        view.addSubview(orderButton)
        NSLayoutConstraint.activate([
       
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: summaryLabel.topAnchor),
            
            summaryLabel.bottomAnchor.constraint(equalTo: orderButton.topAnchor, constant: -20),
            summaryLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            orderButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            orderButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            orderButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            orderButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        
        tableView.dataSource = self
       
        tableView.delegate = self
        
        totalPrice = Int(selectedServices.reduce(0) { $0 + $1.price })
           summaryLabel.text = "Suma: \(totalPrice) PLN"

    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: 60))
        
        
        if section  == 0 {
            // User selectedServices section
            let imageView = UIImageView(image: UIImage(systemName: "list.clipboard"))
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
        return 60
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 110
        } else {
            return 50
        }
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
            
            let service = selectedServices[indexPath.row]
            
            cell.serviceImage.af.setImage(withURL: service.imageURL)
            cell.serviceName.text = service.serviceTitleLabelText
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
    
    @objc private func orderButtonTapped() {
        
        activityIndicator.startAnimating()
                
        viewModel.uploadOrderToFirebase(selectedServices: selectedServices, city: city, postalCode: postalCode, houseNumber: houseNumber, phone: phone, totalPrice: totalPrice)
    }
}

extension FinalSummaryViewController: FinalSummaryViewModelDelegate{
    
    func didUploadOrderSuccess() {
        self.activityIndicator.stopAnimating()
        
        let alertController = UIAlertController(title: "Twoje zamówienie zostało przyjęte do realizacji", message: nil, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Powrót do koszyka", style: .default) { (action:UIAlertAction!) in
            self.navigationController?.popToRootViewController(animated: true)
        }
        
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion:nil)
        
    }
    
    func didFailInUploadOrder(_ error: Error) {
        let alertController = UIAlertController(title: "Wystąpił błąd podczas przesyłania zamówienia. Jeżeli problem się powtarza skontaktuj się z administratorem", message: nil, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Powrót do koszyka", style: .default) { (action:UIAlertAction!) in
            self.navigationController?.popToRootViewController(animated: true)
        }
        
        
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion:nil)
    }

       
}








