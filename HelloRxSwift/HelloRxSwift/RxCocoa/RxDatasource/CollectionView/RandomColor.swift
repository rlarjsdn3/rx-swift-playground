//
//  RandomColor.swift
//  HelloRxSwift
//
//  Created by 김건우 on 11/28/23.
//

import UIKit

import RxDataSources
import RxSwift

enum ColorSectionModel {
    case pageSection(title: String, items: [UIColor])
    case gridSection(title: String, items: [UIColor])
    case listSection(title: String, items: [UIColor])
}

extension ColorSectionModel: SectionModelType {
    typealias Item = UIColor
    
    var items: [UIColor] {
        switch self {
        case let .pageSection(_, items): 
            return items
        case let .gridSection(_, items):
            return items
        case let .listSection(_, items):
            return items
        }
    }
    
    init(original: ColorSectionModel, items: [UIColor]) {
        switch original {
        case let .pageSection(title, _):
            self = .pageSection(title: title, items: items)
        case let .gridSection(title, _):
            self = .gridSection(title: title, items: items)
        case let .listSection(title, _):
            self = .listSection(title: title, items: items)
        }
    }
}

extension ColorSectionModel {
    static func generateSectionModel() -> [ColorSectionModel] {
        func getRandomColor() -> UIColor {
            return UIColor(
                red: CGFloat.random(in: 0...255) / 255.0,
                green: CGFloat.random(in: 0...255) / 255.0,
                blue: CGFloat.random(in: 0...255) / 255.0,
                alpha: 1.0
            )
        }
        
        let pageSection = pageSection(
            title: "페이지",
            items: [getRandomColor(), getRandomColor(), getRandomColor()]
        )
        let gridSection = gridSection(
            title: "그리드",
            items: [getRandomColor(), getRandomColor(), getRandomColor(), getRandomColor()]
        )
        let listSection = listSection(
            title: "리스트",
            items: [getRandomColor(), getRandomColor()]
        )
        
        return [pageSection, gridSection, listSection]
    }
}
