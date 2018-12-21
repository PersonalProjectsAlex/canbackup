//
//  PoliciesWebViewController.swift
//  CanLove
//
//  Created by Alex on 26/11/18.
//  Copyright © 2018 Techlatam. All rights reserved.
//

import UIKit
import WebKit

class PoliciesWebViewController: UIViewController, WKNavigationDelegate{
    // MARK: - Let-Var
    
    // MARK: - Outlets
    @IBOutlet weak var webView: WKWebView!
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // setting up general actions/delegates/Core
        setUpActions()
        
        // setting up UI elements to be used through the code
        setUpUI()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {}
    
    
    // MARK: - SetUps / Funcs
    func setUpUI(){}
    
    func setUpActions(){
        //Delegating webview
        webView.navigationDelegate = self
        
        //Setting up url
        guard let url = URL(string: K.policiesCanLoveSite) else {return}
        webView.load(URLRequest(url: url))
        
        //Set refresh button at Webview
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        toolbarItems = [refresh]
        navigationController?.isToolbarHidden = false
    }
    
    private func gettingData(){}
    
    //Webview
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {}
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {}
    
    
    @IBAction func backAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Objective C
    
}
