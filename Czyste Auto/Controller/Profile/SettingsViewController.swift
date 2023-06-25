import UIKit
import FirebaseFirestore
import JGProgressHUD
import FirebaseAuth

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let spinner = JGProgressHUD(style: .dark)
    
    
    
  
    var city: String = FirebaseService.shared.firebaseCity ?? "Brak danych"
    var postalCode: String = FirebaseService.shared.firebasePostalCode ?? "Brak danych"
    var houseNumber: String = FirebaseService.shared.firebaseHouseNumber ?? "Brak danych"
    
    
    var firstName: String = FirebaseService.shared.firebaseFirstName ?? "Brak danych"
    var lastName: String = FirebaseService.shared.firebaseLastName ?? "Brak danych"
    var phone: String = FirebaseService.shared.firebasePhone ?? "Brak danych"
    
    var userID = FirebaseService.shared.getuserId()
    
    
    private let logOutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Wyloguj się", for: .normal)
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        
        return button
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let contentContainerView: UIView = {
        let view = UIView()
        return view
    }()
    
    
  
    private var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.allowsSelection = false
        table.register(CustomCellForOrders.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    @objc private func didTapLogOut() {
       
        
        
        let actionSheet = UIAlertController(title: "Wylogowywanie", message: "Czy na pewno chcesz się wylogować?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Wyloguj się", style: .destructive, handler: { [weak self] _ in
            guard let strongSelf = self else {
                return
            }
            do {
                try FirebaseAuth.Auth.auth().signOut()
                UserDefaults.standard.removeObject(forKey: "SavedServices")
                let vc = LoginViewController()
                let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                strongSelf.present(nav, animated: false)
            } catch  {
                print ("Error signing out")
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Anuluj", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true)

        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        //view.backgroundColor = .systemBackground
        
        title = "Ustawienia"
        
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.isTranslucent = false
        
        logOutButton.addTarget(self, action: #selector(didTapLogOut), for: .touchUpInside)
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let buttonHeight: CGFloat = 50
    
       
        tableView.frame = CGRect(x: 10, y: 0, width: view.width-20, height: view.height)
        
        logOutButton.frame = CGRect(x: 0, y: tableView.bottom+buttonHeight+60, width: tableView.frame.width, height: buttonHeight)
    }
     
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
               
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.tableFooterView = logOutButton
        

    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: 60))
        
        
        if section  == 0 {
            let label = UILabel()
            let imageView = UIImageView(image: UIImage(systemName: "person"))
            imageView.tintColor = UIColor.label
            header.addSubview(imageView)
            
            
            
            imageView.frame = CGRect(x: 5, y: 5, width: 50, height: 50)
            label.frame = CGRect(x: imageView.frame.width+10, y: 5, width: 200, height: 50)
            header.addSubview(label)
            label.text = "Dane osobowe"
            return header
            
            
        } else {
            let imageView = UIImageView(image: UIImage(systemName: "house"))
            imageView.tintColor = UIColor.label
            imageView.contentMode = .scaleAspectFit
            
            //let imageEditView = UIImageView(image: UIImage(systemName: "square.and.pencil"))
            
            
            let label = UILabel()
            
            header.addSubview(imageView)
            
            imageView.frame = CGRect(x: 5, y: 5, width: 50, height: 50)
            label.frame = CGRect(x: imageView.frame.width+10, y: 5, width: 200, height: 50)
           // imageEditView.frame = CGRect(x: view.width-60, y: 5, width: 50, height: 50)
            
            
            header.addSubview(label)
            label.text = "Adres odbioru pojazdu"
            //header.addSubview(imageEditView)
            return header
            
        }

      
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
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
                cell.detailTextLabel?.text = firstName
            case 1:
                cell.textLabel?.text = "Nazwisko"
                cell.detailTextLabel?.text = lastName
            case 2:
                cell.textLabel?.text = "Numer telefonu"
                cell.detailTextLabel?.text = phone
        
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








