//
//  ChatView.swift
//  local-chat-app
//
//  Created by mizuu on 2026/04/15.
//

import SwiftUI

struct ChatView: View {
    @State var input = ""
    private let rect = RoundedRectangle.rect(cornerRadius: 100)

    var body: some View {
            NavigationStack
            {
                //会話の入力画面(仮)
                TextField("会話してみよう",text: $input)
                    .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                            .textFieldStyle(.plain)
                            .padding(20)
                            .background(.background, in: rect)
                            .overlay(rect.stroke(.secondary, lineWidth: 0.5))
                Button(action:{print("送信完了")})
                {
                    Image(systemName: "arrowshape.up")
                }
                
                
                    
            }
            .navigationTitle("会話画面(仮)")
        }
    }
