//
//  TableViewViewController.swift
//  HelloRxSwift
//
//  Created by 김건우 on 11/21/23.
//

import UIKit
import RxSwift
import RxCocoa

class TableViewViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    let priceFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = NumberFormatter.Style.currency
        f.locale = Locale(identifier: "Ko_kr")
        return f
    }()
    
    let disposeBag: DisposeBag = DisposeBag()
    let productObservble = Observable.of(appleProducts)
    
    let viewModel: TableViewModel = TableViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.setEditing(true, animated: false)
        
        bindTableView()
        bindViewModel()
    }
    
    func bindViewModel() {
        let input = TableViewModel.Input(
            plusTapped: addButton.rx.tap.asObservable(),
            itemTapped: Observable.zip(tableView.rx.itemSelected, tableView.rx.modelSelected(Product.self)),
            swipeToDelete: tableView.rx.itemDeleted.asObservable(),
            dragToMove: tableView.rx.itemMoved.asObservable())
        let output = viewModel.transform(input)
        
        // 아래 items 메서드로 쉽게 데이터 모델과 테이블의 셀을 바인딩할 수 있음.
        // (단, 하나 이상의 셀이나 섹션을 테이블 뷰에 추가하려면 RxDataSource를 사용해야함)
        output.productsData
            .bind(to: tableView.rx.items(cellIdentifier: "productCell", cellType: ProductTableViewCell.self)) { [weak self] index, element, cell in
                cell.categoryLabel.text = element.category
                cell.productNameLabel.text = element.name
                cell.summaryLabel.text = element.summary
                cell.priceLabel.text = self?.priceFormatter.string(for: element.price)
            }
            .disposed(by: disposeBag)
        
        output.selectedItem
            .withUnretained(self)
            .subscribe { // 굳이 이렇게 할 필요가 없는 간단한 로직이나, 연습을 위해 이렇게 구현함.
                $0.0.tableView.deselectRow(at: $0.1, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    func bindTableView() {
        // zip 연산자를 활용해 선택한 셀의 제품 정보와 인덱스 패스를 동시에 방출하도록 함.
//        Observable.zip(tableView.rx.itemSelected, tableView.rx.modelSelected(Product.self))
//            .subscribe { [weak self] indexPath, product in
//                print("- 선택한 셀의 제품 정보: \(product)")
//                self?.tableView.deselectRow(at: indexPath, animated: true)
//            }
//            .disposed(by: disposeBag)
//        
        // 선택한 셀의 IndexPath가 담긴 Next 이벤트를 방출함.
//        tableView.rx.itemSelected
//            .subscribe { element in
//                print(element)
//            }
//            .disposed(by: disposeBag)
        
        // 선택한 셀의 제품 정보가 담긴 Next 이벤트를 방출함.
//        tableView.rx.modelSelected(Product.self)
//            .subscribe { element in
//                print(element)
//            }
//            .disposed(by: disposeBag)
        
        // 스와이프 삭제를 한 IndexPath가 담긴 Next 이벤트를 방출함.
//        tableView.rx.itemDeleted
//            .withUnretained(self)
//            .subscribe { $0.0.viewModel.deleteTableRow(at: $0.1) }
//            .disposed(by: disposeBag)
        
        // 아이템 이동을 한 출발・목적지 IndexPath가 담긴 Next 이벤트를 방출함.
//        tableView.rx.itemMoved
//            .withUnretained(self)
//            .subscribe { $0.0.viewModel.moveTableRow(source: $0.1.sourceIndex, destination: $0.1.destinationIndex) }
//            .disposed(by: disposeBag)
        
        // CocoaTouch 방식으로 델리게이트를 지정하면 RxCocoa 코드가 작동 안함!
//        tableView.delegate = self
        
        // setDelegate 메서드를 사용해야 RxCocoa 코드를 함께 사용 가능함.
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }

}

extension TableViewViewController: UITableViewDelegate {
    
    // ✏️ 코드로 셀을 선택 해제하면 델리게이트 메서드가 호출되지 않음.
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print(#function)
        if let item = tableView.cellForRow(at: indexPath) {
            print("- 선택 해제한 셀의 제품 정보: \(item)")
        }
    }
    
}
