//
//  ContentView.swift
//  NavigationPathTest
//
//  Created by sako0602 on 2023/11/29.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        NavigationStack{
            TabView{
                SubView11()
                    .tabItem { Label("割り勘グループ", systemImage: "person.3.fill") }
                SubView2()
                    .tabItem { Label("清算済グループ", systemImage: "archivebox.fill") }
            }
        }
            
    }
}

#Preview {
    ContentView()
}



struct SubView11: View {
    
    @State private var parks = [Park(name: "大阪城公園"),Park(name: "小屋ダム公園")]
    @State private var navigationPath = NavigationPath()
    @State private var isShowAddGroupView = false
    
    var body: some View {
//        NavigationView {
        NavigationStack(path: $navigationPath) {
                ZStack{
                    List{
                        NavigationLink("遷移", destination: Text("こんちは")
//                            .navigationBarBackButtonHidden(true)
                        )
                            
                    }
//                    Button(action: {
//                        isShowAddGroupView = true
//                    }, label: {
//                        AddButton(diameter: 75)
//                            
//
//                            .padding(.bottom, 1)
//                    })
                    
                }
                .sheet(isPresented: $isShowAddGroupView, content: {
                    AddGroupView(isShowAddGroupView: $isShowAddGroupView)
                })
        }
    }
}



struct SubView2: View {
    var body: some View {
        Text("アーカイブView")
    }
}



private struct AddButton: View {
    let diameter: CGFloat
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .foregroundStyle(Color.blue)
                        .frame(width: diameter, height: diameter)
                        .background(.white)
                
                .padding(.trailing)
            }
        }
    }
}

struct AddGroupView: View {
    @State private var text = "SampleText"
    @Binding var isShowAddGroupView: Bool

    var body: some View {
        NavigationStack{
            ZStack {
                Form {
                    Section {
                        TextField("Placeholder", text: $text)
                    } header: {
                        Text("グループ名")
                    }
                    Section {
                        TextField("Placeholder", text: $text)
                        TextField("Placeholder", text: $text)
                        TextField("Placeholder", text: $text)
                        TextField("Placeholder", text: $text)
                        HStack {
                            Spacer()
                            Button("メンバーを追加", action: {})
                            Spacer()
                        }
                    } header: {
                        Text("メンバーリスト")
                    }
                }
                
                VStack {
                    Spacer()
                    Button("グループを追加"){
                        isShowAddGroupView = false
                    }
                }
                .padding(.bottom, 1)
            }
            .navigationBarTitle(text)
        }
    }
}


struct Park: Identifiable, Hashable {
    let id = UUID()
    var name: String
}
