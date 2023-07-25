import UIKit

class CleanCarViewController: UIViewController {
    
    weak var delegate: (CleanCarViewControllerDelegate)?

    let services = [
        Service(name:"Mycie silnika", image: "engine", price: 149),
        Service(name:"Mycie standardowe", image: "standard_wash", price: 99),
        Service(name:"Mycie podlogi", image: "car_floor", price: 79),
        Service(name:"Mycie felg", image: "wheel", price: 49),
        Service(name:"Woskowanie", image: "wosk", price: 220),
        Service(name:"Powłoka ceramiczna", image: "ceramic", price: 750),
        Service(name:"Odkurzanie wnętrza", image: "vacuum", price: 49),
        Service(name:"Mycie sufitki", image: "ceiling", price: 137)
    ]
    
    var selectedServices: Set<Service> = [] {
        didSet {
            saveServices(selectedServices)
            print("salectedServices saved: \(selectedServices)")
        }
    }
    
    func saveServices(_ services: Set<Service>) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(Array(services)) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "SavedServices")
        }
    }
    
    func loadServices() -> Set<Service>? {
        let defaults = UserDefaults.standard
        if let savedServices = defaults.object(forKey: "SavedServices") as? Data {
            let decoder = JSONDecoder()
            if let loadedServices = try? decoder.decode(Array<Service>.self, from: savedServices) {
                return Set(loadedServices)
            }
        }
        return nil
    }
    
    
    var searchServices = [String]()
    var isSearching = false
    var filteredServices: [Service] = []
    let tableView = UITableView()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Wyszukaj usługę"
        searchBar.showsScopeBar = true
        return searchBar
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        selectedServices = loadServices() ?? []
        if let tabBarController = tabBarController as? TabBarController {
            delegate = tabBarController
        }

        view.backgroundColor = .systemBackground
        title = "Umyj Auto"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Bez tego nie działa reakcja na cancel
        searchBar.delegate = self
        
        view.addSubview(searchBar)
        view.addSubview(tableView)
        scrollView.isUserInteractionEnabled = false
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 120


    }
    

    override func viewDidLayoutSubviews() {
        print("viewDidLayoutSubviews")
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        let size = scrollView.width
        searchBar.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: size, height: 50)
        tableView.frame = CGRect(x: 0, y: searchBar.bottom, width: size, height: view.height-searchBar.height - view.safeAreaInsets.top)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        updateCancelButtonTitleAndColor()
        selectedServices = loadServices() ?? []
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showCancelButton))
        searchBar.addGestureRecognizer(tapGesture)
    }
    
    
}

extension CleanCarViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
        updateCancelButtonTitleAndColor()
        isSearching = false
        tableView.reloadData()

    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        updateCancelButtonTitleAndColor()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        updateCancelButtonTitleAndColor()
        tableView.reloadData()
        //isSearching = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearching = false
            tableView.reloadData()
        } else {
            isSearching = true
            filteredServices = services.filter { $0.name.lowercased().contains(searchText.lowercased()) }
            
            //otherwise
//            services.filter { serv in
//                return serv.name.lowercased().contains(searchText.lowercased())
//            }

            tableView.reloadData()
        }
    }
    

    @objc private func showCancelButton() {
        searchBar.becomeFirstResponder()
    }
    
    private func updateCancelButtonTitleAndColor() {
        if let cancelButton = searchBar.value(forKey: "cancelButton") as? UIButton {
            cancelButton.setTitle("Anuluj", for: .normal)
            cancelButton.tintColor = .label
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("\(String(describing: searchBar.text))")
        searchBar.resignFirstResponder()
    }
}

extension CleanCarViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredServices.count : services.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        
        let service = isSearching ? filteredServices[indexPath.row] : services[indexPath.row]
        
        cell.serviceImage.image = UIImage(named: service.image)
        cell.serviceName.text = service.name
        cell.servicePrice.text = "\(service.price) PLN"
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = isSearching ? filteredServices[indexPath.row] : services[indexPath.row]
        print("model: \(model)")
 
        openServiceDescribtion(model)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func openServiceDescribtion(_ model: Service) {
        let vc = ServicesViewController(serviceName: model.name)
        //vc.title = model.name
        print("openServiceDescribtion")
        vc.modalPresentationStyle = .formSheet
        self.present(vc, animated: true)
        
    }
}




class CustomCell: UITableViewCell {
    let serviceImage = UIImageView()
    let serviceName = UILabel()
    let servicePrice = UILabel()
    
    let cartButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "cart"), for: .normal)
        return button
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        print("CustomCell initialised")
        addSubview(serviceImage)
        addSubview(serviceName)
        addSubview(servicePrice)
        addSubview(cartButton)
        accessoryView = cartButton
        
        serviceImage.frame = CGRect(x: 10, y: serviceImage.frame.height/2, width: 100, height: 100)
        serviceImage.layer.cornerRadius = serviceImage.frame.width/2
        serviceImage.layer.masksToBounds = true
        serviceName.frame = CGRect(x: serviceImage.width+20, y: 10, width: 150, height: 30)
        servicePrice.frame = CGRect(x: serviceImage.width+20, y: serviceName.height+20, width: 80, height: 30)
        cartButton.frame = CGRect(x: 200, y: 50, width: 50, height: 50)
        cartButton.addTarget(self, action: #selector(didTapShoppingBasket), for: .touchUpInside)
    }
    
    @objc private func didTapShoppingBasket() {
        guard let tableView = superview as? UITableView,
              let indexPath = tableView.indexPath(for: self),
              let viewController = tableView.delegate as? CleanCarViewController else {
            return
        }
        
        // Dzieki temu podczas korzystania z searchBar nie jest gubiony indexPath
        let selectedService = viewController.isSearching ? viewController.filteredServices[indexPath.row] : viewController.services[indexPath.row]
        let service = viewController.services.first { $0.name == selectedService.name}
        
        guard let serviceToInsert = service else {return}
        
        let result = viewController.selectedServices.insert(serviceToInsert)
        
        if result.inserted == false {
            let alert = UIAlertController(title: "Uuupss", message: "Nie możesz dwukrotnie dodać tego do koszyka", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Rozumiem", style: .default, handler: nil))
            viewController.present(alert, animated: true)
        } else {
            viewController.delegate?.didChangeServices(viewController.selectedServices.count)
        }
        //viewController.selectedServices.insert(service)
        
        print("Selected services: \(viewController.selectedServices)")
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol CleanCarViewControllerDelegate: AnyObject {
    func didChangeServices(_ count: Int)
}


