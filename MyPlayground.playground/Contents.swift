
import Foundation
import WebKit



let myStrKey = "https://wisdomquotes.com/history-quotes/"
let webView = WKWebView()
let url = URL(string: "https://wisdomquotes.com/history-quotes/")!

if let historystr = UserDefaults.standard.string(forKey: myStrKey) {
    
} else {
    
    let data = try! Data(contentsOf: url)
    let str = String(data: data, encoding: .utf8)!
    UserDefaults.standard.set(str, forKey: myStrKey)
}



//let request = URLRequest(url: url)
//
//webView.load(request)
//var str = ""
//webView.evaluateJavaScript("document.getElementsByTagName('blockquote')[0]") { value, error in
//    if let error = error {
//        print("error: \(error)")
//    }
//    guard let value = value else { return }
//    print("value: \(value)\n\(str)")
////    print(str)
//}
//











