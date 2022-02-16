//
//  RESOViewController.swift
//  RESO Mobile
//
//  Created by s b on 16.02.2022.
//


import UIKit

class RESOViewController: UIViewController {
    
    var officeListJSON: [OfficeListModel] = []
    
    var tableView:UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableView()
    }

    func setupTableView() {
        tableView = UITableView(frame: view.bounds)
        view.addSubview(tableView)
        
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "officeCell")

        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension RESOViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return officeListJSON.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "officeCell")! as UITableViewCell
        cell.textLabel?.text = officeListJSON[indexPath.row].SSHORTNAME
        return cell
    }
}

extension RESOViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(officeListJSON[indexPath.row])
    }
}
