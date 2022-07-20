//
//  HomeworkListTitleView.swift
//  Hatnya
//
//  Created by 리아 on 2022/07/20.
//

import SwiftUI
import UIKit

class HomeworkListTitleView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

struct HomeworkListTitlePreview: PreviewProvider {
    
    static var previews: some View {
        HomeworkListTitleView().toPreview()
    }

}
