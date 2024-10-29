//
//  MainViewController.swift
//  AppProductos
//
//  Created by User-UAM on 10/26/24.
//

import UIKit

enum Section {
    case main
}

class MainViewController: UIViewController {

    typealias DataSource = UITableViewDiffableDataSource<Section, ProductModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, ProductModel>
    
    private let mainController = MainController()
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Search products"
        searchController.searchResultsUpdater = self
        
        return searchController
    }()
    
    @IBOutlet weak var tableView: UITableView!
    
    private var products = [ProductModel]()
    
    private lazy var dataSource: DataSource = {
        let dataSource = DataSource(tableView: tableView) {
            tableView, IndexPath, ProductModel in let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: IndexPath) as? ProductTableViewCell
            
            cell?.nameProductLabel.text = ProductModel.title
            cell?.priceProductLabel.text = "$\(ProductModel.price)"
            
            
            Task {
                cell?.imageProductView.image = await self.mainController.loadImage(url: ProductModel.thumbnail)
            }
            
            return cell
        }
        
        return dataSource
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Produts"
        
        searchControllerConfiguration()
        configureButtons()
        registerCell()
        loadData()
        
    }
    
    private func loadData() {
        Task{
            products = await mainController.tomarProducto() ?? []
            applySnapshot()
        }
}
    
    func registerCell() {
        tableView.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductTableViewCell")
    }
    
    private func configureButtons() {
        //Configuración del botón
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addProduct))
    }
    
    @objc func addProduct(){
        //Nombrar el safeway de la misma manera, no olvidar.
        performSegue(withIdentifier: "goToAddProduct", sender: self)
    }
    
    private func searchControllerConfiguration() {
        navigationItem.searchController = searchController
    }
    
    func applySnapshot() {
        var snapshot = Snapshot()
        
        snapshot.appendSections([.main])
        snapshot.appendItems(products)
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard
            let query = searchController.searchBar.text else {
            return
        }
        
        Task {
            products = await mainController.tomarProducto(query: query) ?? []
            applySnapshot()
        }
    }
}
