//
//  CollectionViewViewController.swift
//  HelloRxSwift
//
//  Created by 김건우 on 11/21/23.
//

import UIKit
import RxSwift
import RxCocoa

class CollectionViewViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let disposeBag: DisposeBag = DisposeBag()
    let viewModel: CollectionViewModel = CollectionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        bindCollectionView()
        bindViewModel()
    }
    
    func setupLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5.0
        layout.minimumInteritemSpacing = 5.0
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: 5.0, bottom: 0.0, right: 5.0)
        
        collectionView.collectionViewLayout = layout
    }
    
    func bindCollectionView() {
        viewModel.colors
            .bind(to: collectionView.rx.items(cellIdentifier: "colorItem", cellType: ColorCollectionViewCell.self)) { index, color, cell in
                cell.hexLabel.text = color.rgbHexString
                cell.backgroundColor = color
            }
            .disposed(by: disposeBag)
        
        collectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    func bindViewModel() {
        let input = CollectionViewModel.Input(itemTapped: collectionView.rx.modelSelected(UIColor.self).asObservable())
        let output = viewModel.transform(input: input)
    }

}

extension CollectionViewViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return .zero
        }
        
        var width = view.frame.width - (flowLayout.sectionInset.left + flowLayout.sectionInset.right)
        var height = 0.0
        
        width = (width - (flowLayout.minimumInteritemSpacing * 2.0)) / 3.0
        height = width
        
        return CGSize(width: width, height: height)
    }
}
