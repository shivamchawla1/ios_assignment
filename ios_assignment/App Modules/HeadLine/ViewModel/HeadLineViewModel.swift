//
//  HeadLineViewModel.swift
//  ios_assignment
//
//  Created by Shivam Chawla on 21/08/23.
//

import Foundation

class HeadLineViewModel: ObservableObject {
    @Published var headLineData = HeadLineModel(status: "", totalResults: 0, articles: [])
    @Published var Loading = true

    init() {
        asyncUtility.shared.loadData(
            url: Service(
                endpoint: .everything,
                queryParameters: [
                    URLQueryItem(name: "q", value: "Anime"),
                    URLQueryItem(name: "from", value: "2023-08-20"),
                    URLQueryItem(name: "apiKey", value: "76d8bad973844b55aaf310937caf0081")

                ]).url,
            method: urlMethod.get,
            requestBody: "" ,
            resultType: HeadLineModel.self) { result , loading in
            
            self.headLineData = result ?? HeadLineModel(status: "", totalResults: 0, articles: [])
                
            self.Loading = loading
            
        }
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
