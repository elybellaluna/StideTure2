//
//  signInPage.swift
//  StideTure2
//
//  Created by 52GOParticipant on 7/21/25.
//

import SwiftUI
import AuthenticationServices

struct signInPage: View {
 @AppStorage("userFirstName") var userFirstName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var lastName: String = ""
    var body: some View {
        VStack{
            Text("Sign In")
                .bold()
                .font(.largeTitle)
            
            TextField("First Name", text: $userFirstName)
                .textContentType(.name)
                .background(Color(.secondarySystemBackground))
                .frame(width: 300, height: 50)
                .cornerRadius(10)
            
            TextField("Last Name", text: $lastName)
                .textContentType(.name)
                .background(Color(.secondarySystemBackground))
                .frame(width: 300, height: 50)
                .cornerRadius(10)
            
            TextField("Email", text: $email)
                .textContentType(.emailAddress)
                .background(Color(.secondarySystemBackground))
                .frame(width: 300, height: 50)
                .cornerRadius(10)
            
            SecureField("Password", text: $password)
                .textContentType(.password)
                .background(Color(.secondarySystemBackground))
                .frame(width: 300, height: 50)
                .cornerRadius(10)
            
        }
        
        SignInWithAppleButton(
            .signIn,
            onRequest: { request in
                request.requestedScopes = [.fullName, .email]
            },
            onCompletion: { result in
                switch result {
                case .success(let authorization):
                    if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
                        if let fullName = appleIDCredential.fullName {
                            if let firstName = fullName.givenName {
                                userFirstName = firstName
                            }
                        }
                    }
                case .failure(let error):
                    print("sign in failed: \(error.localizedDescription)")
                }
            }
        )
        .signInWithAppleButtonStyle(.black)
        .frame(height: 50)
        .cornerRadius(10)
        .padding()
    }
}

#Preview {
    signInPage()
}
