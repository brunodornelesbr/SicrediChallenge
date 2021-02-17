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
import RxOptional

class DetailsViewController: UIViewController {

    var detailsViewModel: DetailsViewModel!
    var bag = DisposeBag()
    
    //MARK: - Outlets and Components
    @IBOutlet weak var tableView: UITableView!
    var imageViewCell: ImageViewTableViewCell!
    var optionsTableViewCell: OptionsTableViewCell!
    var mainViewModel: MainViewModel!

    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetup()
        buttonsRxSetup()
        userFeedbackRxSetup()
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    //MARK: - View setup
   private func tableViewSetup() {
        imageViewCell = Bundle.main.loadNibNamed(ImageViewTableViewCell.xibName, owner: nil, options: nil)?.first as? ImageViewTableViewCell
        optionsTableViewCell = Bundle.main.loadNibNamed(OptionsTableViewCell.xibName, owner: nil, options: nil)?.first as? OptionsTableViewCell
        
        tableView.register(UINib(nibName: CommentTableViewCell.xibName, bundle: nil), forCellReuseIdentifier: CommentTableViewCell.reuseIdentifier())
        tableViewRxSetup()
    }
    
    private func tableViewRxSetup() {
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
    
    private func buttonsRxSetup() {
        optionsTableViewCell.addressButton.rx.tap.bind{[weak self] _ in
            self?.requestInfoForUser()
            
            }.disposed(by: bag)
        
        optionsTableViewCell.commentButton.rx.tap.bind{[weak self] _ in
            
            let textToShare = self?.detailsViewModel.textToShare()
            guard let text = textToShare else {return}
            
            let activityViewController = UIActivityViewController(activityItems: text, applicationActivities: nil)
            if let popOver = activityViewController.popoverPresentationController {
                popOver.sourceView = self?.optionsTableViewCell
               
            }

            self?.present(activityViewController, animated: true, completion: nil)
            
            }.disposed(by: bag)
    }
    
    private func userFeedbackRxSetup() {
        detailsViewModel.checkinObservable.filter({return $0}).subscribe({[weak self] _ in
            let alert = UIAlertController(title: "CHECKIN", message: "Checkin ok!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self?.present(alert, animated: true, completion: nil)
        }).disposed(by: bag)
        
        detailsViewModel.errorObservable.filterNil().subscribe({[weak self] _ in
            let alert = UIAlertController(title: "Erro", message: "Um erro inesperado ocorreu", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self?.present(alert, animated: true, completion: nil)
        }).disposed(by: bag)
        
    }

     //MARK: - Actions
    private func requestInfoForUser(){
        let alert = UIAlertController(title: "CHECK-IN", message: "Precisamos do seu nome e email para fazer checkin", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Nome"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Email"
        }
        alert.addAction(UIAlertAction(title: "Checkin", style: .default, handler: { [weak self] _ in
            let nameField = alert.textFields![0]
            let emailField = alert.textFields![1]
            
            self?.detailsViewModel.checkin(email: emailField.text, name : nameField.text)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}

//MARK: - Table view implementation
//This was necessary due to how  I wanted the tableview to have fixed cells
extension DetailsViewController : UITableViewDataSource,UITableViewDelegate{

    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2 + detailsViewModel.peopleCount()
    }
    
   private func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
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
