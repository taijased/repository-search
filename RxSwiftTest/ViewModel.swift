//
//  ViewModel.swift
//  RxSwiftTest
//
//  Created by Maxim Spiridonov on 19/04/2019.
//  Copyright © 2019 Maxim Spiridonov. All rights reserved.
//


import UIKit
import RxSwift
import RxCocoa


struct ViewModel {

    
    let searchText = Variable<String>("")
    
    let APIProvider: APIProvider
    var data: Driver<[Repository]>
    
    init(APIProvider: APIProvider) {
        self.APIProvider = APIProvider
        
        data = self.searchText.asObservable()
            .throttle(0.3, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest { APIProvider.getRepositories($0) }
            .asDriver(onErrorJustReturn: [])
        
    }
}
