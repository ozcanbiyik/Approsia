//
//  YemekDetayRouter.swift
//  FinalProjesi
//
//  Created by Ozcan Biyik on 12.01.2022.
//

import Foundation

class YemekDetayRouter : PresenterToRouterYemekDetayProtocol{
    static func createModule(ref: YemekDetayVC) {
        
        let presenter = YemekDetayPresenter()
        
        ref.yemekDetayPresenterNesnesi = presenter
        
        ref.yemekDetayPresenterNesnesi?.yemekDetayInteractor = YemekDetayInteractor()
        ref.yemekDetayPresenterNesnesi?.yemekDetayView = ref
        
        ref.yemekDetayPresenterNesnesi?.yemekDetayInteractor?.yemekDetayPresenter = presenter

    }
    
}

