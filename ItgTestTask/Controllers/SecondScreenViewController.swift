//
//  SecondScreenViewController.swift
//  ItgTestTask
//
//  Created by Qasem Zreaq on 07/04/2021.
//

import Foundation
import UIKit

class SecondScreenViewController: UIViewController, AlertDisplayer {
    @IBOutlet var userName: UILabel!
    @IBOutlet var avatarImage: UIImageView!
    @IBOutlet var bio: UILabel!
    @IBOutlet var country: UILabel!
    @IBOutlet var loader: UIActivityIndicatorView!
    @IBOutlet var loadingView: UIView!
    @IBOutlet var coveerImage: UIImageView!
    var userId : String?
    var profileModel  = UserProfileViewModel()
    override func viewDidLoad() {
        self.title = NSLocalizedString("Profile_Page", comment: "")
        avatarImage.layer.masksToBounds = true
        avatarImage.layer.cornerRadius = avatarImage.bounds.width / 2
        coveerImage.layer.cornerRadius = 15
        fetchProfile () 
        super.viewDidLoad()
        loader.startAnimating()
        
    }
    
    private func fetchProfile() {
        
        print(userId!)
        guard let url = URL(string: "https://api.github.com/users/\(userId!)") else {
            fatalError("URL was incorrect")
        }
        
        let resource = Resource<Profile>(url: url)
        
        Webservice().getData(resource: resource) { [weak self] result in
            
            switch result {
                case .success(let user):
                    DispatchQueue.main.async {
                        self?.profileModel.user = user
                        self?.userName.text = self?.profileModel.name
                        self?.country.text = self?.profileModel.location
                        self?.bio.text = self?.profileModel.bio
                        self?.getImage(url: URL(string: (self?.profileModel.imageUrl)!)!)
                    }
                    print(user)
    
                case .failure(let error):
                    self?.onFetchFailed (with :error.localizedDescription)
            }
        }
        
    }
    
    private func getImage(url: URL){
           
           URLSession.shared.dataTask(with: url) { (data, response, error) in
                      // Handle Error
                      if let error = error {
                        self.onFetchFailed(with: error.localizedDescription)
                          return
                      }
                      
                      guard let data = data else {
                        self.onFetchFailed(with: "no profile image")
                          return
                      }
                      
                      DispatchQueue.main.async {
                          if let image = UIImage(data: data) {
                            self.avatarImage.image = image
                            self.loader.isHidden = true
                            self.loadingView.isHidden = true

                          }
                      }
                  }.resume()
              
       }
    
    func onFetchFailed (with message: String) {
        
        let title = "Error"
        let action = UIAlertAction(title: "OK", style: .default)
        displayAlert(with: title, message: message, actions: [action])
        
    }
}

