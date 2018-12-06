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
    @IBOutlet weak var tableView: UITableView!
    let search = UISearchController(searchResultsController: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetup()
        searchBarSetup()
        // Do any additional setup after loading the view.
    }
    
    func tableViewSetup(){
        tableView.register(UINib(nibName: MainEventTableViewCell.xibName, bundle: nil), forCellReuseIdentifier: MainEventTableViewCell.reuseIdentifier())
       
        self.tableView.rx.setDelegate(self)
        mainViewModel.eventObservable.bind(to: tableView.rx.items(cellIdentifier: MainEventTableViewCell.reuseIdentifier(), cellType: MainEventTableViewCell.self)){  row, element, cell in
           cell.setup(event: element)
            }.disposed(by: bag)
        
        
    }
    
    func searchBarSetup(){
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.definesPresentationContext = true
        search.searchBar.barStyle = .default
        search.searchBar.placeholder = "Search for events"
        search.dimsBackgroundDuringPresentation = false
        search.searchBar.tintColor = .blue
        self.navigationItem.searchController = search
        
        searchBarRxSetup()
    }
    
    func searchBarRxSetup(){
        search.searchBar.rx.text.asObservable().filter({($0 ?? "").count > 0 }).debounce(0.3, scheduler: MainScheduler.instance).subscribe(onNext: {[weak self] searchText in
            self?.mainViewModel.searchEvents(searchText: searchText!)
            }).disposed(by: bag)
        
        let cancelButtonClicked = search.searchBar.rx.cancelButtonClicked.asObservable()
        let searchTextEmpty = search.searchBar.rx.text.filter({$0 == "" || $0 == nil}).map { _ in () }
        
        Observable.merge(cancelButtonClicked, searchTextEmpty)
            .throttle(0.5, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.mainViewModel.requestEvents()})
            .disposed(by: bag)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}


extension MainViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
