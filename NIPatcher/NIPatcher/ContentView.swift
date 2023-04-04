//  ContentView.swift

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ScrollView {
                MaschineView()
                    .padding(5)
            }
            .tabItem {
                Label("Maschine", systemImage: "tray.and.arrow.down.fill")
            }
            ScrollView {
                KompleteKontrolView()
                    .padding(5)
            }
            .tabItem {
                Label("Komplete Kontrol", systemImage: "tray.and.arrow.down.fill")
            }
            ScrollView {
                InfoView()
                    .padding(5)
            }
            .tabItem {
                Label("Info", systemImage: "tray.and.arrow.down.fill")
            }
        }
        .frame(minWidth: 450, minHeight: 300) // Set default minimum size for all views
        .padding(10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
