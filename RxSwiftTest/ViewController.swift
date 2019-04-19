//
//  ViewController.swift
//  RxSwiftTest
//
//  Created by Maxim Spiridonov on 19/04/2019.
//  Copyright © 2019 Maxim Spiridonov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let disposeBag = DisposeBag()
    
    let searchController = UISearchController(searchResultsController: nil)
    var searchBar: UISearchBar { return searchController.searchBar }
    
    var repositoriesViewModel: ViewModel?
    let api = APIProvider()
    
    
    

    // Создаем Observable масивом элементов
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configureSearchController()
        
        
        repositoriesViewModel = ViewModel(APIProvider: api)
        if let viewModel = repositoriesViewModel {
            viewModel.data
                .drive(tableView.rx.items(cellIdentifier: "Cell")) {
                    _, repository, cell in
                    cell.textLabel?.text = repository.name
                    cell.detailTextLabel?.text = repository.url
                }
                .disposed(by: disposeBag)
            
            searchBar.rx.text
                .orEmpty
                .bind(to: viewModel.searchText)
                .disposed(by: disposeBag)
            
            searchBar.rx.cancelButtonClicked
                .map {""}
                .bind(to: viewModel.searchText)
                .disposed(by: disposeBag)
            
            viewModel.data.asDriver()
                .map {
                    "\($0.count) Repositories"
                }
                .drive(navigationItem.rx.title)
                .disposed(by: disposeBag)
            
        }
        
    }

    private func configureSearchController() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchBar.showsCancelButton = true
        searchBar.text = "taijased"
        searchBar.placeholder = "Enter user"
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
    }

}
