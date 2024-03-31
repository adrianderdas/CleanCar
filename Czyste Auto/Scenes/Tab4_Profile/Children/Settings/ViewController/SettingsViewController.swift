import UIKit
import FirebaseFirestore
import FirebaseAuth

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var userID = FirebaseService.shared.getuserId()
    var firstName: String = FirebaseService.shared.firebaseFirstName ?? "Brak danych"
    var lastName: String = FirebaseService.shared.firebaseLastName ?? "Brak danych"
    var phone: String = FirebaseService.shared.firebasePhone ?? "Brak danych"
    var email: String = FirebaseService.shared.firebaseEmail ?? "Brak danych"
    var city: String = FirebaseService.shared.firebaseCity ?? "Brak danych"
    var postalCode: String = FirebaseService.shared.firebasePostalCode ?? "Brak danych"
    var houseNumber: String = FirebaseService.shared.firebaseHouseNumber ?? "Brak danych"

    
    private let logOutButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Wyloguj się", for: .normal)
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()
    
    private let footerView: UIView = {
        let view = UIView()
  
        return view
    }()
    
 
    private var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
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
                self?.navigationController?.popToRootViewController(animated: false)

                
            } catch  {
                print ("Error signing out")
            }
        }))
                
        actionSheet.addAction(UIAlertAction(title: "Anuluj", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setView()
        setConstraints()
        setTableView()
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            logOutButton.leadingAnchor.constraint(equalTo: footerView.layoutMarginsGuide.leadingAnchor),
            logOutButton.topAnchor.constraint(equalTo: footerView.topAnchor),
            logOutButton.trailingAnchor.constraint(equalTo: footerView.layoutMarginsGuide.trailingAnchor),
            logOutButton.bottomAnchor.constraint(equalTo: footerView.bottomAnchor),
        ])
    }
    
    func setTableView() {
        tableView.dataSource = self
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.tableFooterView = footerView
    }
    
    func setView() {
        title = "Ustawienia"
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.isTranslucent = false
        logOutButton.addTarget(self, action: #selector(didTapLogOut), for: .touchUpInside)
        view.addSubview(tableView)
        footerView.addSubview(logOutButton)
        let buttonHeight: CGFloat = 50
        footerView.frame = CGRect(x: 0, y: 0, width: 0, height: buttonHeight)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
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
                        
            let label = UILabel()
            
            header.addSubview(imageView)
            
            imageView.frame = CGRect(x: 5, y: 5, width: 50, height: 50)
            label.frame = CGRect(x: imageView.frame.width+10, y: 5, width: 200, height: 50)
    
            
            header.addSubview(label)
            label.text = "Adres odbioru pojazdu"
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
            return 4
        } else {
            return 3
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
            case 3:
                cell.textLabel?.text = "E-mail"
                cell.detailTextLabel?.text = email
        
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
            default:
                break
            }
            
            return cell
        }
    }
}
