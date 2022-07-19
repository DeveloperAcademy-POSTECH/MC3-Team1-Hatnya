//
//  JoinStudyViewController.swift
//  Hatnya
//
//  Created by kelly on 2022/07/18.
//

import UIKit

class JoinStudyViewController: UIViewController {
    
    @IBOutlet private var textField: UITextField!
    @IBOutlet private var searchResultView: UIView!
    @IBOutlet private var studyGroupName: UILabel!
    @IBOutlet private var studyGroupDescription: UILabel!
    @IBOutlet private var nextButton: UIButton!
    
    override func viewDidLoad() {
        searchResultView.layer.cornerRadius = 5
        super.viewDidLoad()
    }

}
