//
//  NavigationPathTest2.swift
//  NavigationPathTest
//
//  Created by sako0602 on 2023/12/02.
//

import SwiftUI

struct Fruit: Hashable {
    let name: String
}

enum FruitType{
    
    case banana, apple, orange, some, home
    
    @ViewBuilder
    func destination() -> some View{
        switch self {
        case .banana:
            BananaView()
        case .apple:
            AppleView()
        case .orange:
            OrangeView()
        case .some:
            SomeView()
        case .home:
            NavigationPathTest2()
        }
    }
}

class Model: ObservableObject {
    @Published var path = NavigationPath()
}

struct NavigationPathTest2: View {
    
    @StateObject var model =  Model()
    
    var body: some View {
        let _ = print("###", model.path.count)
        NavigationStack(path: $model.path) {
            VStack{
                NavigationLink("ばなな", value: FruitType.banana)
                    .padding()
            }
            .navigationDestination(for: FruitType.self) { fruitType in
                fruitType.destination()
            }
        }
        .environmentObject(model)
    }
}

struct BananaView: View {
    var body: some View{
        VStack{
            Text("🍌")
            NavigationLink("オレンジへ", value: FruitType.orange)
        }
    }
}

struct AppleView: View {
    
    var body: some View{
        VStack{
            Text("🍎")
            NavigationLink("オレンジへ", value: FruitType.orange)
        }
    }
}



struct OrangeView: View {
    var body: some View{
        VStack{
            Text("🍊")
            NavigationLink("someViewへ", value: FruitType.some)
        }
    }
}

struct SomeView: View {
    
    @EnvironmentObject var model: Model

    
    var body: some View{
        VStack {
            Text("❓❓")
            Button("配列削除"){
                model.path.removeLast(model.path.count)
            }
        }
    }
}











//struct NavigationPathTest2: View {
//
//    @State var path = NavigationPath()
//
//    var body: some View {
//        NavigationStack(path: $path) {
//            VStack{
//                Button("バナナ"){
//                    path.append(1)
//                    print(path.count)
//                }.padding()
//
//                Button("りんご"){
//                    path.append(2)
//                    print(path.count)
//                }.padding()
//
//
//            }
//            .navigationDestination(for: Int.self) { int in
//                View2(num: int)
//            }
//        }
//    }
//}
//
//struct View2: View {
//    let num: Int
//    var body: some View {
//            VStack{
//                Text("\(num)")
//            }
//    }
//}




#Preview {
    NavigationPathTest2()
        .environmentObject(Model())
}
