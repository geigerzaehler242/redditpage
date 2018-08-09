//
//  redditpageViewController.swift
//  redditpage
//
//  Created by fm on 2018-08-09.
//  Copyright © 2018 f. All rights reserved.
//

import UIKit

class redditpageViewController: UIViewController {

    private var theRedditPageArray = [ [String : Any] ]()   //the model
    
    private let theReddicCellIdentifier = "redditCell"
    @IBOutlet weak var theTableView: UITableView!
    
    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        theTableView.delegate = self
        theTableView.dataSource = self
        theTableView.refreshControl = refreshControl
        
        refreshControl.addTarget(self, action: #selector(refreshRedditData(_:)), for: .valueChanged)
        
        getRedditModel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc private func refreshRedditData(_ sender: Any) {
        
        getRedditModel()
    }
    
    func getRedditModel() {
        
        activitySpinner.startAnimating()
        
        let theApiManager = APIManager()
        
        theApiManager.getRedditPage() { [unowned self] (pageArray) in
            
            self.theRedditPageArray = pageArray
            self.theTableView.reloadData()
            
            self.refreshControl.endRefreshing()
            self.activitySpinner.stopAnimating()
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


// MARK: - extension
extension redditpageViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return theRedditPageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: theReddicCellIdentifier, for:indexPath)
        
        let thePosting = theRedditPageArray[indexPath.row]
        
        if let thePostData = thePosting["data"] as? [String:Any],
            let theTitle = thePostData["title"] as? String {
        
            cell.textLabel?.text = theTitle
        }
        
        return cell
    }
    
}
