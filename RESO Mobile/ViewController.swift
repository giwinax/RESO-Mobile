//
//  ViewController.swift
//  RESO Mobile
//
//  Created by s b on 16.02.2022.
//

import UIKit

class ViewController: UIViewController {
    var officeListJSON: [OfficeListModel] = []
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        let getOfficeListButton = UIButton()
        getOfficeListButton.setTitle("Получить список офисов", for: .normal)
        getOfficeListButton.titleLabel?.lineBreakMode = .byWordWrapping
        getOfficeListButton.setTitleColor(.black, for: .normal)
        getOfficeListButton.titleLabel?.textAlignment = .center
        getOfficeListButton.frame = CGRect(x: 15, y: -50, width: 600, height: 300)
        getOfficeListButton.backgroundColor = .clear
        getOfficeListButton.layer.cornerRadius = 20
        getOfficeListButton.layer.borderWidth = 2
        getOfficeListButton.layer.backgroundColor = UIColor.lightGray.cgColor
        getOfficeListButton.layer.borderColor = UIColor.lightGray.cgColor
        getOfficeListButton.addTarget(self, action: #selector(getOfficeListButtonPressed), for: .touchUpInside)
        getOfficeListButton.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = getOfficeListButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let verticalConstraint = getOfficeListButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        let widthConstraint = getOfficeListButton.widthAnchor.constraint(equalToConstant: 150)
        let heightConstraint = getOfficeListButton.heightAnchor.constraint(equalToConstant: 100)
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        self.view.addSubview(getOfficeListButton)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func getOfficeListButtonPressed() {
        getOfficeList()
        let RESOViewController = RESOViewController(nibName: "RESOViewController", bundle: nil)
        RESOViewController.modalPresentationStyle = .fullScreen
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        guard let window = view.window else { return }
        window.layer.add(transition, forKey: kCATransition)
        present(RESOViewController, animated: false, completion: nil)
        RESOViewController.officeListJSON = self.officeListJSON
        navigationController?.pushViewController(RESOViewController, animated: true)
    }
    // TODO: refactor function to complition
    func getOfficeList() {
        if let request = URL(string: "https://mobile.reso.ru/free/v2/agencies/77") {
            let (data, _, error) = URLSession.shared.synchronousDataTask(with: request)
                if let data = data {
                    let jsonDecoder = JSONDecoder()
                    do {
                        let decoded = try jsonDecoder.decode([OfficeListModel].self, from: data)
                        self.officeListJSON = decoded
                        //print(self.officeListJSON.count)
                    } catch {
                        print(error)
                    }
                }
        }
        
    }
    // TODO: error Handling
    func errorHandling() {
        let alert = UIAlertController(title: "My Alert", message: "This is an alert.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension URLSession {
    func synchronousDataTask(with url: URL) -> (Data?, URLResponse?, Error?) {
        var data: Data?
        var response: URLResponse?
        var error: Error?

        let semaphore = DispatchSemaphore(value: 0)

        let dataTask = self.dataTask(with: url) {
            data = $0
            response = $1
            error = $2

            semaphore.signal()
        }
        dataTask.resume()

        _ = semaphore.wait(timeout: .distantFuture)

        return (data, response, error)
    }
}
