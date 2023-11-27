import Foundation
import Combine

class SignInViewModel: ObservableObject{
    @Published var isUserSignedIn: Bool? = nil
    var signInFailed: Bool = false
    let loginService: LoginService
    var cancellables = Set<AnyCancellable>()
    
    init(loginService: LoginService){
        self.loginService = loginService
    }
    
    func signIn(email: String, password: String){
        let userCredential = UserCredential(email: email, password: password)
        
        loginService.signIn(credential: userCredential) { [weak self] result in
            switch result {
            case .success(let value):
                DispatchQueue.main.async {
                    self?.isUserSignedIn = value
                    self?.signInFailed = false
                }
            case .failure(_/*let error*/):
                DispatchQueue.main.async {
                    self?.isUserSignedIn = false
                    self?.signInFailed = true
                }
            }
        }
    }
}
