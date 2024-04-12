//
//  TableViewModel.swift
//  HelloRxSwift
//
//  Created by 김건우 on 11/21/23.
//

import Foundation
import RxSwift
import RxCocoa

final class TableViewModel: ViewModelType {
    let products: BehaviorRelay<[Product]> = BehaviorRelay<[Product]>(value: appleProducts)
    
    struct Input {
        let plusTapped: Observable<Void>
        let itemTapped: Observable<(IndexPath, Product)>
        let swipeToDelete: Observable<IndexPath>
        let dragToMove: Observable<ItemMovedEvent>
    }
    
    struct Output {
        let productsData: Observable<[Product]>
        let selectedItem: Observable<IndexPath>
    }
    
    let disposeBag: DisposeBag = DisposeBag()
    
    func transform(_ input: Input) -> Output {
        input.plusTapped
            .withUnretained(self)
            .subscribe {
                var currentProducts = $0.0.products.value
                currentProducts.append(newProduct)
                $0.0.products.accept(currentProducts)
            }
            .disposed(by: disposeBag)
        
        let selectedItem = input.itemTapped
            .map { return $0.0 }
        
        input.swipeToDelete
            .withUnretained(self)
            .subscribe { $0.0.deleteTableRow(at: $0.1) }
            .disposed(by: disposeBag)
        
        input.dragToMove
            .withUnretained(self)
            .subscribe { $0.0.moveTableRow(source: $0.1.sourceIndex, destination: $0.1.destinationIndex) }
            .disposed(by: disposeBag)
        
        return Output(productsData: products.asObservable(), selectedItem: selectedItem)
    }
    
    func deleteTableRow(at indexPath: IndexPath) {
        var currentProduct = products.value
        currentProduct.remove(at: indexPath.row)
        products.accept(currentProduct)
    }
    
    func moveTableRow(source sourceIndexPath: IndexPath, destination destinationIndexPath: IndexPath) {
        var currentProduct = products.value
        let deletedProduct = currentProduct.remove(at: sourceIndexPath.row)
        currentProduct.insert(deletedProduct, at: destinationIndexPath.row)
        products.accept(currentProduct)
    }
}
