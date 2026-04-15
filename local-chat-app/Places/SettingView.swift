//
//  SettingView.swift
//  local-chat-app
//
//  Created by mizuu on 2026/04/15.
//

import SwiftUI
struct SettingView: View {
    var body: some View {
        NavigationView{
        //設定画面の呼び出し(将来的に設定)
            List {
                //検索用のフォールド(仮)
                Section {
                    NavigationLink(destination: Provider()) {
                        Text("プロバイダー")
                    }
                    NavigationLink(destination: Text("詳細画面")) {
                        Text("プロンプト")
                    }
                    NavigationLink(destination: Text("詳細画面")) {
                        Text("通知設定")
                    }

                } header: {
                    Text("基本設定")
                }
                
                Section {
                    NavigationLink(destination: Text("詳細画面")) {
                        Text("データの管理")
                    }
                    NavigationLink(destination: Text("詳細画面")) {
                        Text("危険区域")
                    }
                } header: {
                    Text("詳細設定")
                }
                
                Section(header: Text("その他")) {
                    NavigationLink(destination: Text("詳細画面")) {
                        Label("アプリ情報", systemImage: "doc.text")
                    }
                }
            }.navigationTitle("設定")
        }
    }
}
