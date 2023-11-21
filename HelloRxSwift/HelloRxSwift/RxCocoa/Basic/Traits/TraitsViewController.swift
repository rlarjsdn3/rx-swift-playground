//
//  ControlEventViewController.swift
//  HelloRxSwift
//
//  Created by 김건우 on 11/21/23.
//

import UIKit
import RxSwift
import RxCocoa

class TraitsViewController: UIViewController {
    
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet weak var resetButton: UIButton!
    
    let disposeBag: DisposeBag = DisposeBag()
    let viewModel: ControlEventViewModel = ControlEventViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ⭐️ Trait 기본 이론:
        // UI 구현 및 업데이트에 특화된 옵저버블의 모음임.
        // Control Property, Control Event, Drvie와 Signal이 있으며, 데이터 생산자(옵저버블)의 역할을 수행하고 있음.
        // 방출하는 모든 이벤트는 메인 쓰레드에서 실행되는 걸 보장함.
        
        // ⭐️ Control Event 기본 이론:
        // 특정 UI 이벤트(touchUpInside 등)에 반응하고, 해당 이벤트가 발생할 때 옵저버블을 생성함.
        
        // ⭐️ Control Property 기본 이론:
        // UIKit의 속성에 반응하고, 해당 이벤트가 발생할 때 옵저버블을 생성함.
        // 다른 옵저버블이 방출한 이벤트를 전달받아 속성을 업데이트할 수 있는 옵저버의 역할도 겸하고 있음.
        
        // ⭐️ Driver 기본 이론:
        // Bind와 특징이 유사하나, 이벤트 시퀀스를 공유한다는 특징이 있음. (불필요한 리소스 낭비를 막을 수 있음)
        // (내부적으로 share(replay: 1, scope: .whileConnected)가 구현되어 있음)
        
        bindingViewModel()
        // RxSwift-MVVM 패턴 연습(Input-Output)
    }
    
    func bindingViewModel() {
        let input = ControlEventViewModel.Input(
            redValue: redSlider.rx.value.asObservable(),
            blueValue: blueSlider.rx.value.asObservable(),
            greenValue: greenSlider.rx.value.asObservable(),
            resetTapped: resetButton.rx.tap.asObservable())
        let output = viewModel.transform(input: input)
        
        output.redText
            .drive(redLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.blueText
            .drive(blueLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.greenText
            .drive(greenLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.color
            .drive(colorView.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        output.reset
            .drive(redSlider.rx.value, greenSlider.rx.value, blueSlider.rx.value)
            .disposed(by: disposeBag)
        
        output.reset
            .map { String(Int($0)) }
            .drive(redLabel.rx.text, greenLabel.rx.text, blueLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.reset
            .map { _ in UIColor.black }
            .drive(colorView.rx.backgroundColor)
            .disposed(by: disposeBag)
    }

}
