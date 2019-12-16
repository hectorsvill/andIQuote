
import Foundation
import WebKit


let webView = WKWebView()
let url = URL(string: "https://wisdomquotes.com/history-quotes/")!
let request = URLRequest(url: url)

webView.load(request)

var str = ""

webView.evaluateJavaScript("document.getElementsByTagName('blockquote')") { value, error in
    if let error = error {
        print("error: \(error)")
    }
    guard let value = value else { return }
    print(value)
//    print(str)
}













