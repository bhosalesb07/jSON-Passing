//
//  ViewController.swift
//  jSOn Passing
//
//  Created by Mac on 17/02/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{

    
    var nameArray: [String] = [String]()
    var parentArray:[String] = [String]()
    
    
    @IBOutlet weak var tableView: UITableView!
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        cell.lblparent?.text = nameArray[indexPath.row]
        cell.lblname?.text = parentArray[indexPath.row]
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let urlstr = "https://api.github.com/repositories/19438/commits"
        parsejson(urlString: urlstr)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
        
        if (nameArray.count>0)
        {
            tableView.reloadData()
        }
    
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    func parsejson(urlString:String)
    {
        enum jsonError:String,Error
        {
            case responseError = "response not found"
            case dataerror = "data not found"
            case conversionEroor = "conversion Failed"
            
        }
        guard let endPoint = URL(string: urlString)
            else
        {
            print("end point not found")
            return
            
        }
        URLSession.shared.dataTask(with: endPoint) { (data , response, error)  in
            do
            {
                guard let response1 = response
                    else
                {
                    throw jsonError.responseError
                }
                print(response1)
                guard let data = data
                    else
                {
                    throw jsonError.dataerror
                }
                let firstArray : [[String:Any]] = try
                    JSONSerialization.jsonObject(with: data, options: []) as! [[String:Any]]
                
                for item in firstArray
                {
                    let commitDic:[String:Any] = item["commit"] as! [String:Any]
                    let authorDic:[String:Any] = commitDic["author"] as! [String:Any]
                    let name:String = authorDic["name"] as! String
                    self.nameArray.append(name)
                  
                    let parentDic:[[String:Any]] = item["parents"] as! [[String:Any]]
                    for item2 in parentDic
                    {
                        let url:String = item2["url"] as! String
                        self.parentArray.append(url)
                        
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                }
                print("Name Array = \(self.nameArray)")
                print("Parent Array = \(self.parentArray)")
                
                
            }
            catch let error as jsonError
            {
                print(error.rawValue)
            }
            catch let error as NSError
            {
                print(error.localizedDescription)
            }
            }.resume()
  

    }
    
    }

