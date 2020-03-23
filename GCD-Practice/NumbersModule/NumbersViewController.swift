//
//  NumbersViewController.swift
//  GCD-Practice
//
//  Created by Никита Гундорин on 23.03.2020.
//  Copyright © 2020 Никита Гундорин. All rights reserved.
//

import UIKit

class NumbersViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func calculate(_ sender: Any) {
        guard let number = Int(textField.text!) else {
            return
        }
        DispatchQueue.global(qos: .userInitiated).async {
            self.printPrimeNumbers(endNumber: number)
        }
    }
    
    func printPrimeNumbers(endNumber: Int) {
        for i in 1...endNumber {
            if isPrime(number: i) {
                print(i)
            }
        }
    }
    
    func isPrime(number: Int) -> Bool {
        if (number <= 1) {
            return false
        }

        if (number <= 3) {
            return true
        }
        
        var i = 2
        while (i <= number / 2) {
            if number % i == 0 {
               return false
            }
            i += 1
        }
        return true
    }
}
