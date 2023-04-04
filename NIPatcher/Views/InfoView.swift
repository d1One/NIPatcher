//  PreferencesView.swift

import SwiftUI

struct InfoView: View {
    
    @State private var Mas_Plugs = false
    @State private var KK_Plugs = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Check if App/Plugs exist expected paths")
                    .padding(5)
                Image(systemName: "info.circle")
                    .frame(width: 50, alignment: .trailing)
                    .foregroundColor(.blue)
                    .onTapGesture {
                        guard let url = URL(string: "https://github.com/d1One/NIPatcher/blob/main/README.md#info-tab") else { return }
                        NSWorkspace.shared.open(url)
                    }
            }
            
            GroupBox() {
                VStack(alignment: .leading) {
                    Button(action: {
                        Mas_Plugs.toggle()
                    }) {
                        Text("Maschine")
                    }
                    if Mas_Plugs {
                        ForEach(Array(filePaths.indices), id: \.self) { index in
                            HStack {
                                Text(fileLabels[index])
                                    .frame(width: 50)
                                Image(systemName: checkFiles()[index] ? "checkmark.circle" : "x.circle.fill")
                                    .foregroundColor(checkFiles()[index] ? .green : .red)
                                
                                Text(filePaths[index])
                                    .strikethrough(!checkFiles()[index])
                                    .foregroundColor(checkFiles()[index] ? .primary : .secondary)
                                    .lineLimit(1)
                            }.frame(width: 350, alignment: .leading)
                        }
                    }
                }.frame(width: 350, alignment: .leading)
            }
            
            GroupBox {
                VStack(alignment: .leading) {
                    Button(action: {
                        KK_Plugs.toggle()
                    }) {
                        Text("Komplete Kontrol")
                    }
                    if KK_Plugs {
                        ForEach(Array(filePaths.indices), id: \.self) { index in
                            HStack {
                                Text(fileLabels[index])
                                    .frame(width: 50)
                                
                                Image(systemName: checkFilesKK()[index] ? "checkmark.circle" : "x.circle.fill")
                                    .foregroundColor(checkFilesKK()[index] ? .green : .red)
                                
                                Text(filePaths[index])
                                    .strikethrough(!checkFilesKK()[index])
                                    .foregroundColor(checkFilesKK()[index] ? .primary : .secondary)
                                    .lineLimit(1)
                            }
                            .frame(width: 350, alignment: .leading)
                        }
                    }
                }.frame(width: 350, alignment: .leading)
            }
            Spacer()
            Divider()
            HStack(alignment: .center) {
                Text(" Made by D-One")
                //let link = "[D-One](https://community.native-instruments.com/profile/D-One)"
                //Text(.init(link))
                let link2 = "[buymeacoffee](https://www.buymeacoffee.com/done84)"
                Text(.init(link2))
                
            }
            .padding(.bottom, 5)
            .opacity(0.5)
        }
        //.frame(width: 350, alignment: .leading)
    }
}
struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
