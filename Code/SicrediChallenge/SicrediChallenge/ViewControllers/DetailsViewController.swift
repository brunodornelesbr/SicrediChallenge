//
//  DetailsViewController.swift
//  SicrediChallenge
//
//  Created by Bruno Dorneles on 06/12/18.
//  Copyright © 2018 Bruno. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DetailsViewController: UIViewController {
    var detailsViewModel : DetailsViewModel!
    var bag = DisposeBag()
    
    //MARK: - Outlets and Components
    
    @IBOutlet weak var tableView: UITableView!
    var imageViewCell : ImageViewTableViewCell!
    var optionsTableViewCell : OptionsTableViewCell!
    var mainViewModel : MainViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetup()
        self.navigationItem.largeTitleDisplayMode = .never

        // Do any additional setup after loading the view.
    }
    
    func tableViewSetup(){
        imageViewCell = Bundle.main.loadNibNamed(ImageViewTableViewCell.xibName, owner: nil, options: nil)?.first as? ImageViewTableViewCell
        optionsTableViewCell = Bundle.main.loadNibNamed(OptionsTableViewCell.xibName, owner: nil, options: nil)?.first as? OptionsTableViewCell
        
        tableView.register(UINib(nibName: CommentTableViewCell.xibName, bundle: nil), forCellReuseIdentifier: CommentTableViewCell.reuseIdentifier())
        tableViewRxSetup()
    }
    
    func tableViewRxSetup(){
       tableView.rx.setDataSource(self).disposed(by: bag)
       tableView.rx.setDelegate(self).disposed(by: bag)
       
        detailsViewModel.titleObservable.subscribe(onNext : {[weak self] _ in
            self?.tableView.reloadData()
        }).disposed(by: bag)
        
        detailsViewModel.titleObservable.subscribe(onNext : {[weak self] event in
            self?.imageViewCell.setup(event: event)
            self?.optionsTableViewCell.setup(event:event)
            self?.title = event.title
        }).disposed(by: bag)
        
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

extension DetailsViewController : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return imageViewCell
        case 1:
            return optionsTableViewCell
        default :
            let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.reuseIdentifier()) as? CommentTableViewCell
            let person = detailsViewModel.requestPersonForRow(index: indexPath.row-2)
            cell?.setup(person: person)
            return cell!
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2 + detailsViewModel.peopleCount()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 315
        case 1:
            return 550
        default :
            return 75
        }
    }
    
    
}
