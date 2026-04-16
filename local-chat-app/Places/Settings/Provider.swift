//
//  Provider.swift
//  local-chat-app
//
//  Created by mizuu on 2026/04/15.
//

import SwiftUI
import Foundation


struct Provider: View {
    @State var showSheet = false
    var body: some View {
        List {
            Section {
                Button(action:{showSheet = true})
                {
                    Text("新規プロバイダー接続")
                }.sheet(isPresented: $showSheet) {
                    NewProviderView()
                }
            } header: {
                Text("新規作成")
            }
            Section {
                //プロバイダー 一覧を配列として表示したい
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

            }header: {
                Text("作成済")
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


//APIを叩いてモデルを読み込むあれ
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

//新規チャットの制作画面
struct NewProviderView: View {
    var body: some View {
        NavigationView {
            //タイトル
            NewProviderOption()
                .navigationTitle("新規プロバイダー")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("閉じる") {
                            // dismiss処理
                        }
                    }
                }
        }
    }
}
//新規プロバイダー接続画面
struct NewProviderOption: View {
    var body: some View {
        //ここに色々と設計
        Text("作成画面")
    }
}
