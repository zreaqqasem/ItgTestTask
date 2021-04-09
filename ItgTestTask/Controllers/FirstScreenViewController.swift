//
//  FirstScreenViewController.swift
//  ItgTestTask
//
//  Created by Qasem Zreaq on 07/04/2021.
//

import Foundation
import UIKit
import CoreData

class FirstScreenViewController : UIViewController {
    var page = 0
    @IBOutlet var usersTable: UITableView!
    @IBOutlet var logo: UIImageView!
    private let webService = Webservice()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var count :Int?
    var users = [UserInfo]()
    let refreshControl = UIRefreshControl()

    
    override func viewDidLoad() {
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        self.usersTable.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
        logo.layer.cornerRadius = 25
        self.usersTable.dataSource = self
        self.usersTable.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: "USERCELL")
        self.usersTable.refreshControl = refreshControl
        checkData()
        super.viewDidLoad()
        
    }
    
    @objc func refresh(_ sender: AnyObject) {
       
        switch(page){
        case 0:
            page += 46
        case 46:
            page = 91
        case 96:
            page = 125
        default:
            page += 31
        }
        populateUsers(page:page)
    }

    func checkData () {
        let request : NSFetchRequest<UserInfo> = UserInfo.fetchRequest()

        do {
            count = try context.fetch(request).count
            if count == 0 {
                populateUsers(page:page)
                
            } else {
                
                do {
                try users =  context.fetch(request)
                    self.users.sort(by: {$0.id<$1.id})
                    self.users.reverse()
                    self.usersTable.reloadData()
                    self.usersTable.setContentOffset(CGPoint(x: 0, y: CGFloat.greatestFiniteMagnitude), animated: false)

                }
                catch {
                    print(error.localizedDescription)
                }
            }
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    private func populateUsers(page:Int){
       
        guard let url = URL(string: "https://api.github.com/users?since=\(page)") else {
            
            fatalError("url was incorrect! ")
        }
        
        let resource = Resource<Users>(url: url)
        
        Webservice().getData(resource: resource, completion: { [self] result in
            
            switch result {
            case .success(let users):
                users.forEach { (user) in
                    let user1 = UserInfo(context:self.context)
                    user1.id = Int32(user.id)
                    user1.login = user.login
                    self.users.append(user1)
                    saveUsers()
                }
                
                self.users.sort(by: {$0.id<$1.id})
                self.users.reverse()
                
                if page == 0 {
                    self.usersTable.reloadData()
                    self.usersTable.setContentOffset(CGPoint(x: 0, y: CGFloat.greatestFiniteMagnitude), animated: false)
                    self.refreshControl.endRefreshing()

                }
                else {
                    self.usersTable.reloadData()
                    self.refreshControl.endRefreshing()
                    print(self.users.count)
                    let selectedIndex = IndexPath(row: 30, section: 0)
                    self.usersTable.scrollToRow(at: selectedIndex, at: .top, animated: false)

                }

            case .failure(let error):
                print (error.localizedDescription)
            
            }
        })
    }
    
        
}

//MARK:Table View Delegates & DataSource

extension FirstScreenViewController:  UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return users.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "USERCELL", for: indexPath) as! UserCell
        cell.userName.text = users[indexPath.row].login
        return cell
        
    }
    
}

//MARK:core data functions save and get

extension FirstScreenViewController {
    
    private func saveUsers (){
        
        do
        
         {
            try context.save()
        }
        catch{
            
            print(error.localizedDescription)
        }
    }
    
}

