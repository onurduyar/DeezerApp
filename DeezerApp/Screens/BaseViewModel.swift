//
//  BaseViewModel.swift
//  DeezerCase
//
//  Created by Onur Duyar on 10.05.2023.
//

import Foundation

protocol BaseViewModel {
    associatedtype Model
    var data: Model? { get set }
    func fetchData(by id: Int?,completion: @escaping ((Result<Model?, Error>) -> Void ))
}

extension BaseViewModel {
    func fetchData(by id: Int?,completion: @escaping ((Result<Model?, Error>) -> Void )) {}
}
