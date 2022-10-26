//
//  ContentView.swift
//  SwiftUIHelloWorld
//
//  Created by ChaohuiChen on 2021/7/15.
//

import SwiftUI

public struct ContentView: View {
    public var body: some View {
        VStack(alignment: .leading) {
            Text("Hello, worldsfdasd")
                .font(.title)
                .foregroundColor(.blue)
            HStack {
                Text("电话号码:")
                    .font(.headline)
                Text("1234451245")
            }
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
