//
//  DisplayQRCode.swift
//  CS656-iOS
//
//  Created by Jay Ravaliya on 4/8/16.
//  Copyright © 2016 JRav. All rights reserved.
//

import Foundation
import UIKit
import SwiftQRCode

class DisplayQRCodeViewController : UIViewController {
    
    var imageView : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.imageView = UIImageView()
        self.imageView.frame = CGRect(x: Standard.screenWidth * 0.2, y: Standard.screenHeight * 0.5 - Standard.screenWidth * 0.3, width: Standard.screenWidth * 0.6, height: Standard.screenWidth * 0.6)
        print(LocalAPI.getUserToken())
        self.imageView.image = QRCode.generateImage(LocalAPI.getUserToken(), avatarImage: UIImage(named: "njit-image"), avatarScale: 0.3)
        self.view.addSubview(self.imageView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
