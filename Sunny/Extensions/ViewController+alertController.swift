//
//  ViewController+alertController.swift
//  Sunny
//
//  Created by Roman Belov on 11.05.2022.
//  Copyright © 2022 Roman Belov. All rights reserved.
//

import UIKit

extension ViewController {
    
    //Creating alert with two buttons
    func presentSearchAlertController(withTitle title: String?, message: String?,
                                      style: UIAlertController.Style,
                                      completionHandler: @ escaping (String)->()) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: style)
        ac.addTextField { tf in
            let cities = ["San Francisco", "Moscow", "New York", "Stambul", "Viena"]
            tf.placeholder = cities.randomElement()
        }
        let search = UIAlertAction(title: "Search", style: .default) { action in
            let textField = ac.textFields?.first
            guard let cityName = textField?.text else { return }
            if cityName != "" {
                let city = cityName.split(separator: " ").joined(separator: "%20")
                completionHandler(city)
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        ac.addAction(search)
        ac.addAction(cancel)
        present(ac, animated: true, completion: nil)
    }
    
}
