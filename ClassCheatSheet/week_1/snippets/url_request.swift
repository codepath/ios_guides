let RottenTomatoesURLString = "http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=<#ApiKey#>"
let request = NSMutableURLRequest(URL: NSURL(string:RottenTomatoesURLString)!)
let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
    if let dictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
        NSLog("Dictionary: \(dictionary)")
    } else {
        
    }
}
task.resume()