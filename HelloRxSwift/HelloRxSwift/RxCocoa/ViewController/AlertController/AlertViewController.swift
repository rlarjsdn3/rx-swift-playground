//
//  AlertViewController.swift
//  HelloRxSwift
//
//  Created by 김건우 on 11/21/23.
//

import UIKit
import RxSwift
import RxCocoa

enum ActionType {
    case ok
    case cancel
}

final class AlertViewController: UIViewController {
    
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var oneActionButton: UIButton!
    @IBOutlet weak var twoActionsButton: UIButton!
    @IBOutlet weak var multipleActionsButton: UIButton!
    
    let disposeBag: DisposeBag = DisposeBag()
    let viewModel: AlertViewModel = AlertViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindAlertView()
        bindViewModel()
    }
    
    private func bindAlertView() {
        oneActionButton.rx.tap
            .withUnretained(self)
            .flatMap { $0.0.oneActionAlert(title: "색상 정보 출력", message: "색상 정보를 출력합니다.") }
            .subscribe { [weak self] actionType in
                switch actionType {
                case .ok:
                    print("- 뷰의 색상 정보: \(self?.colorView.backgroundColor?.rgbHexString ?? "")")
                default:
                    print("None")
                }
            }
            .disposed(by: disposeBag)
        
        twoActionsButton.rx.tap
            .withUnretained(self)
            .flatMap { $0.0.twoActionAlert(title: "색생 초기화", message: "색상을 초기화하시겠습니까?") }
            .subscribe { [weak self] actionType in
                switch actionType {
                case .ok:
                    self?.colorView.backgroundColor = .black
                default:
                    break
                }
            }
            .disposed(by: disposeBag)
        
        multipleActionsButton.rx.tap
            .withUnretained(self)
            .flatMap { $0.0.multipleActionAlert(colors: MaterialBlue.allColors, title: "색상 선택") }
            .subscribe { [weak self] color in
                self?.colorView.backgroundColor = color
            }
            .disposed(by: disposeBag)
    }
    
    private func bindViewModel() { }
    
}

extension AlertViewController {
    func oneActionAlert(title: String?, message: String? = nil) -> Observable<ActionType> {
        return Observable<ActionType>.create { [weak self] observer in
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "확인", style: .default) { _ in
                observer.onNext(.ok)
                observer.onCompleted()
            }
            alert.addAction(okAction)
            
            self?.present(alert, animated: true)
            
            return Disposables.create {
                self?.dismiss(animated: true)
            }
        }
    }
    
    func twoActionAlert(title: String?, message: String? = nil) -> Observable<ActionType> {
        return Observable<ActionType>.create { [weak self] observer in
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "확인", style: .default) { _ in
                observer.onNext(.ok)
                observer.onCompleted()
            }
            alert.addAction(okAction)
            
            let cancelAction = UIAlertAction(title: "취소", style: .cancel) { _ in
                observer.onCompleted()
            }
            alert.addAction(cancelAction)
            
            self?.present(alert, animated: true)
            
            return Disposables.create {
                self?.dismiss(animated: true)
            }
        }
    }
    
    func multipleActionAlert(colors: [UIColor], title: String?, message: String? = nil) -> Observable<UIColor> {
        return Observable<UIColor>.create { [weak self] observer in
            let actionSheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            
            for color in colors {
                let colorAction = UIAlertAction(title: color.rgbHexString, style: .default) { _ in
                    observer.onNext(color)
                    observer.onCompleted()
                }
                actionSheet.addAction(colorAction)
            }
            
            let cancelAction = UIAlertAction(title: "취소", style: .cancel) { _ in
                observer.onCompleted()
            }
            actionSheet.addAction(cancelAction)
            
            self?.present(actionSheet, animated: true)
            
            return Disposables.create {
                self?.dismiss(animated: true)
            }
        }
    }
}
