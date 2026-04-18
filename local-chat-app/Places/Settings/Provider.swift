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
    
    @State var Name = ""
    @State var Url = ""
    @State var ApiKey = ""
    @State var result = false
    @State var ExitCode = 0
    var body: some View {
        List {
            Section {
                Button(action:{showSheet = true})
                {
                    Text("新規プロバイダー接続")
                }.sheet(isPresented: $showSheet) {
                    NavigationView {
                        //タイトル
                        NavigationStack
                        {
                            List {
                                Section{
                                    TextField("名前を入力",text: $Name)
                                } header: {
                                    Text("名称")
                                }
                                Section{
                                    TextField("URLを入力",text: $Url)
                                    TextField("APIキーを入力",text: $ApiKey)
                                    
                                } header: {
                                    Text("サーバー設定")
                                }
                            }
                        }
                        .navigationTitle("新規プロバイダー")
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button("閉じる") {
                                    showSheet = false
                                }
                            }
                            
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button("保存") {
                                    
                                    //サーバーへの接続処理(仮) by AI生成
                                    guard let checkurl = URL(string: Url+"/v1/models") else { return }
                                    var request = URLRequest(url: checkurl)
                                    request.httpMethod = "GET"
                                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                                    request.setValue("Bearer dummy", forHTTPHeaderField: "Authorization")
                                    
                                    URLSession.shared.dataTask(with: request) { data, response, error in
                                        if let error = error {
                                            print("Error:", error)
                                            ExitCode = 1
                                            result = true
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
                                            print("URL:",Url)
                                            result = true
                                        }
                                        
                                        showSheet = false
                                    }.resume()
                                }.alert("Result",isPresented: $result)
                                {
                                    
                                } message: {
                                    switch ExitCode {
                                    case 1:
                                        Text("失敗")
                                        Text("接続に失敗しました")
                                    case 0:
                                        Text("成功")
                                        Text("接続に成功しました")
                                    default:
                                        Text("例外処理")
                                    }
                                }
                            }
                        }
                    }
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
