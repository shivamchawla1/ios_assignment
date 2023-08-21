//
//  AuthView.swift
//  ios_assignment
//
//  Created by Shivam Chawla on 21/08/23.
//

import SwiftUI

struct AuthView: View {
    @EnvironmentObject var viewModel : AppViewModel
    

    var body: some View {
        NavigationView{
            if viewModel.signedIn {
                HeadLineView()
            }else{
                SignInView()
            }
  
        }
        .onAppear{
            viewModel.signedIn = viewModel.isSignedIn
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
