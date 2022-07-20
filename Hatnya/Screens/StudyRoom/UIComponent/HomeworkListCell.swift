//
//  HomeworkListCell.swift
//  Hatnya
//
//  Created by 리아 on 2022/07/20.
//

import SwiftUI
import UIKit

class HomeworkListCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

struct HomeworkListCellPreview: PreviewProvider {
    
    static var previews: some View {
        HomeworkListCell().toPreview()
    }

}
