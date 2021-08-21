//
//  ViewController.swift
//  Bullz And Bearz
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD
import CDAlertView
import AudioToolbox

class MainVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    

    // MARK: IBOutlets
    @IBOutlet weak var investmentBtn: UIButton!
    @IBOutlet weak var newsCollectionView: UICollectionView!
    
    
    // MARK: Class Variables
    var symbols: [String] = []
    var selectedExchange: String?
    
    var symbol = "AAPL"
    
    var symbolList: [String] = ["AAPL"]
    var analysisDict:[String: Any] = [:]
    
    var newsTitlesDict:[Int: String] = [:]
    var newsAuthorDict:[Int: String] = [:]
    var newsUrl:[Int: String] = [:]
    var newsImageDict:[Int: String] = [:]
    var newsPublishedDict:[Int: String] = [:]
    var newsImages:[Int: UIImage] = [:]
    
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getNews()
        
        newsCollectionView.delegate = self
        newsCollectionView.dataSource = self
        
        
        sentiment()
    }
    
    
    // MARK: sentimentBtn
    @IBAction func sentimentBtn(_ sender: Any) {
        
        sentiment()
        
        var stringToShow = "These sentiment analysis values are based on analysis of latest news headlines of the stocks you are following. A higher value denotes a positive sentiment in the market regarding the company. All values are subjective. \n \n"
        
        var analysisArr: [String?] = []
        
        for (key, _) in self.analysisDict {
            let val = self.analysisDict[key] as! Double
            let tempStr = "\(key): \(val)"
            analysisArr.append(tempStr)
        }
        
        for val in analysisArr {
            stringToShow = stringToShow + val! + "\n"
        }
        
        let alert = CDAlertView(title: "Sentiment Analysis", message: stringToShow, type: .notification)
        let doneAction = CDAlertViewAction(title: "Coooool! 🤑")
        alert.add(action: doneAction)
        alert.show()
        
    }
    
    
    // MARK: getSentimentAnalysis
    func sentiment(){
        
        let stringRepresentation = symbolList.joined(separator: ",")
        
        let url = "https://bearz-and-bullz.herokuapp.com/sentiment_analysis?Symbol=\(stringRepresentation)"
        AF.request(url, method: .post).responseData { (response) in
            guard let data = response.data else { return }
            let json = try? JSON(data: data)
            if let json = json {
                let dict = convertToDictionary(text: json.debugDescription)
                if let dict = dict {
                    self.analysisDict = dict
                }
            }
        }
    }
    
    
    // MARK: IBActions
    @IBAction func investmentButtonPressed(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Add new stock", message: nil, preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Add", style: .default) { (_) in
            if let txtField = alertController.textFields?.first, let text = txtField.text {
                self.symbol = text
                self.symbolList.append(text)
                self.sentiment()
                self.getNews()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        alertController.addTextField { (textField) in
            textField.placeholder = "Ticker Name"
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    // TODO: InvestmentButtons
    @IBAction func northAmericaBtnPressed(_ sender: Any) {
        let alert = UIAlertController(title: "North America", message: "Coming soon. Please explore the other geographical regions in the meantime.", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { (_) in
            
        }))

        self.present(alert, animated: true, completion: {
            
        })
    }
    
    @IBAction func europeBtnPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Europe", message: "Please select a stock exchange", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Amsterdam - The Netherlands", style: .default, handler: { (_) in
            self.showSpinner(onView: self.view)
            
            AF.request("https://bearz-and-bullz.herokuapp.com/amsterdam_symbols", method: .get).responseData { (response) in
                
                self.symbols.removeAll()
                
                guard let data = response.data else { return }
                let json = try! JSON(data: data)
                
                let dict = convertToDictionary(text: json.debugDescription)
                for (_, value) in dict! {
                    if let _value = value as? String {
                        self.symbols.append(_value)
                    }
                }
                
                self.selectedExchange = "amsterdam"
                self.removeSpinner()
                self.goToInvestmentMantra()
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Brussels - Belgium", style: .default, handler: { (_) in
            self.showSpinner(onView: self.view)
            
            AF.request("https://bearz-and-bullz.herokuapp.com/brussels_symbols", method: .get).responseData { (response) in
                
                self.symbols.removeAll()
                
                guard let data = response.data else { return }
                let json = try! JSON(data: data)
                
                let dict = convertToDictionary(text: json.debugDescription)
                for (_, value) in dict! {
                    if let _value = value as? String {
                        self.symbols.append(_value)
                    }
                }
                
                self.selectedExchange = "brussels"
                self.removeSpinner()
                self.goToInvestmentMantra()
            }
        }))

        alert.addAction(UIAlertAction(title: "Lisbon - Portugal", style: .default, handler: { (_) in
            self.showSpinner(onView: self.view)
            
            AF.request("https://bearz-and-bullz.herokuapp.com/lisbon_symbols", method: .get).responseData { (response) in
                
                self.symbols.removeAll()
                
                guard let data = response.data else { return }
                let json = try! JSON(data: data)
                
                let dict = convertToDictionary(text: json.debugDescription)
                for (_, value) in dict! {
                    if let _value = value as? String {
                        self.symbols.append(_value)
                    }
                }
                
                self.selectedExchange = "lisbon"
                self.removeSpinner()
                self.goToInvestmentMantra()
            }
        }))
        
        alert.addAction(UIAlertAction(title: "LSE - UK", style: .default, handler: { (_) in
            self.showSpinner(onView: self.view)
            
            AF.request("https://bearz-and-bullz.herokuapp.com/lse_symbols", method: .get).responseData { (response) in
                
                self.symbols.removeAll()
                
                guard let data = response.data else { return }
                let json = try! JSON(data: data)
                
                let dict = convertToDictionary(text: json.debugDescription)
                for (_, value) in dict! {
                    if let _value = value as? String {
                        self.symbols.append(_value)
                    }
                }
                
                self.selectedExchange = "lse"
                self.removeSpinner()
                self.goToInvestmentMantra()
            }
        }))
        
        alert.addAction(UIAlertAction(title: "XETRA - Germany", style: .default, handler: { (_) in
            self.showSpinner(onView: self.view)
            
            AF.request("https://bearz-and-bullz.herokuapp.com/xetra_symbols", method: .get).responseData { (response) in
                
                self.symbols.removeAll()
                
                guard let data = response.data else { return }
                let json = try! JSON(data: data)
                
                let dict = convertToDictionary(text: json.debugDescription)
                for (_, value) in dict! {
                    if let _value = value as? String {
                        self.symbols.append(_value)
                    }
                }
                
                self.selectedExchange = "xetra"
                self.removeSpinner()
                self.goToInvestmentMantra()
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { (_) in
            
        }))

        self.present(alert, animated: true, completion: {
            
        })
    }
    
    @IBAction func apacBtnPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Asia-Pacific", message: "Please select a stock exchange", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "NSE - India", style: .default, handler: { (_) in
            self.showSpinner(onView: self.view)
            
            AF.request("https://bearz-and-bullz.herokuapp.com/nse_symbols", method: .get).responseData { (response) in
                
                self.symbols.removeAll()
                
                guard let data = response.data else { return }
                let json = try! JSON(data: data)
                
                let dict = convertToDictionary(text: json.debugDescription)
                for (_, value) in dict! {
                    if let _value = value as? String {
                        self.symbols.append(_value)
                    }
                }
                
                self.selectedExchange = "nse"
                self.removeSpinner()
                self.goToInvestmentMantra()
            }
        }))
        
        alert.addAction(UIAlertAction(title: "MCX - India", style: .default, handler: { (_) in
            self.showSpinner(onView: self.view)
            AF.request("https://bearz-and-bullz.herokuapp.com/mcx_symbols", method: .get).responseData { (response) in
                
                self.symbols.removeAll()
                
                guard let data = response.data else { return }
                let json = try! JSON(data: data)
                
                let dict = convertToDictionary(text: json.debugDescription)
                for (_, value) in dict! {
                    if let _value = value as? String {
                        self.symbols.append(_value)
                    }
                }
                
                self.selectedExchange = "mcx"
                self.removeSpinner()
                self.goToInvestmentMantra()
            }
        }))

        alert.addAction(UIAlertAction(title: "Osaka - Japan", style: .default, handler: { (_) in
            self.showSpinner(onView: self.view)
            AF.request("https://bearz-and-bullz.herokuapp.com/osaka_symbols", method: .get).responseData { (response) in
                
                self.symbols.removeAll()
                
                guard let data = response.data else { return }
                let json = try! JSON(data: data)
                
                let dict = convertToDictionary(text: json.debugDescription)
                for (_, value) in dict! {
                    if let _value = value as? String {
                        self.symbols.append(_value)
                    }
                }
                
                self.selectedExchange = "osaka"
                self.removeSpinner()
                self.goToInvestmentMantra()
            }
        }))
        
        alert.addAction(UIAlertAction(title: "HKSE - Hong Kong", style: .default, handler: { (_) in
            self.showSpinner(onView: self.view)
            AF.request("https://bearz-and-bullz.herokuapp.com/hkse_symbols", method: .get).responseData { (response) in
                
                self.symbols.removeAll()
                
                guard let data = response.data else { return }
                let json = try! JSON(data: data)
                
                let dict = convertToDictionary(text: json.debugDescription)
                for (_, value) in dict! {
                    if let _value = value as? String {
                        self.symbols.append(_value)
                    }
                }
                
                self.selectedExchange = "hkse"
                self.removeSpinner()
                self.goToInvestmentMantra()
            }
        }))
        
        alert.addAction(UIAlertAction(title: "ASX - Australia", style: .default, handler: { (_) in
            self.showSpinner(onView: self.view)
            AF.request("https://bearz-and-bullz.herokuapp.com/asx_symbols", method: .get).responseData { (response) in
                
                self.symbols.removeAll()
                
                guard let data = response.data else { return }
                let json = try! JSON(data: data)
                
                let dict = convertToDictionary(text: json.debugDescription)
                for (_, value) in dict! {
                    if let _value = value as? String {
                        self.symbols.append(_value)
                    }
                }
                
                self.selectedExchange = "asx"
                self.removeSpinner()
                self.goToInvestmentMantra()
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { (_) in
            
        }))

        self.present(alert, animated: true, completion: {
            
        })
    }
    
    // TODO: goToInvestmentMantra
    func goToInvestmentMantra(){
        performSegue(withIdentifier: "goToInvestmentMantra", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goToInvestmentMantra") {
            let vc = segue.destination as! InvestmentMantra
            vc.symbols = self.symbols
            vc.exchange = self.selectedExchange
        }
    }
    
    // TODO: WordsOfWisdomButtons
    @IBAction func warrenBuffetBtnPressed(_ sender: Any) {
        let alert = CDAlertView(title: "Words of Wisdom", message: warren.randomElement(), type: .notification)
        let doneAction = CDAlertViewAction(title: "Coooool! 🤑")
        alert.add(action: doneAction)
        alert.show()
    }
    
    @IBAction func elonMuskBtnPressed(_ sender: Any) {
        let alert = CDAlertView(title: "Words of Wisdom", message: elon.randomElement(), type: .notification)
        let doneAction = CDAlertViewAction(title: "Coooool! 🤑")
        alert.add(action: doneAction)
        alert.show()
    }
    
    @IBAction func peterLynchBtnPressed(_ sender: Any) {
        let alert = CDAlertView(title: "Words of Wisdom", message: peter.randomElement()!, type: .notification)
        let doneAction = CDAlertViewAction(title: "Coooool! 🤑")
        alert.add(action: doneAction)
        alert.show()
    }
    
    @IBAction func steveJobsBtnPressed(_ sender: Any) {
        let alert = CDAlertView(title: "Words of Wisdom", message: steve.randomElement(), type: .notification)
        let doneAction = CDAlertViewAction(title: "Coooool! 🤑")
        alert.add(action: doneAction)
        alert.show()
    }
    
    @IBAction func billAckmanBtnPressed(_ sender: Any) {
        let alert = CDAlertView(title: "Words of Wisdom", message: bill.randomElement(), type: .notification)
        let doneAction = CDAlertViewAction(title: "Coooool! 🤑")
        alert.add(action: doneAction)
        alert.show()
    }
    
    @IBAction func markCubanBtnPressed(_ sender: Any) {
        let alert = CDAlertView(title: "Words of Wisdom", message: mark.randomElement(), type: .notification)
        let doneAction = CDAlertViewAction(title: "Coooool! 🤑")
        alert.add(action: doneAction)
        alert.show()
    }
    
    func getNews() {
            let now = Date()
            let oneMonthBefore = now.adding(months: -1)!
            
            self.newsCollectionView.isHidden = true
            
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd"
            let date = df.string(from: oneMonthBefore)
            
            let url : String = "http://newsapi.org/v2/everything?q=\(symbol)&from=\(date)&sortBy=publishedAt&apiKey=acb1beb15863493ebbf20fc7aae5c65b"
            
            AF.request(url).responseJSON { response in
                let value = response.value as? NSDictionary
                  if ((value) != nil) {
                      
                    var counter = 0
                    
                    let json = JSON(value!)
                    let status = json["status"]
                    if(status == "ok"){
                        for (key, subjson):(String, JSON) in json {
                          if(key=="articles"){
                            for(_, subsub):(String, JSON) in subjson {
                                self.newsTitlesDict[counter] = subsub["title"].stringValue
                                self.newsAuthorDict[counter] = subsub["source"]["name"].stringValue
                                self.newsUrl[counter] = subsub["url"].stringValue
                                self.newsImageDict[counter] = subsub["urlToImage"].stringValue
                                
                                var date = subsub["publishedAt"].stringValue
                                if let dotRange = date.range(of: "T") {
                                    date.removeSubrange(dotRange.lowerBound..<date.endIndex)
                                }
                                
                                self.newsPublishedDict[counter] = date
                                counter = counter + 1
                            }
                          }
                        }
                        
                        self.newsCollectionView.isHidden = false
                        self.newsCollectionView.reloadData()
                    } else {
                        let alert = CDAlertView(title: "Oops, something's not right!", message: "No news to show. We'll be back with more.", type: .error)
                        let doneAction = CDAlertViewAction(title: "Sure! 💪")
                        alert.add(action: doneAction)
                        alert.show()
                        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                    }
                  }
            }
        }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsTitlesDict.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = newsCollectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath) as? NewsCell
        cell?.newsTitleLbl.text = newsTitlesDict[indexPath.row]
        
        return cell!
    }
    
}

