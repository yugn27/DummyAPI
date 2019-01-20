//
//  detailsViewController.swift
//  DummyAPI
//
//  Created by Yash Nayak on 21/01/19.
//  Copyright © 2019 Yash Nayak. All rights reserved.
//

import UIKit

class detailsViewController: UIViewController {
    @IBOutlet weak var idlbl: UILabel!
    @IBOutlet weak var agelbl: UILabel!
    var temp1:String = ""
    var temp2:String = ""
    var temp3:String = ""
    var temp4:String = ""
    @IBOutlet weak var namelbl: UILabel!
    @IBOutlet weak var salarylbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(temp2)
        idlbl.text! = "\(temp1)"
        namelbl.text! = "\(temp2)"
        salarylbl.text! = "\(temp3)"
        agelbl.text! = "\(temp4)"
    }
    
    
    @IBAction func update(_ sender: UIBarButtonItem) {
        let json: [String: Any] = ["name": "sasuke", "salary": "1234" ,"age":"67"]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
     
        let url = URL(string: "http://dummy.restapiexample.com/api/v1/update/\(temp1)")
        var request = URLRequest(url: url!)
        request.httpMethod = "PUT"
        
       
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
        }
        task.resume()
    }
    
    @IBAction func deldete(_ sender: Any) {
        let url = URL(string: "http://dummy.restapiexample.com/api/v1/update/\(temp1)")
        var request = URLRequest(url: url!)
        request.httpMethod = "DELETE"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
        }
        
        task.resume()
    }

}
