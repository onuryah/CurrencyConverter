//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Ceren Çapar on 5.10.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var btcLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func getButtonClicked(_ sender: Any) {
        
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=75976cc4d546584281d1d31fa7bd3dce")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!) { data, response, error in
            if error != nil {
                let alert = UIAlertController(title: "ERROR!", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }
            if data != nil{
                do{
                    let jasonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                    
                    DispatchQueue.main.async {
                        if let rates = jasonResponse["rates"] as? [String : Any]{
                           print(rates)
                            
                            if let usd = rates["USD"] as? Double{
                                self.usdLabel.text = "USD: \(usd)"
                            }
                            
                            if let ytl = rates["TRY"] as? Double{
                                self.tryLabel.text = "TRY: \(ytl)"
                            }
                            if let jpy = rates["JPY"] as? Double{
                                self.jpyLabel.text = "USD: \(jpy)"
                            }
                            if let btc = rates["BTC"] as? Double{
                                self.btcLabel.text = "BTC: \(btc)"
                            }
                        }
                    }
                }catch{
                    print("Error")
                }
            }
        }
        task.resume()
    }
    

}

