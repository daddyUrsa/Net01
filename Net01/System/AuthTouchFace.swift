//
//  AuthTouchFace.swift
//  Net01
//
//  Created by Alexey Golovin on 13.03.2021.
//

import Foundation
import LocalAuthentication

final class AuthTouchFace {
    func authenticateUser(completion: @escaping () -> ()) {
        let authenticationContext = LAContext()

        setupAuthenticationContext(context: authenticationContext)
        
        let reason = "Fast and safe authentication in your app"
        var authError: NSError?
        
        if authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
            authenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [unowned self] success, evaluateError in
                if success {
                    // Пользователь успешно прошел аутентификацию
                    print("Пользователь успешно прошел аутентификацию")
                    completion()
                } else {
                    // Пользователь не прошел аутентификацию
                    print("Пользователь не прошел аутентификацию")

                    if let error = evaluateError {
                        print(error.localizedDescription)
                    }
                }
            }
        } else {
            // Не удалось выполнить проверку на использование биометрических данных или пароля для аутентификации
            
            if let error = authError {
                print(error.localizedDescription)
            }
        }
        
    }
    
    func setupAuthenticationContext(context: LAContext) {
        context.localizedReason = "Use for fast and safe authentication in your app"
        context.localizedCancelTitle = "Cancel"
        context.localizedFallbackTitle = "Enter password"
        
        context.touchIDAuthenticationAllowableReuseDuration = 600
    }

}
