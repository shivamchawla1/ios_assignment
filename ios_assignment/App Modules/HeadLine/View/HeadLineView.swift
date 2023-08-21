//
//  HeadLineView.swift
//  ios_assignment
//
//  Created by Shivam Chawla on 21/08/23.
//

import SwiftUI

struct HeadLineView: View {
    @StateObject var viewModel : HeadLineViewModel = HeadLineViewModel()
    
    @EnvironmentObject var appViewModel : AppViewModel
    var body: some View {
        VStack {
            Rectangle()
                .frame(height: 70)
                .foregroundColor(.black)
                .overlay {
                    HStack {
                        Text("HeadLines")
                            .font(.custom("RobotoSlab-Bold", size: 29.0))
                            .foregroundColor(.white)
                        
                    }
                }
            
            if viewModel.headLineData.articles.isEmpty {
                
            ProgressView()
                Spacer()
                
                
            }else{
                ScrollView{
                    ForEach(viewModel.headLineData.articles , id: \.url){ data in
                        
                        NavigationLink{
                            NewsDetailsView(newsData: data)
                        }label:{
                            rowView(data)
                        }
                    }
                    
                    Button{
                        appViewModel.signOut()
                    }label: {
                        Text("Sign Out")
                    }
                }
                .background(Color(red: 70/255.0, green: 70/255.0, blue: 70/255.0))
                .padding(.top , -10)
            }
        }
//        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
        
    }
    @ViewBuilder
    func rowView(_ data: Article )-> some View {
        ZStack{
            AsyncImage(url: URL(string: data.urlToImage ?? "")){ image in
                image
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width / 1.1 ,height: 270)
                    .aspectRatio( contentMode: .fill)
                    .edgesIgnoringSafeArea(.horizontal)
                    .cornerRadius(15)
            } placeholder: {
                Image(systemName: "photo.fill")
            }
            

            
            HStack{
                VStack(alignment: .leading){
                    Spacer()
                    
                    Text(data.title ?? "")
                        .font(.custom("RobotoSlab-Regular", size: 20.0))
                        .multilineTextAlignment(.leading)
                        .lineLimit(3)
                        .padding(.bottom , 5)
                    
                    HStack{
                        Text(data.source.name ?? "")
                            .font(.custom("RobotoSlab-Bold", size: 12.0))

                        Text(viewModel.getDate(data.publishedAt ?? ""))
                            .font(.custom("RobotoSlab-Light", size: 12.0))

                    }
                    
                }
                .foregroundColor(.white)
                
                Spacer()
            }
            .shadow(radius: 10)
            .padding()
        }
        .shadow(radius: 10)
        .padding(.top)
        .padding(.horizontal)
    }
    
}

struct HeadLineView_Previews: PreviewProvider {
    static var previews: some View {
        HeadLineView()
    }
}
