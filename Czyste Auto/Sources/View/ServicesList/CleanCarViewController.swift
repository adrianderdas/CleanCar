import UIKit



class CleanCarViewController: UIViewController {
    
    weak var delegate: (CleanCarViewControllerDelegate)?

    public let viewModel = CleanCarViewModel()
    
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

        viewModel.selectedServices = viewModel.loadServices() ?? []
        if let tabBarController = tabBarController as? TabBarController {
            delegate = tabBarController
        }

        view.backgroundColor = .systemBackground
        title = "Umyj Auto"
        navigationController?.navigationBar.prefersLargeTitles = true
        
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
        viewModel.selectedServices = viewModel.loadServices() ?? []
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
        tableView.reloadData()

    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearching = false
            tableView.reloadData()
        } else {
            isSearching = true
            filteredServices = viewModel.services.filter { $0.name.lowercased().contains(searchText.lowercased()) }
            
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
        return isSearching ? filteredServices.count : viewModel.services.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        
        let service = isSearching ? filteredServices[indexPath.row] : viewModel.services[indexPath.row]
        
        cell.serviceImage.image = UIImage(named: service.image)
        cell.serviceName.text = service.name
        cell.servicePrice.text = "\(service.price) PLN"
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = isSearching ? filteredServices[indexPath.row] : viewModel.services[indexPath.row]
        print("model: \(model)")
 
        openServiceDescribtion(model)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func openServiceDescribtion(_ model: Service) {
        let vc = ServicesViewController(serviceName: model.name)
        //vc.title = model.name
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.largestUndimmedDetentIdentifier = .medium
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        }
        present(vc, animated: true, completion: nil)
    }
}

protocol CleanCarViewControllerDelegate: AnyObject {
    func didChangeServices(_ count: Int)
}


