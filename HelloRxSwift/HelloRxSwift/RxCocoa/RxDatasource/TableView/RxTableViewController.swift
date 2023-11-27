//
//  RxTableViewController.swift
//  HelloRxSwift
//
//  Created by 김건우 on 11/27/23.
//

import UIKit

import RxDataSources
import RxSwift

class RxTableViewController: UIViewController {
    // MARK: - Views
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    // MARK: - Properties
    var disposeBag: DisposeBag = DisposeBag()
    
    var todoDatas = BehaviorSubject<[SectionOfTodoData]>(value: SectionOfTodoData.generateData())
//    var dataSource: RxTableViewSectionedReloadDataSource<SectionOfTodoData>!
    var dataSource: RxTableViewSectionedAnimatedDataSource<SectionOfTodoData>!
    
    var isEditMode: Bool = false
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()

        prepareDatasource()
        binding()
    }
    
    // MARK: - Helpers
    func prepareDatasource() {
        dataSource = RxTableViewSectionedAnimatedDataSource<SectionOfTodoData> { dataSource, tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)
            var contentConfig = cell.defaultContentConfiguration()
            contentConfig.text = item.title
            cell.contentConfiguration = contentConfig
            return cell
        }
        
        dataSource.titleForHeaderInSection = { dataSource, index in
            return dataSource[index].header
        }
        
        dataSource.canMoveRowAtIndexPath = { dataSource, index in
            return true
        }
        
        dataSource.canEditRowAtIndexPath = { dataSource, index in
            return true
        }
    }
    
    func binding() {
        editButton.rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .withUnretained(self)
            .subscribe {
                $0.0.tableView.setEditing(!$0.0.tableView.isEditing, animated: true)
            }
            .disposed(by: disposeBag)
        
        todoDatas
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        tableView.rx.itemMoved
            .withUnretained(self)
            .subscribe {
                guard var todoDatas = try? $0.0.todoDatas.value() else { return }
                let moveEvent = $0.1
                var sourceItems = todoDatas[moveEvent.sourceIndex.section].items
                var destinationItems = todoDatas[moveEvent.destinationIndex.section].items

                // 동일한 섹션 내 셀을 이동한 경우
                if moveEvent.sourceIndex.section == moveEvent.destinationIndex.section {
                    let removedItem = destinationItems.remove(at: moveEvent.sourceIndex.row)
                    destinationItems.insert(removedItem, at: moveEvent.destinationIndex.row)
                    let destinationSection = SectionOfTodoData(original: todoDatas[moveEvent.destinationIndex.section], items: destinationItems)
                    todoDatas[moveEvent.destinationIndex.section] = destinationSection
                    $0.0.todoDatas.onNext(todoDatas)
                // 서로 다른 섹션 내 셀을 이동한 경우
                } else {
                    let removedItem = sourceItems.remove(at: moveEvent.sourceIndex.row)
                    destinationItems.insert(removedItem, at: moveEvent.destinationIndex.row)
                    let sourceSection = SectionOfTodoData(original: todoDatas[moveEvent.sourceIndex.section], items: sourceItems)
                    let destinationSection = SectionOfTodoData(original: todoDatas[moveEvent.destinationIndex.section], items: destinationItems)
                    todoDatas[moveEvent.sourceIndex.section] = sourceSection
                    todoDatas[moveEvent.destinationIndex.section] = destinationSection
                    $0.0.todoDatas.onNext(todoDatas)
                }
            }
            .disposed(by: disposeBag)
        
        tableView.rx.itemDeleted
            .withUnretained(self)
            .subscribe {
                guard var todoDatas = try? $0.0.todoDatas.value() else { return }
                var todos = todoDatas[$0.1.section].items
                todos.remove(at: $0.1.row)
                todoDatas[$0.1.section].items = todos
                $0.0.todoDatas.onNext(todoDatas)
            }
            .disposed(by: disposeBag)
    }

}
