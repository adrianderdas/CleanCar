import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.clipsToBounds = true
        
        return table
    }()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return FirebaseService.shared.firebaseOrders.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FirebaseService.shared.firebaseOrders[section].orders.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let order = FirebaseService.shared.firebaseOrders[section]
        
        if order.isRealized {
            return "Zrealizowane"
        } else {
            return "Niezrealizowane"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath)
        let order = FirebaseService.shared.firebaseOrders[indexPath.section]
        let service = order.orders[indexPath.row]
        
        cell.textLabel?.text = service.name
        cell.detailTextLabel?.text = "\(service.price)"
        
        return cell
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        FirebaseService.shared.getUserOrders() { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setTableView()
        setConstraints()
        setSettingsBarButtonItem()
    }
    
    func setView() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        title = "Profil"
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func setSettingsBarButtonItem() {
        if let customImage = UIImage(systemName: "gearshape") {
            let customButton = UIBarButtonItem(image: customImage, style: .plain, target: self, action: #selector(didTapSettings))
            navigationItem.rightBarButtonItem = customButton
            navigationItem.rightBarButtonItem?.tintColor = UIColor.label
        }
    }
    
    func setTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "OrderCell")
        tableView.rowHeight = 50
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    @objc func didTapSettings() {
        print("User tapped settings")
        let vc = SettingsViewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: false)
    }
    
    @objc private func refreshTable() {
        FirebaseService.shared.getUserOrders() { [weak self] in
            DispatchQueue.main.async() {
                self?.tableView.reloadData()
                self?.tableView.refreshControl?.endRefreshing()
            }
        }
    }
}
