//
//  addemployee.swift
//  DummyAPI
//
//  Created by Yash Nayak on 21/01/19.
//  Copyright © 2019 Yash Nayak. All rights reserved.
//

import UIKit


class addemployee: UIViewController {
   
    
    @IBOutlet weak var empage: UITextField!
    @IBOutlet weak var empsalary: UITextField!
    @IBOutlet weak var empname: UITextField!
    struct Employee
    {
        var id = ""
        var name = ""
        var salary = ""
        var age = ""
        
        init(_ name:String, _ Salary:String, _ age:String, _ id:String)
        {
            self.name = name
            self.id = id
             self.salary = Salary
             self.age = age
        }
    }
    
    
    
    
    
    var path: String = "http://dummy.restapiexample.com/api/v1/create"
   
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addemp(_ sender: Any) {
        // prepare json data
        let json: [String: Any] = ["name": empname.text, "salary": empsalary.text, "age":empage.text]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        // create post request
        let url = URL(string: "http://dummy.restapiexample.com/api/v1/create")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // insert json data to the request
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
      

    myalert("Sucess", "Data for new employee added sucessfully")
        empname.text = ""
        empsalary.text = ""
        empage.text = ""
        
        
        
    }
    func myalert(_ mytitle:String, _ mymessage:String)
    {
        let alert = UIAlertController(title: mytitle, message: mymessage, preferredStyle: .actionSheet)
        let ok = UIAlertAction(title: "Done", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert,animated: true,completion: nil)
    }
    
    
    
   
}
