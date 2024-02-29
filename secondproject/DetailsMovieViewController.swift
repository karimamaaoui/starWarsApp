//
//  DetailsMovieViewController.swift
//  secondproject
//
//  Created by karimamaaoui on 2/29/24.
//  Copyright © 2024 karimamaaoui. All rights reserved.
//

import UIKit

class DetailsMovieViewController: UIViewController {

    @IBOutlet weak var titleLabelDetails: UILabel!
    
    @IBOutlet weak var releaseDateDetails: UILabel!
    
    @IBOutlet weak var DirectorLabelDetails: UILabel!
    
    @IBOutlet weak var producerLabelDetails: UILabel!
    
    
    @IBOutlet weak var openingCrawLabelDetails: UITextView!
    
    var labtitle :String = ""
    var labrelease :String = ""
    var labdirector :String = ""
    var labproducer :String = ""
    var labopening :String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabelDetails.text = labtitle
        releaseDateDetails.text = labrelease
        DirectorLabelDetails.text = labdirector
        producerLabelDetails.text = labproducer
        openingCrawLabelDetails.text = labopening
        
    }
    

    
}
