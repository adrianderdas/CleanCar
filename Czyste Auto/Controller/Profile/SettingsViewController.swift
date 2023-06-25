import UIKit
import FirebaseFirestore
import JGProgressHUD

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let spinner = JGProgressHUD(style: .dark)
    
    public var selectedServices: [Service] = []
    
    var totalPrice: Int = 0

    var city: String = FirebaseService.shared.firebaseCity ?? "Brak danych"
    var postalCode: String = FirebaseService.shared.firebasePostalCode ?? "Brak danych"
    var houseNumber: String = FirebaseService.shared.firebaseHouseNumber ?? "Brak danych"
    var phone: String = FirebaseService.shared.firebasePhone ?? "Brak danych"
    
    var userID = FirebaseService.shared.getuserId()

  
    private var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.allowsSelection = false
        table.register(CustomCellForOrders.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
  

    override func viewDidLoad() {
        super.viewDidLoad()

        //view.backgroundColor = .systemBackground
        
        title = "Ustawienia"
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        let buttonHeight: CGFloat = 50
        let summaryLabelHeight: CGFloat = 50
        
       
        
        tableView.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height)
       
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.addSubview(tableView)
        
        //tableView.frame = view.bounds
        tableView.dataSource = self
       
        tableView.rowHeight = 80
        tableView.delegate = self
        

    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: 100))
        
        
        if section  == 0 {
            // User selectedServices section
            let imageView = UIImageView(image: UIImage(systemName: "person"))
            imageView.tintColor = .systemBlue
            imageView.contentMode = .scaleAspectFit
            header.addSubview(imageView)
            imageView.frame = CGRect(x: 5, y: 5, width: header.frame.size.height-10, height: header.frame.size.height-10)
            let label = UILabel(frame: CGRect(x: 10+imageView.frame.size.width, y: 5,
                                              width: header.frame.size.width - 15 - imageView.frame.size.width,
                                              height: header.frame.size.height-10))
            header.addSubview(label)
            label.text = "Twoje dane osobowe"
            return header
            
            
        } else {
            // User delivery data
                let imageView = UIImageView(image: UIImage(systemName: "house"))
                imageView.tintColor = .systemBlue
                imageView.contentMode = .scaleAspectFit
                header.addSubview(imageView)
                imageView.frame = CGRect(x: 5, y: 5, width: header.frame.size.height-10, height: header.frame.size.height-10)
                let label = UILabel(frame: CGRect(x: 10+imageView.frame.size.width, y: 5,
                                                  width: header.frame.size.width - 15 - imageView.frame.size.width,
                                                  height: header.frame.size.height-10))
                header.addSubview(label)
                label.text = "Domyślny adres odbioru"
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
            return 3
        } else {
            return 4
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
            
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Imię"
                cell.detailTextLabel?.text = city
            case 1:
                cell.textLabel?.text = "Nazwisko"
                cell.detailTextLabel?.text = postalCode
            case 2:
                cell.textLabel?.text = "Numer telefonu"
                cell.detailTextLabel?.text = houseNumber
        
            default:
                break
            }
            
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








