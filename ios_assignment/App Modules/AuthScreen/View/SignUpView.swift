//
//  SignUpView.swift
//  ios_assignment
//
//  Created by Shivam Chawla on 21/08/23.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var viewModel : AppViewModel

    @State var email = ""
    @State var pass = ""

    var body: some View {
        VStack(alignment: .center, spacing: 40) {
            Spacer()
            
            Image(systemName: "person.fill")
                .resizable()
                .frame(width: 100, height: 100)
                        
            Text("Welcome!!")
                .font(.system(size: 30))
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
                .offset(x: -15)
                .padding(.bottom , 20)
            
            //Login Form
            VStack(spacing : 30){
                
                TextField("Email Address", text: $email)
                    .textInputAutocapitalization(TextInputAutocapitalization.never)
                    .padding()
                    .frame(width: 350 , height: 48)
                
                SecureField("Password", text: $pass)
                    .textInputAutocapitalization(TextInputAutocapitalization.never)
                    .padding()
                    .frame(width: 350 , height: 48)
                
            
            }
           
            
            
            VStack(spacing : 20){
                
                Button{
                    
                    guard !email.isEmpty , !pass.isEmpty else {
                        return
                    }
                    viewModel.signUp(email: email, password: pass)
                }label: {
                    Text("Sign Up")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 120.0)
                        .frame(height: 40, alignment: .center)
                        .background(Color.blue)
                        .cornerRadius(20)
                }
             
                Spacer()
            }
        }
        .padding()
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
