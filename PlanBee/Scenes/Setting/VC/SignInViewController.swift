//
//  SignInViewController.swift
//  PlanBee
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import UIKit

final class SignInViewController: UIViewController {
    private let signInView = SignInView()
    
    override func loadView() {
        super.loadView()
        
        view = signInView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setButtonTarget()
    }
    
    deinit {
        print("deinit - SignInVC")
    }
}

extension SignInViewController {
    func configure() {
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = ThemeColor.PlanBeeBackgroundColor
    }
}

private extension SignInViewController {
    func setButtonTarget() {
        signInView.loginBtn.addTarget(
            self,
            action: #selector(didTappedLoginBtn),
            for: .touchUpInside)
        
        signInView.registerBtn.addTarget(
            self,
            action: #selector(didTappedRegisterBtn),
            for: .touchUpInside)
    }
    
    @objc func didTappedLoginBtn() {
        let loginVC = LoginViewController(
            buttonType: .login,
            title: LoginBtnType.login.title)
        loginVC.modalPresentationStyle = .fullScreen
        loginVC.modalTransitionStyle = .flipHorizontal
        loginVC.configure(tapped: .login)
        loginVC.popToRootViewsClosure = { [weak self] in
            guard let self = self else { return }
            self.navigationController?.popToRootViewController(animated: true)
        }
        present(loginVC, animated: true)
    }
    
    @objc func didTappedRegisterBtn() {
        let loginVC = LoginViewController(
            buttonType: .register,
            title: LoginBtnType.register.title)
        loginVC.modalPresentationStyle = .fullScreen
        loginVC.modalTransitionStyle = .flipHorizontal
        loginVC.configure(tapped: .register)
        loginVC.popToRootViewsClosure = { [weak self] in
            guard let self = self else { return }
            self.navigationController?.popToRootViewController(animated: true)
        }
        present(loginVC, animated: true)
    }
}
