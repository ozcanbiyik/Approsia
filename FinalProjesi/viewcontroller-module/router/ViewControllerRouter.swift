//
//  ViewControllerRouter.swift
//  FinalProjesi
//
//  Created by Ozcan Biyik on 12.01.2022.
//

import Foundation

class ViewControllerRouter : PresenterToRouterViewControllerProtocol{
    
    static func createModule(ref: ViewController) {
        let presenter = ViewControllerPresenter()
        ref.viewControllerPresenterNesnesi = presenter
        ref.viewControllerPresenterNesnesi?.viewControllerInteractor = ViewControllerInteractor()
        ref.viewControllerPresenterNesnesi?.viewControllerView = ref
        ref.viewControllerPresenterNesnesi?.viewControllerInteractor?.viewControllerPresenter = presenter
    }
    
}
