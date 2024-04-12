//
//  ViewModelType.swift
//  HelloRxSwift
//
//  Created by 김건우 on 4/12/24.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(_ input: Input) -> Output
}
