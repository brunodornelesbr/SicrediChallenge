//
//  MainViewController.swift
//  SicrediChallenge
//
//  Created by Bruno Dorneles on 05/12/18.
//  Copyright © 2018 Bruno. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class MainViewController: UIViewController {
    
    var mainViewModel = MainViewModel()
    var bag = DisposeBag()
    
    //MARK: - Outlets and Components
    @IBOutlet  weak var tableView: UITableView!
    let search = UISearchController(searchResultsController: nil)
    
    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetup()
        searchBarSetup()
    }
    //MARK: - View setup
    private func tableViewSetup() {
        tableView.register(UINib(nibName: MainEventTableViewCell.xibName, bundle: nil), forCellReuseIdentifier: MainEventTableViewCell.reuseIdentifier())
        
        tableView.rx.setDelegate(self).disposed(by: bag)
        mainViewModel.eventObservable.bind(to: tableView.rx.items(cellIdentifier: MainEventTableViewCell.reuseIdentifier(), cellType: MainEventTableViewCell.self)){  row, element, cell in
            cell.setup(event: element)
            }.disposed(by: bag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                DispatchQueue.main.async {
                    self?.selectedEventWithRow(row: indexPath.row)
                }
            }).disposed(by: bag)
        
    }
    
    private func searchBarSetup() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.definesPresentationContext = true
        self.definesPresentationContext = true
        search.searchBar.barStyle = .black
        search.searchBar.placeholder = "Pesquise por eventos"
        search.dimsBackgroundDuringPresentation = false
        search.searchBar.tintColor = .white
        self.navigationItem.searchController = search
        
        searchBarRxSetup()
    }
    
    private func searchBarRxSetup() {
        search.searchBar.rx.text.asObservable().filter({($0 ?? "").count > 0 }).debounce(0.3, scheduler: MainScheduler.instance).subscribe(onNext: {[weak self] searchText in
            self?.searchFor(text: searchText ?? "")
        }).disposed(by: bag)
        
        let cancelButtonClicked = search.searchBar.rx.cancelButtonClicked.asObservable()
        let searchTextEmpty = search.searchBar.rx.text.filter({$0 == "" || $0 == nil}).map { _ in () }
        
        Observable.merge(cancelButtonClicked, searchTextEmpty)
            .throttle(0.5, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.mainViewModel.requestEvents()})
            .disposed(by: bag)
    }
    
    //MARK: - Actions
    public func selectedEventWithRow(row: Int){
        let event = mainViewModel.eventForRow(row: row) as Any
        performSegue(withIdentifier: "showDetails", sender: event )
    }
    
    public func searchFor(text: String){
        mainViewModel.searchEvents(searchText: text)
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showDetails":
            if let destination = segue.destination as? DetailsViewController, let event = sender as? Event {
                destination.detailsViewModel = DetailsViewModel(event: event)
            }
        default:
            print("destination not being used")
        }
    }
}

//MARK: - Table view implementation
extension MainViewController : UITableViewDelegate {
    internal func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
