//
//  NetworkManager.swift
//  H4Xor News
//
//  Created by Katie McBratney on 8/12/21.
//

import Foundation
import SwiftUI

class NetworkManager: ObservableObject {
    
    @Published var posts = [Post]()
    
    func fetchData(){
        if let url = URL(string: "http://hn.algolia.com/api/v1/search?tags=front_page"){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                        let results = try decoder.decode(Results.self, from: safeData)
                        DispatchQueue.main.async{
                            self.posts = results.hits
                        }
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
}

struct NetworkManager_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
