import Foundation
import Combine

class SignInViewModel: ObservableObject{
    @Published var isUserSignedIn = false
    let loginService: LoginService
    var cancellables = Set<AnyCancellable>()
    
    init(loginService: LoginService){
        self.loginService = loginService
    }
    
    func signIn(email: String, password: String){
        let userCredential = UserCredential(email: email, password: password)
        return loginService.signIn(credential: userCredential)
            .sink{
                _ in
            } receiveValue:{ [weak self] resultUserSignIn in
                self?.isUserSignedIn = resultUserSignIn
            }
            .store(in: &cancellables)
    }
    
    func mockValidateEmail(email: String) -> Bool{
        return email.count > 4
    }
    
    func mockValidatePassword(password: String) -> Bool{
        return password.count > 4
    }
}
