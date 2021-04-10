//
//  FirstScreenViewController.swift
//  ItgTestTask
//
//  Created by Qasem Zreaq on 07/04/2021.
//

import Foundation
import UIKit
import CoreData

class FirstScreenViewController : UIViewController, AlertDisplayer {
    @IBOutlet var tittle: UILabel!
    @IBOutlet var loader: UIActivityIndicatorView!
    var page = 0
    @IBOutlet var usersTable: UITableView!
    @IBOutlet var logo: UIImageView!
    private let webService = Webservice()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var count :Int?
    var users = [UserInfo]()
    let refreshControl = UIRefreshControl()
    var userListViewModel =  UsersListVieModel()
    var selectedUserName : String?

    
    override func viewDidLoad() {
        
        tittle.text = NSLocalizedString("Title_String", comment: "")
        self.title = NSLocalizedString("Home_Page", comment: "")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        self.usersTable.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
        logo.layer.cornerRadius = 25
        self.usersTable.dataSource = self
        self.usersTable.delegate = self
        self.usersTable.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: "USERCELL")
        self.usersTable.refreshControl = refreshControl
        checkData()
        loader.startAnimating()
        super.viewDidLoad()
        
    }
    
    /*this function when refresh a table view switch case because the api (since =)
    is not work as sequence in this cases after i test it on postman */
    
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
    
    /* this function to check if there's an uploaded data do core data from the previous calls
     it's work flow as follow :
     
     first check if the count of users in core data empy or not
     if not fetch these data and make the second api call start from it by set page the data count.
     if there's no data so call the api bring data from it
     otherwise bring these data to the model view then fetch it to the  table view
 
    */
  private  func checkData () {
    
        let request : NSFetchRequest<UserInfo> = UserInfo.fetchRequest()

        do {
            count = try context.fetch(request).count
            if count == 0 {
                populateUsers(page:page)
                
            } else {
                
                do {
                    try users =  context.fetch(request)
                    self.page = users.count //to staart after uploaded data
                    self.userListViewModel.usersListViewModel = users.map({ user in
                        let id = Int(user.id)
                        let login = user.login!
                        return UserViewModel.init(user: User(login: login, id: id))

                    })
                    self.userListViewModel.usersListViewModel.sort(by: {$0.id<$1.id})
                    self.userListViewModel.usersListViewModel.reverse()
                    self.usersTable.reloadData()
                    self.loader.isHidden = true
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
    /*
     
     this function for fetching data from api
     i just make api service call api fetch this data into core data and modelview.
     i implement the pagination in my own way and what i did :
     my table view and it's content is flip upside down
     when fethcing data into array i reverse this array to work well as i want to make pagination and
     refresh table view from bottom>
     after finish fetching data into table view i scrol to row 30 because my data comes 30 30.
     so new data comes below the last cell as user experince like instgram and so on.
     
     */
    
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
                self.userListViewModel.usersListViewModel = self.userListViewModel.usersListViewModel + users.map(UserViewModel.init)
                self.userListViewModel.usersListViewModel.sort(by: {$0.id<$1.id})
                self.userListViewModel.usersListViewModel.reverse()
                
                if page == 0 {
                    self.loader.isHidden = true
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
                DispatchQueue.main.async {
                    self.loader.isHidden = true
                    self.refreshControl.endRefreshing()
                    onFetchFailed(with: error.localizedDescription)
                    
                }

            }
        })
    }
    
        
}

//MARK:Table View Delegates & DataSource

extension FirstScreenViewController:  UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.userListViewModel.usersListViewModel.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let vm = self.userListViewModel.userViewModel(at: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "USERCELL", for: indexPath) as! UserCell
        cell.userName.text = vm.name
        cell.transform = CGAffineTransform(scaleX: 1.0, y: -1.0)
        cell.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))

        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.usersTable.deselectRow(at: indexPath, animated: false)
        self.selectedUserName = userListViewModel.userViewModel(at: indexPath.row).name
        performSegue(withIdentifier: "GOPROFILE", sender: self)
        
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

//MARK:connection handling & navigation

extension FirstScreenViewController{
    
    func onFetchFailed (with message: String) {
        
        let title = "Error"
        let action = UIAlertAction(title: "OK", style: .default)
        displayAlert(with: title, message: message, actions: [action])
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if (segue.identifier == "GOPROFILE") {
               let vc = segue.destination as! SecondScreenViewController
            print (self.selectedUserName!)
            vc.userId = self.selectedUserName!
              
           }
       }
    

}


