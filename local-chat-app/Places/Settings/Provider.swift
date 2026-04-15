//
//  Provider.swift
//  local-chat-app
//
//  Created by mizuu on 2026/04/15.
//

import SwiftUI
import Foundation


struct Provider: View {
    var body: some View {
        List {
            Section {
                //とりあえずOpenAi互換を前提にしたい
                NavigationLink(destination: CheckProvider()) {
                    Text("OpenAI")
                }
                NavigationLink(destination: CheckProvider()) {
                    Text("Gemini")
                }
                NavigationLink(destination: CheckProvider()) {
                    Text("OpenAI互換")
                }

            }
        }.navigationTitle("プロバイダー")
    }
}

struct CheckProvider: View {
    var body: some View {
        @State var inputURL = ""
        @State var APIKey = ""
        List {
            Section {
                TextField("URLを入力",text: $inputURL)
            } header: {
                Text("URL")
            }
            Section {
                TextField("APIキーを入力",text: $APIKey)
            } header: {
                Text("API Key")
            }
            
            Section {
                Button(action:{fetchModels(inputURL: "(inputURL)") })
                {
                    Text("設定を保存")
                }
            }
        }.navigationTitle("OpenAI互換(仮)")
    }
}

struct ModelList: Decodable {
    let data: [Model]
}

struct Model: Decodable {
    let id: String
}


func fetchModels(inputURL: String) {
    guard let checkurl = URL(string: inputURL+"/v1/models") else { return }

    var request = URLRequest(url: checkurl)
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    // APIキーが必要な場合（LM Studioは不要なことが多い）
    request.setValue("Bearer dummy", forHTTPHeaderField: "Authorization")

    URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            print("Error:", error)
            return
        }

        guard let data = data else { return }
        do {
            let decoded = try JSONDecoder().decode(ModelList.self, from: data)
            for model in decoded.data {
                print("Model:", model.id)
            }
            
        } catch {
            print("Decode Error:", error)
            print("URL:",inputURL)
        }
    }.resume()
    print("処理の成功")
}
