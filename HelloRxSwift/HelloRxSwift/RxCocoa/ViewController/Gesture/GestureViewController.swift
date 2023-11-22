//
//  GestureViewController.swift
//  HelloRxSwift
//
//  Created by 김건우 on 11/21/23.
//

import UIKit
import RxSwift
import RxCocoa

class GestureViewController: UIViewController {
    
    @IBOutlet weak var targetView: UIView!
    @IBOutlet var panGesture: UIPanGestureRecognizer!
    
    let disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        targetView.center = view.center
        
        panGesture.rx.event
            .subscribe { [unowned self] gesture in
                guard let target = gesture.view else { return }
                let translation = gesture.translation(in: self.view)
                target.center.x = translation.x
                target.center.y = translation.y
                
                gesture.setTranslation(.zero, in: self.view)
            }
            .disposed(by: disposeBag)
    }
    

}
