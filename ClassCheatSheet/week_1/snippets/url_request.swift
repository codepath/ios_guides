let RottenTomatoesURLString = "http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=<#ApiKey#>"
let request = NSMutableURLRequest(URL: NSURL(string:RottenTomatoesURLString)!)
NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{ (response, data, error) in
    if let dictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as! NSDictionary? {
        NSLog("Dictionary: \(dictionary)")
    } else {

    }
})