//  ContentView.swift

import SwiftUI

struct MaschineView: View {
    
    // Variables for Maschine Plugin Sizes
    @State private var MminHeight: String = "631"
    @State private var smallWidth: String = "1129"
    @State private var smallWidthBrowser: String = "1194"//Not using this, should I add it?
    @State private var smallHeight: String = "631"
    @State private var medWidth: String = "1210"
    @State private var medHeight: String = "758"
    @State private var largeWidth: String = "1500"
    @State private var largeHeight: String = "930"
    
    // Bool vars for the toggles
    @State private var plug1 = false
    @State private var app1 = false
    @State private var plug2 = false
    @State private var app2 = false
    @State private var plug3 = false
    @State private var app3 = false
    @State private var app4 = false//Stop - Hack #4
    @State private var plug5 = false
    @State private var app5 = false
    
    // String vars for Maschine Font Sizes
    @State private var fontButton: String = "11"
    @State private var fontLabel: String = "11"
    
    // String var for the Codesign shell output
    @State private var output = ""
    
    // String var for the pop-up codesign window with the shell output.
    @State private var showingSheet = false
    
    var body: some View {
        VStack {
            //              HACK #1 WINDOW SIZES
            // ----------------------------------------------
            VStack {
                //Image("HDR_LOGO_MAS_Picto")
                Text("Interface")
                    .font(.title3)
                    .fontWeight(.semibold)
            }
            GroupBox {
                HStack {
                    Text("Window size:").frame(width: 150, alignment: .leading)
                    Toggle("Plug", isOn: $plug1).toggleStyle(.switch).controlSize(.mini)
                    Toggle("App", isOn: $app1).toggleStyle(.switch).controlSize(.mini)
                    Image(systemName: "info.circle")
                        .frame(width: 50, alignment: .trailing)
                        .foregroundColor(.blue)
                        .onTapGesture {
                            guard let url = URL(string: "https://github.com/d1One/NIPatcher/blob/main/Help/Maschine.md#window-size") else { return }
                            NSWorkspace.shared.open(url)
                        }
                    
                }
                
                if plug1 || app1 {
                    VStack {
                        Divider().frame(maxWidth: 250)
                    }
                    HStack {
                        Text("Min").frame(maxWidth: 50)
                        Image(systemName: "arrow.up.and.down").frame(width: 25)
                        TextField("", text: $MminHeight).frame(maxWidth: 40)
                        
                    }
                    HStack {
                        Text("Small").frame(maxWidth: 50)
                        Image(systemName: "arrow.left.and.right").frame(width: 25)
                        TextField("", text: $smallWidth).frame(maxWidth: 40)
                        Text("Small").frame(maxWidth: 50)
                        Image(systemName: "arrow.up.and.down").frame(width: 25)
                        TextField("", text: $smallHeight).frame(maxWidth: 40)
                        
                    }
                    HStack {
                        Text("Med").frame(maxWidth: 50)
                        Image(systemName: "arrow.left.and.right").frame(width: 25)
                        TextField("", text: $medWidth).frame(maxWidth: 40)
                        Text("Med").frame(maxWidth: 50)
                        Image(systemName: "arrow.up.and.down").frame(width: 25)
                        TextField("", text: $medHeight).frame(maxWidth: 40)
                    }
                    HStack {
                        Text("Large").frame(maxWidth: 50)
                        Image(systemName: "arrow.left.and.right").frame(width: 25)
                        TextField("", text: $largeWidth).frame(maxWidth: 40)
                        Text("Large").frame(maxWidth: 50)
                        Image(systemName: "arrow.up.and.down").frame(width: 25)
                        TextField("", text: $largeHeight).frame(maxWidth: 40)
                    }
                }
            }
            //               HACK #2 FONT SIZES
            // ----------------------------------------------
            GroupBox {
                HStack {
                    Text("Font size:").frame(width: 150, alignment: .leading)
                    Toggle("Plug", isOn: $plug2).toggleStyle(.switch).controlSize(.mini)
                    Toggle("App", isOn: $app2).toggleStyle(.switch).controlSize(.mini)
                    Image(systemName: "info.circle")
                        .frame(width: 50, alignment: .trailing)
                        .foregroundColor(.blue)
                        .onTapGesture {
                            guard let url = URL(string: "https://github.com/d1One/NIPatcher/blob/main/Help/Maschine.md#font-size") else { return }
                            NSWorkspace.shared.open(url)
                        }
                }
                if plug2 || app2 {
                    VStack {
                        Divider().frame(maxWidth: 150)
                    }
                    HStack {
                        Text("Buttons").frame(width: 60, alignment: .leading)
                        TextField("", text: $fontButton).frame(maxWidth: 40)
                    }
                    HStack {
                        Text("Labels").frame(width: 60, alignment: .leading)
                        TextField("", text: $fontLabel).frame(maxWidth: 40)
                    }
                }
            }
            //    HACK #3 STOP BUTTON ON HW (MK3's, M+ & STUDIO)
            // -----------------------------------------------------
            VStack {
                Text("Hardware")
                    .font(.title3)
                    .fontWeight(.semibold)
            }
            GroupBox {
                HStack {
                    Text("Stop Button").frame(width: 150, alignment: .leading)
                    Text("").frame(width: 60, alignment: .leading)//just to fill empty space
                    Toggle(" App", isOn: $app4).toggleStyle(.switch).controlSize(.mini)
                    Image(systemName: "info.circle")
                        .frame(width: 50, alignment: .trailing)
                        .foregroundColor(.blue)
                        .onTapGesture {
                            guard let url = URL(string: "https://github.com/d1One/NIPatcher/blob/main/Help/Maschine.md#stop-button") else { return }
                            NSWorkspace.shared.open(url)
                        }
                }
            }
            GroupBox {
                HStack {
                    Text("Jam Focus").frame(width: 150, alignment: .leading)
                    Toggle("Plug", isOn: $plug5).toggleStyle(.switch).controlSize(.mini)
                    Toggle(" App", isOn: $app5).toggleStyle(.switch).controlSize(.mini)
                    Image(systemName: "info.circle")
                        .frame(width: 50, alignment: .trailing)
                        .foregroundColor(.blue)
                        .onTapGesture {
                            guard let url = URL(string: "https://github.com/d1One/NIPatcher/blob/main/Help/Maschine.md#jam-focus") else { return }
                            NSWorkspace.shared.open(url)
                        }
                }
            }
            
            //    PATCH Buttons
            // -----------------------------------------------------
            Spacer()//why is this spacer not working?
            Divider().frame(maxWidth: 150)
            HStack {
                Button("Copy") {
                    do {
                        try copyFilesToNIPatcherFolder()
                        createAliasesForFolders()
                    } catch {
                        print("Error - copyFilesToNIPatcherFolder: \(error)")
                    }
                }
                Button("Patch!", action: ApplyPatch)
                // Complicated ass way of showing when codesign is done. Revisit this!
                // ----------------------------------------------------------------------
                Button("Codesign") {
                    showingSheet = true
                    output = ""
                }
                .sheet(isPresented: $showingSheet) {
                    
                    VStack {
                        ScrollView {
                            Text(output)
                                .lineSpacing(2)
                        }
                        Button("Close") {
                            showingSheet = false
                        }
                    }.frame(minWidth: 200, minHeight: 250)
                        .padding(10)
                    .onAppear() {
                        let task = Process()
                        task.launchPath = "/bin/sh"
                        task.arguments = [Bundle.main.path(forResource: "codesign", ofType: "sh")!]
                        
                        let pipe = Pipe()
                        task.standardOutput = pipe
                        
                        pipe.fileHandleForReading.readabilityHandler = { fileHandle in
                            let data = fileHandle.availableData
                            let string = String(data: data, encoding: .utf8) ?? ""
                            DispatchQueue.main.async {
                                output += string
                            }
                        }
                        
                        task.launch()
                    }
                }
            }
            .onAppear {
                NSApplication.shared.windows.last?.contentView?.subviews.last?.subviews.last?.subviews.last?.layer?.backgroundColor = NSColor.clear.cgColor
                
            }
        }
    }
    
    func ApplyPatch() {
        if plug1 || app1 {
            Hack_1(inputAppFiles: inputAppFiles, inputPlugFiles: inputPlugFiles, app1: self.app1, plug1: self.plug1, MminHeight: self.MminHeight, smallWidth: self.smallWidth, smallWidthBrowser: self.smallWidthBrowser, smallHeight: self.smallHeight, medWidth: self.medWidth, medHeight: self.medHeight, largeWidth: self.largeWidth, largeHeight: self.largeHeight)
        }
        if plug2 || app2 {
            // uses same toggles because all are always applied
            Hack_2(app2: self.app2, plug2: self.plug2, fontLabel: self.fontLabel)
            Hack_3(app2: self.app2, plug2: self.plug2, fontButton: self.fontButton)
            Hack_2_3_fix(app2: self.app2, plug2: self.plug2)
        }
        if app4 {
            SC_TransportSection()
        }
        if plug5 || app5 {
            MH_PatternHelper(app5: self.app5, plug5: self.plug5)
        }
        logoReplaceMAS()
//        else {
//            let alert = NSAlert()
//            alert.messageText = "Error! 😢"
//            alert.runModal()
//            print("nothing selected")
//        }
        
    }
    
}


struct MaschineView_Previews: PreviewProvider {
    static var previews: some View {
        MaschineView()
    }
}
