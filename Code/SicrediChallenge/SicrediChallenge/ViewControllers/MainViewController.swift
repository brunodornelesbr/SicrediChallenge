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
        mainViewModel.requestEvents()
        // Do any additional setup after loading the view.
    }
    
    func tableViewSetup(){
        tableView.register(UINib(nibName: MainEventTableViewCell.xibName, bundle: nil), forCellReuseIdentifier: MainEventTableViewCell.reuseIdentifier())
       
        self.tableView.rx.setDelegate(self)
        mainViewModel.eventObservable.bind(to: tableView.rx.items(cellIdentifier: MainEventTableViewCell.reuseIdentifier(), cellType: MainEventTableViewCell.self)){  row, element, cell in
           cell.setup(event: element)
            }.disposed(by: bag)
        
        
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
