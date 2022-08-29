//
//  LoginViewController.swift
//  SpotifyTracks
//
//  Created by Noha Mohamed on 22/08/2022.
//

import UIKit
import NetworkingLayer

protocol LoginViewProtocol : AnyObject ,LoadingViewCapable{
    func didRecieveToken()
    func didRecieveError(_ message: String)
}
class LoginViewController: UIViewController {

    lazy var presenter : LoginPresenterToView = {
        let loginPresenter = LoginPresenter(service: AuthenticationService(apiClient: APICleint.shared))
        loginPresenter.view = self
        return loginPresenter
    }()
    lazy var configuration: SPTConfiguration = {
        let configuration = SPTConfiguration(clientID: AuthenticationConstant.clientID,
                                             redirectURL: URL(string: AuthenticationConstant.redirectURL)!)
        return configuration
    }()
    
    lazy var appRemote: SPTAppRemote = {
        let appRemote = SPTAppRemote(configuration: configuration, logLevel: .debug)
        appRemote.delegate = self
        return appRemote
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func loginToSpotify(_ sender: Any) {
        presenter.login()
    }
    func requestToken(code:String)  {
        presenter.requestToken(code: code)
    }
}
extension LoginViewController: LoginViewProtocol {
    func didRecieveToken() {
        DispatchQueue.main.async {
            let viewController = SearchTableViewController(nibName: "SearchTableViewController", bundle: .main)
            self.view.window?.rootViewController = UINavigationController(rootViewController: viewController)
        }
    }
    
    func didRecieveError(_ message: String) {
        
    }
    
    
}
extension LoginViewController: SPTAppRemoteDelegate {
    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
    }
}
