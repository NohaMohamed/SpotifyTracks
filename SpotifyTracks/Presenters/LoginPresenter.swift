//
//  LoginPresenter.swift
//  SpotifyTracks
//
//  Created by Noha Mohamed on 22/08/2022.
//

import Foundation
protocol LoginPresenterToView: AnyObject {
    func requestToken(code: String)
    func login()
}
final class LoginPresenter {
    
    //MARK: Dependencies
    
    weak var view: LoginViewProtocol?
    var service : AuthenticationServiceProtocol?
    
    
    //MARK: Properties
    
    init(service: AuthenticationServiceProtocol) {
        self.service = service
    }
    func checkUserAuthorization() {
    }
    
}
extension LoginPresenter: LoginPresenterToView {
    func login() {
        guard let url = AuthenticationRequest.login.convertRequestIntoURL()else{
            return
        }
        UIApplication.shared.open(url)
    }
    func requestToken(code: String) {
        service?.reuqestToken(code: code, compeletion: { [weak self] result in
            switch result{
            case .success(let model):
                self?.service?.cacheToken(model)
                self?.view?.didRecieveToken()
            case .failure(let error):
                self?.view?.didRecieveError(error.localizedDescription)
            }
        })
    }
}
