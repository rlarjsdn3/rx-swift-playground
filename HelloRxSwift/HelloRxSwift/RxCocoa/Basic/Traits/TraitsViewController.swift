//
//  ControlEventViewController.swift
//  HelloRxSwift
//
//  Created by 김건우 on 11/21/23.
//

import UIKit
import RxSwift
import RxCocoa

class TraitsViewController: UIViewController, ViewControllerType {
    
    // MARK: - Views
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet weak var resetButton: UIButton!
    
    // MARK: - Properties
    let viewModel: TraitsViewModel = TraitsViewModel()
    let disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        binding()
    }
    
    /* ⭐️ Traits
     * - Observable의 기능을 제한・추가해 특정 목적에 사용이 용이하도록 래핑한 Observalble입니다.
     * - Driver, Signal, ControlProperty와 ControlEvent가 있습니다.
     */
    
    /* ⭐️ Driver
     * - Binder와 유사한 특징을 지니지만, 추가로 스트림을 공유(share)할 필요가 있을 때 유용한 Observer입니다.
     * - share(replay: 1, scope: .whileConnected) 연산자가 적용되어 있습니다.
     */
    
    /* ⭐️ Signal
     * - Driver와 유사한 특징을 지니만, 스트림을 공유할 때 버퍼를 유지하지 않는 Observer입니다.
     */
    
    /* ⭐️ Control Property
     * - 속성 항목을 방출하거나 속성의 변화를 관찰하는 역할을 수행하는 타입입니다.
     * - Observable과 Observer의 역할을 동시에 수행합니다.
     * - (UIView).rx로 접근할 수 있으며, Binder나 Driver로 UI 바인딩을 할 수 있습니다.
     */
    
    /* ⭐️ Control Event
     * - UI 이벤트가 발생하면 관련 값 항목을 방출하는 Observable입니다.
     * ex) 버튼의 tap, 컬렉션의 itemSelected 등
     */
    
    func binding() {
        let input = TraitsViewModel.Input(
            red: redSlider.rx.value.asObservable(),
            blue: blueSlider.rx.value.asObservable(),
            green: greenSlider.rx.value.asObservable(),
            didTapResetButton: resetButton.rx.tap.asObservable())
        let output = viewModel.transform(input)
        
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
        
        output.shouldResetColor
            .drive(redSlider.rx.value, greenSlider.rx.value, blueSlider.rx.value)
            .disposed(by: disposeBag)
        
        output.shouldResetColor
            .map { String(Int($0)) }
            .drive(redLabel.rx.text, greenLabel.rx.text, blueLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.shouldResetColor
            .map { _ in UIColor.black }
            .drive(colorView.rx.backgroundColor)
            .disposed(by: disposeBag)
    }

}
