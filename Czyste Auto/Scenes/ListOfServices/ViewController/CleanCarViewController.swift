import UIKit



class CleanCarViewController: UIViewController {
    
    weak var delegate: (CleanCarViewControllerDelegate)?

    public let viewModel = CleanCarViewModel()
    
    var isSearching = false
    var filteredServices: [Service] = []
    let tableView = UITableView()

    private lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchResultsUpdater = self
        controller.obscuresBackgroundDuringPresentation = false
        controller.searchBar.placeholder = "Wyszukaj usługę"
        controller.definesPresentationContext = true
        controller.searchBar.setValue("Anuluj", forKey: "cancelButtonText")
        
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.selectedServices = viewModel.loadServices() ?? []
        if let tabBarController = tabBarController as? TabBarController {
            delegate = tabBarController
        }
        
        title = "Umyj Auto"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        
        view.addSubview(tableView)
        setupTableView()
  
    }

    
    func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CellInListOfServices.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 120
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.selectedServices = viewModel.loadServices() ?? []
    }
}

extension CleanCarViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            isSearching = false
            tableView.reloadData()
            return
        }
        
        isSearching = true
        filteredServices = viewModel.services.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        tableView.reloadData()
    }
}

extension CleanCarViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredServices.count : viewModel.services.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CellInListOfServices
        
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


