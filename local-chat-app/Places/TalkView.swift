//
//  TalkView.swift
//  local-chat-app
//
//  Created by mizuu on 2026/04/15.
//
import SwiftUI

struct TalkView: View {
    @State var input =  ""
    @State private var isDarkMode = false
    @State private var showSheet = false
    var body: some View {
        NavigationStack {
            //トーク画面のリストの画面の呼び出し(暫定処置)
            List {
                
                Section {
                    //新規会話の作成用UI
                    Button(action:{showSheet = true})
                    {
                        Text("新規会話作成")
                    }.sheet(isPresented: $showSheet) {
                        NewTalkView()
                    }
                } header: {
                    Text("新規会話")
                }
                
                
                Section {
                    //配列でトークデータの準備
                    
                    //会話のサンプル画面(仮)
                    Section() {
                        NavigationLink(destination: ChatView()) {
                            Label("何かしらの会話", systemImage: "doc.text")
                        }
                    }
                    Text("会話3")
                } header: {
                    Text("会話一覧")
                }
            }
            .navigationTitle("LocalChatApp(仮称)")
            .toolbar {
                // 左上のボタン
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        print("左上ボタンタップ")
                    }) {
                        Image(systemName: "line.3.horizontal")
                    }
                }
            }
        }
        
    }
    
    //新規チャットの制作画面
    struct NewTalkView: View {
        var body: some View {
            NavigationView {
                //タイトル
                NewTalkOption()
                    .navigationTitle("新規会話")
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
    
    struct NewTalkOption: View {
        var body: some View {
            Text("作成画面")
        }
    }
}
