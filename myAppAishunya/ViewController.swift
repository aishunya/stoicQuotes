//
//  ViewController.swift
//  Stoic Quotes
//
//  Created by Aisha Nurgaliyeva on 24.05.2023.
//

import UIKit

class ViewController: UIViewController, QuoteManagerDelegate {
    
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    var quoteManager = QuoteManager()
    
    var activityIndicator = UIActivityIndicatorView(style: .large)
        
    override func viewDidLoad() {
        super.viewDidLoad()
        button.layer.cornerRadius = 10.0
        quoteManager.delegate = self
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        quoteLabel.text = ""
        authorLabel.text = ""
        sender.alpha = 0.7
        sender.isUserInteractionEnabled = false
        showLoadingProgress()
        quoteManager.getQuote()
    }

    func didUpdateQuote(author: String, quote: String) {
        DispatchQueue.main.async {
            self.quoteLabel.text = quote
            self.authorLabel.text = author
            self.button.alpha = 1.0
            self.button.isUserInteractionEnabled = true
            self.button.setTitle("one more", for: .normal)
            self.activityIndicator.stopAnimating()
        }
    }
    
    func showLoadingProgress() {
        activityIndicator.color = UIColor.systemPink
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }
    
}

