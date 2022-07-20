//
//  ViewController+Preview.swift
//  Hatnya
//
//  Created by 리아 on 2022/07/19.
//

import SwiftUI
import UIKit

extension UIViewController {
    
    private struct Preview: UIViewControllerRepresentable {

        let viewController: UIViewController
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }

    }
    
    /// UIViewController의 preview를 제공해주는 메서드
    ///
    /// 아래의 코드를 통해 UIViewController의 preview를 확인해볼 수 있다
    ///
    /// ```swift
    /// import SwiftUI
    ///
    /// struct SomeViewControllerPreview: PreviewProvider {
    ///     static var previews: some View {
    ///         SomeViewController().toPreview()
    ///     }
    /// }
    /// ```
    ///
    /// 스토리보드로 ViewController를 구현한 경우에는 다음과 같이 사용할 수 있다
    /// ```swift
    /// struct SomeViewControllerPreview: PreviewProvider {
    ///     static var previews: some View {
    ///         UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "SomeViewController")
    ///         .toPreview()
    ///     }
    /// }
    /// ```
    ///
    /// 다크 모드나 디바이스 변경 등의 동작을 지원한다
    /// ```swift
    /// struct SomeViewControllerPreview: PreviewProvider {
    ///     static var previews: some View {
    ///         SomeViewController()
    ///             .toPreview()
    ///             .previewDevice("iPhone 13 Pro")
    ///             .preferredColorScheme(.dark)
    ///     }
    /// }
    /// ```

    func toPreview() -> some View {
        Preview(viewController: self)
    }
    
}

extension UIView {

    private struct Preview: UIViewRepresentable {

        let view: UIView

        func makeUIView(context: Context) -> some UIView {
            return view
        }

        func updateUIView(_ uiView: UIViewType, context: Context) {
        }

    }

    /// UIView의 preview를 제공해주는 메서드
    ///
    /// 아래의 코드를 통해 UIView의 preview를 확인해볼 수 있다
    ///
    /// ```swift
    /// import SwiftUI
    ///
    /// struct SomeViewPreview: PreviewProvider {
    ///     static var previews: some View {
    ///         SomeView().toPreview()
    ///     }
    /// }
    /// ```
    ///
    /// UIView를 상속받는 CollectionViewCell 등에도 적용 가능하다

    func toPreview() -> some View {
        Preview(view: self)
    }

}
