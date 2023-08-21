//
//  NewsDetailsView.swift
//  ios_assignment
//
//  Created by Shivam Chawla on 21/08/23.
//

import SwiftUI

struct NewsDetailsView: View {
    var newsData : Article
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack{
            AsyncImage(url: URL(string: newsData.urlToImage ?? "")){ image in
                image
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width , height: UIScreen.main.bounds.height / 1.1)
                    .aspectRatio( contentMode: .fit)
                    .overlay {
                        Rectangle()
                            .fill(.black.opacity(0.1))
                    }
            } placeholder: {
                Image(systemName: "photo.fill")
            }
            
            VStack{
                HStack{
                    Button{
                        self.presentationMode.wrappedValue.dismiss()
                    }label: {
                        ZStack{
                            Circle()
                                .fill(.black.opacity(0.3))
                                .frame(width: 40)
                            
                            Image(systemName: "arrow.left")
                                .foregroundColor(.white)

                        }
                        
                    }
                    
                    Spacer()
                }
                .padding()
                
                
                Spacer()
                
                VStack{
                    Text(newsData.title ?? "")
                        .font(.custom("RobotoSlab-Bold", size: 29.0))
                        .padding(.bottom , 50)

                    HStack{
                        Text(newsData.source.name ?? "")
                            .font(.custom("RobotoSlab-Regular", size: 20.0))
                        
                        Spacer()

                        Text(getDate(newsData.publishedAt ?? ""))
                            .font(.custom("RobotoSlab-Regular", size: 20.0))

                    }
                    .padding(8)
                    Text(newsData.description ?? "")
                        .font(.custom("RobotoSlab-Light", size: 18.0))

                }
                .padding()
                .foregroundColor(.white)

            }

        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarBackButtonHidden(true)
    }
    
    func getDate(_ string : String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        
        if let inputDate = dateFormatter.date(from: string) {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateOnlyString = dateFormatter.string(from: inputDate)
            return dateOnlyString
        } else {
            print("Invalid date string")
        }
        
        return ""
    }
}

struct NewsDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsDetailsView(newsData: Article(source: Source(id: "", name: ""), author: "", title: "", description: "", url: "", urlToImage: "https://i.guim.co.uk/img/media/1bf0a8976acdce6559e28ec9ab6e6ebbe2a33986/0_0_2560_1536/master/2560.jpg?width=1200&height=630&quality=85&auto=format&fit=crop&overlay-align=bottom%2Cleft&overlay-width=100p&overlay-base64=L2ltZy9zdGF0aWMvb3ZlcmxheXMvdG8tZGVmYXVsdC5wbmc&enable=upscale&s=1e62c865ccb4b67c4bad749cd16523ba", publishedAt: "", content: ""))
    }
}
