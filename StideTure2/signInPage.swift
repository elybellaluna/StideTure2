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
    @AppStorage("isSignedIn")var isSignedIn = false
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var lastName: String = ""
    @State private var firstName: String = ""
    
    var body: some View {
        
        if isSignedIn{
            tabBar()
        } else {
            
            VStack{
                Text("Sign In")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(Color(red: 0.1568627450980392, green: 0.47058823529411764, blue: 0.5254901960784314))
                
                TextField("First Name", text: $firstName)
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
                
                Button("Log In"){
                    userFirstName = firstName
                    isSignedIn = true
                }
                .frame(width: 300, height: 50)
                .background(Color(red: 165/255, green: 166/255, blue: 246/255))
                .cornerRadius(10)
                .foregroundColor(.white)
            
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
}
#Preview {
    signInPage()
}
//light purple: A5A6F6 red: 165/255, green: 166/255, blue: 246/255, dark purple: 8368B9 red: 131/255, green: 104/255, blue: 185/255, teal:287886
