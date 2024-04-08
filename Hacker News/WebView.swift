//
//  WebView.swift
//  Hacker News
//
//  Created by Saksham Shrey on 08/04/24.
//

import SwiftUI
import WebKit

struct WebView: View {
    let url: String
    
    var body: some View {
        WebViewWrapper(url: url)
            .edgesIgnoringSafeArea(.all)
    }
}

struct WebViewWrapper: UIViewRepresentable {
    let url: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        if let url = URL(string: url) {
            webView.load(URLRequest(url: url))
        }
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {}
}


#Preview {
    WebView(url: "https://www.google.com")
}
