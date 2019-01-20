//
//  ViewController.swift
//  DummyAPI
//
//  Created by Yash Nayak on 21/01/19.
//  Copyright © 2019 Yash Nayak. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var table: UITableView!
    
    var list:[MyStruct] = [MyStruct]()
    
    struct MyStruct
    {
        var id = ""
        var name = ""
        var salary = ""
        var age = ""
        
        init(_ id:String, _ name:String, _ salary:String, _ age:String)
        {
            self.name = name
            self.id = id
            self.salary = salary
            self.age = age
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.dataSource = self
        table.delegate = self
        
        get_data("http://dummy.restapiexample.com/api/v1/employees")
    }
    
    
    func get_data(_ link:String)
    {
        let url:URL = URL(string: link)!
        let session = URLSession.shared
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request, completionHandler: {
            (data, response, error) in
            self.extract_data(data)
        })
        task.resume()
    }
    
    func extract_data(_ data:Data?)
    {
        let json:Any?
        if(data == nil)
        {
            return
        }
        
        do{
            json = try JSONSerialization.jsonObject(with: data!, options: [])
        }
        catch
        {
            return
        }
        
        guard let data_array = json as? NSArray else
        {
            return
        }
        
        for i in 0 ..< data_array.count
        {
            if let data_object = data_array[i] as? NSDictionary
            {
                if let data_code = data_object["id"] as? String,
                    let data_country = data_object["employee_name"] as? String,
                    let emp_salary = data_object["employee_salary"] as? String,
                    let emp_age = data_object["employee_age"] as? String
                {
                    list.append(MyStruct(data_code, data_country, emp_salary, emp_age))
                }
            }
        }
        refresh_now()
    }
    
    func refresh_now()
    {
        DispatchQueue.main.async(
            execute:
            {
                self.table.reloadData()
                
        })
    }
    
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return list.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        
        cell.textLabel?.text = list[indexPath.row].name
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "detailsViewController") as!
        detailsViewController
        self.navigationController?.pushViewController(vc, animated: true)
        vc.temp1 = list[indexPath.row].id
        vc.temp2 = list[indexPath.row].name
        vc.temp3 = list[indexPath.row].salary
        vc.temp4 = list[indexPath.row].age
        
        
    }
    @IBAction func addemployee(_ sender: UIButton) {
    
    }

}

