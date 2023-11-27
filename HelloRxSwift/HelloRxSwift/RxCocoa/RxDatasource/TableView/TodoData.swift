//
//  TodoData.swift
//  HelloRxSwift
//
//  Created by 김건우 on 11/27/23.
//

import Foundation

import RxDataSources

struct TodoData {
    let title: String
    let isCompleted: Bool = false
}

extension TodoData: IdentifiableType, Equatable {
    typealias Identity = String

    var identity: String {
        return title
    }
}

struct SectionOfTodoData {
    var header: String
    var items: [Item] = []
}

extension SectionOfTodoData: AnimatableSectionModelType {
    typealias Item = TodoData
    typealias Identity = String
    
    var identity: String {
        return header
    }
    
    init(original: SectionOfTodoData, items: [Item]) {
        self = original
        self.items = items
    }
}

extension SectionOfTodoData {
    static func generateData() -> [SectionOfTodoData] {
        let houseWork = [
            Item(title: "청소기 돌리기"),
            Item(title: "문어 뽀뽀해주기"),
            Item(title: "흰둥이 이뻐해주기"),
        ]
        let codingStudy = [
            Item(title: "RxDatasource 공부하기"),
            Item(title: "RxSwift 복습하기")
        ]
        let etc = [
            Item(title: "치킨 시켜먹기")
        ]
        
        let sectionOfTodoDatas: [SectionOfTodoData] = [
            SectionOfTodoData(header: "집안일", items: houseWork),
            SectionOfTodoData(header: "개발일", items: codingStudy),
            SectionOfTodoData(header: "잡일", items: etc)
        ]
        return sectionOfTodoDatas
    }
}
