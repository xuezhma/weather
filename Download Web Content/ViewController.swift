//
//  ViewController.swift
//  Download Web Content
//
//  Created by Xuezheng Ma on 7/31/15.
//  Copyright © 2015 Xuezheng Ma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var background: UIImageView!
    @IBOutlet var cityText: UITextField!
    @IBAction func getWeather(sender: AnyObject) {
        
        var findCityWeather = false
        let inUrl = NSURL(string: "http://www.weather-forecast.com/locations/" + cityText.text!.stringByReplacingOccurrencesOfString(" ", withString: "-") + "/forecasts/latest")
        if let url = inUrl {
            
            let task = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
                if let urlContent = data {
                    
                    let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                    
                    let webArray = webContent!.componentsSeparatedByString("3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
                    
                    if webArray.count > 1 {
                        let weatherArray = webArray[1].componentsSeparatedByString("</span>")
                        if weatherArray.count > 1 {
                            findCityWeather = true
                            
                            let weatherSummary = weatherArray[0].stringByReplacingOccurrencesOfString("&deg;", withString: "º")
                            
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                self.resultTable.text = weatherSummary
                                print(weatherSummary, appendNewline: true)
                        
                                
                                if weatherSummary.rangeOfString("rain") != nil{
                                    print("It's raining", appendNewline: true)
                                    self.background.image = UIImage(named: "rain_day.jpg")
                                }else{
                                    self.background.image = UIImage(named: "sunny_day.jpg")
                                }
                            })
                            
                        }
                    }
                }
                if findCityWeather == false {
                    self.resultTable.text = "No information found"
                }
            })
            
            task?.resume()
        }else{
            self.resultTable.text = "No information found"
        }
        
        
        
        
        
    }
    @IBOutlet var resultTable: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        /*
        let url = NSURL(string: "http://www.netflix.com/")!
        //myWebView.loadRequest(NSURLRequest(URL: url))
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
            
            if let urlContent = data {
                //print(urlContent)
                
                let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                
                //print(webContent)
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.myWebView.loadHTMLString(String(webContent!), baseURL: url)
                })
                
            }else{
                
            }
        }
        
        task?.resume()*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

