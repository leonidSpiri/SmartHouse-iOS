//
//  ContentView.swift
//  Shared
//
//  Created by Admin on 10.11.2021.
//

import SwiftUI
struct ContentView: View {
    @State var text = "Hello, world!"
    var body: some View {
        Text(text)
            .padding()
            .onAppear{
                GetFromSQL().getSQLStatistics(name: "home", sensor: "4", whatDayGet: "2022-02-27") { (resArr) in
                    text = resArr[resArr.endIndex-1][2]
        }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
