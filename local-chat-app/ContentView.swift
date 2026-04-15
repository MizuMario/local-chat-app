//
//  ContentView.swift
//  local-chat-app
//
//  Created by MM_San on 2026/04/14.
//
import SwiftUI

struct ContentView: View {
    @State var input =  ""
    
    var body: some View {
            TabBarView()
        }
        
        //メニューボタンの実装
        
        //その他色々
    
        
        //タブバーの実装
    }

#Preview {
    ContentView()
}

struct TuningView: View {
    var body: some View {
        //調整画面の呼び出し
        Text("tuning")
    }
}

struct FilesView: View {
    var body: some View {
        //調整画面の呼び出し
        Text("files")
    }
}

struct TabBarView: View {
    var body: some View {
        HStack {
            TabView{
                TalkView()
                    .tabItem {
                        Image(systemName: "text.bubble.fill")
                        Text("talk")
                    }
                TuningView()
                    .tabItem {
                        Image(systemName: "slider.horizontal.3")
                        Text("tuning")
                        
                    }
                FilesView()
                    .tabItem {
                        Image(systemName: "folder")
                        Text("files")
                    }
                SettingView()
                    .tabItem {
                        Image(systemName: "gear")
                        Text("settings")
                    }
            }
        }
    }
}
