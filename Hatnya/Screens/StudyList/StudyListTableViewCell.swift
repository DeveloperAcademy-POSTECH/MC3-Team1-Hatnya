//
//  StudyListTableViewCell.swift
//  Hatnya
//
//  Created by 김원희 on 2022/07/20.
//

import UIKit

class StudyListTableViewCell: UITableViewCell {
   
   static let identifier = "StudyListTableViewCell"
   
   @IBOutlet weak var studyName: UILabel!
   @IBOutlet weak var studyDesc: UILabel!
   
   override func awakeFromNib() {
      super.awakeFromNib()
      // Initialization code
   }
   
   override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)
      
      // Configure the view for the selected state
   }
   
   override func layoutSubviews() {
      super.layoutSubviews()
      
      contentView.layer.cornerRadius = 13
      contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 7.5, left: 15, bottom: 7.5, right: 15))
   }
   
}
