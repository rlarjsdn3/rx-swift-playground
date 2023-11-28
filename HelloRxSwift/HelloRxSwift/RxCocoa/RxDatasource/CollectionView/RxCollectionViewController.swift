//
//  RxCollectionViewController.swift
//  HelloRxSwift
//
//  Created by 김건우 on 11/27/23.
//

import UIKit

import RxDataSources
import RxSwift

class RxCollectionViewController: UIViewController {
    // MARK: - Views
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    let disposeBag: DisposeBag = DisposeBag()
    
    let colorData = ColorSectionModel.generateSectionModel()
    var dataSource: RxCollectionViewSectionedReloadDataSource<ColorSectionModel>!
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(TitleReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "titleHeaderView")
        
        configureLayout()
        prepareDatasource()
        binding()
    }
    
    // MARK: - Helpers
    private func prepareDatasource() {
        dataSource = RxCollectionViewSectionedReloadDataSource<ColorSectionModel> { dataSource, collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colorCell", for: indexPath)
            var backgroundCnofig = UIBackgroundConfiguration.listPlainCell()
            backgroundCnofig.backgroundColor = item
            cell.backgroundConfiguration = backgroundCnofig
            cell.backgroundConfiguration?.cornerRadius = 10.0
            return cell
        }
        
        dataSource.configureSupplementaryView = { dataSource, collectionView, kind, indexPath in
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "titleHeaderView", for: indexPath) as! TitleReusableView
            switch dataSource[indexPath.section] {
            case let .gridSection(title, _):
                fallthrough
            case let .pageSection(title, _):
                fallthrough
            case let .listSection(title, _):
                headerView.configureCell(title: title)
            }
            return headerView
        }
    }
    
    private func binding() {
        Observable.just(colorData)
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    private func configureLayout() {
        collectionView.collectionViewLayout = createLayout()
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let compositionalLayout = UICollectionViewCompositionalLayout { [weak self] index, environment in
            switch self?.dataSource[index] {
            case .pageSection(title: _, items: _):
                return self?.createPagingSection()
            case .gridSection(title: _, items: _):
                return self?.createGridSection()
            default:
                return self?.createPagingSection()
            }
        }
        return compositionalLayout
    }
    
    private func createPagingSection() -> NSCollectionLayoutSection {
        // item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(250)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.interGroupSpacing = 10.0
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        
        // supplementary View
        let headerViewSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(30)
        )
        let headerView = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerViewSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [headerView]
        
        return section
    }
    
    private func createGridSection() -> NSCollectionLayoutSection {
        // item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .estimated(100)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(100)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
        group.interItemSpacing = .fixed(10.0)
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10.0
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        
        // supplementary View
        let headerViewSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(30)
        )
        let headerView = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerViewSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [headerView]
        
        return section
    }
    
}
