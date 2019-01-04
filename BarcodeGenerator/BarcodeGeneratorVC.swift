//
//  BarcodeGeneratorVC.swift
//  BarcodeGenerator
//
//  Created by Kawalpreet Kaur on 1/4/19.
//  Copyright © 2019 Kawalpreet Kaur. All rights reserved.
//

import UIKit

class BarcodeGeneratorVC: BaseViewController {

    @IBOutlet weak var imgForBarcode: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        let alert = UIAlertController(title: "Barcode Generator", message: "Enter your name", preferredStyle: .alert)
        alert.addTextField { (textField) in
            
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            print("Text field: \(String(describing: textField?.text))")
            self.imgForBarcode.image = Barcode.fromString(name: textField?.text ?? "")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
class Barcode {
    class func fromString(name : String) -> UIImage? {
        let data = name.data(using: .ascii)
        if let filter = CIFilter(name: "CICode128BarcodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            if let outputCIImage = filter.outputImage {
                return UIImage(ciImage: outputCIImage)
            }
        }
        return nil
    }
}
