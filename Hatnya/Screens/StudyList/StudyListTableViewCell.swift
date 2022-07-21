//
//  StudyListTableViewCell.swift
//  Hatnya
//
//  Created by 김원희 on 2022/07/20.
//

import UIKit

class StudyListTableViewCell: UITableViewCell {
   
   static let identifier = "StudyListTableViewCell"
   
   @IBOutlet private weak var studyName: UILabel!
   @IBOutlet private weak var studyDesc: UILabel!
   
   override func awakeFromNib() {
      super.awakeFromNib()
   }
   
   override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)
      
      if selected {
         contentView.layer.backgroundColor = UIColor.systemGray4.cgColor
      } else {
         contentView.layer.backgroundColor = UIColor.secondarySystemBackground.cgColor
      }
   }
   
   override func layoutSubviews() {
      super.layoutSubviews()
      
      contentView.layer.shadowColor = UIColor.gray.cgColor
      contentView.layer.shadowOffset = CGSize(width: 1, height: 1)
      contentView.layer.shadowOpacity = 0.5
      contentView.layer.shadowRadius = 5
      contentView.layer.masksToBounds = false
      
      contentView.layer.cornerRadius = 13
      contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 7.5, left: 15, bottom: 7.5, right: 15))
   }
   
   func configure(with dataSource: StudyInfo) {
      studyName.text = dataSource.name
      studyDesc.text = dataSource.desc
   }
   
}

struct StudyInfo {
   var name: String
   var desc: String
}
