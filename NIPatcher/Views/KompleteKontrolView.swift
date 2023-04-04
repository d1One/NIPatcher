// KompleteKontrolView.swift

import SwiftUI

struct KompleteKontrolView: View {
    
    @State private var toggleKKPlug1 = false
    @State private var KK_app1 = false
    @State private var KK_plug3 = false
    @State private var KK_app3 = false
    //where is 4 ?? reorganize all the naming or it gets confusing
    @State private var KK_app5 = false
    @State private var KK_plug5 = false
    
    // WINDOW SIZE - BrowserPanel.txt KPI.txt
    @State private var minHeight: String = "535"
    @State private var defaultHeight: String = "381"
    
    // FONTS - Buttons.txt Dev_Labels.txt
    @State private var fontButtons: String = "11"
    @State private var fontDevLabels: String = "11"
    
    // Variables for the Codesign Button
    @State private var output = ""
    @State private var showingSheet = false
    
    var body: some View {
        VStack {
            Text("Interface GUI")
                .font(.title3)
                .fontWeight(.semibold)
            // ------------  WINDOW SIZE  ------------
            GroupBox {
                HStack {
                    Text("Window size:")
                    Spacer()
                    Toggle("Plug", isOn: $toggleKKPlug1).toggleStyle(.switch).controlSize(.mini)
                    Toggle("App", isOn: $KK_app1).toggleStyle(.switch).controlSize(.mini)
                    Image(systemName: "info.circle").frame(width: 40, alignment: .trailing)
                        .frame(width: 50, alignment: .trailing)
                        .foregroundColor(.blue)
                        .onTapGesture {
                            guard let url = URL(string: "https://github.com/d1One/NIPatcher/blob/main/Help/KompleteKontrol.md#window-size") else { return }
                            NSWorkspace.shared.open(url)
                        }
                }
                
                if toggleKKPlug1 || KK_app1 {
                    VStack {
                        Divider().frame(maxWidth: 200)
                    }
                    HStack {
                        Text("With Plugin").frame(maxWidth: 110, alignment: .leading)
                        Image(systemName: "arrow.up.and.down")
                        TextField("", text: $minHeight).frame(maxWidth: 40)
                        Spacer()
                    }
                    HStack {
                        Text("Without Plugin").frame(maxWidth: 110, alignment: .leading)
                        Image(systemName: "arrow.up.and.down")
                        TextField("", text: $defaultHeight).frame(maxWidth: 40)
                        Spacer()
                    }
                }
            }.frame(width: 400) // Fixed width GroupBox
            
            // ------------  FONT SIZE  ------------
            GroupBox {
                HStack {
                    Text("Fonts:")
                    Spacer()
                    Toggle("Plug", isOn: $KK_plug3).toggleStyle(.switch).controlSize(.mini)
                    Toggle("App", isOn: $KK_app3).toggleStyle(.switch).controlSize(.mini)
                    Image(systemName: "info.circle").frame(width: 40, alignment: .trailing)
                        .frame(width: 50, alignment: .trailing)
                        .foregroundColor(.blue)
                        .onTapGesture {
                            guard let url = URL(string: "https://github.com/d1One/NIPatcher/blob/main/Help/KompleteKontrol.md#fonts") else { return }
                            NSWorkspace.shared.open(url)
                        }
                }
                
                if KK_plug3 || KK_app3 {
                    VStack {
                        Divider().frame(maxWidth: 150)
                    }
                    HStack {
                        Text("Buttons").frame(maxWidth: 80, alignment: .leading)
                        TextField("", text: $fontButtons).frame(maxWidth: 40)
                        Spacer()
                    }
                    HStack {
                        Text("Labels").frame(maxWidth: 80, alignment: .leading)
                        TextField("", text: $fontDevLabels).frame(maxWidth: 40)
                        Spacer()
                    }
                }
            }.frame(width: 400) // Fixed width GroupBox
            GroupBox {
                HStack {
                    Text("Wide Browser:")
                    Spacer()
                    Toggle("Plug", isOn: $KK_plug5).toggleStyle(.switch).controlSize(.mini)
                    Toggle("App", isOn: $KK_app5).toggleStyle(.switch).controlSize(.mini)
                    Image(systemName: "info.circle").frame(width: 40, alignment: .trailing)
                        .frame(width: 50, alignment: .trailing)
                        .foregroundColor(.blue)
                        .onTapGesture {
                            guard let url = URL(string: "https://github.com/d1One/NIPatcher/blob/main/Help/KompleteKontrol.md#wide-browser") else { return }
                            NSWorkspace.shared.open(url)
                        }
                }
            }.frame(width: 400) // Fixed width GroupBox
            
            
            // ------------  BUTTONS  ------------
            Spacer()
            Divider()
            HStack {
                Button("Copy") {
                    do {
                        try copyFilesToNIPatcherFolder_KK()
                        createAliasesForFolders_KK()
                    } catch {
                        print("Error - copyFilesToNIPatcherFolder_KK: \(error)")
                    }
                }
                Button("Patch!", action: ApplyPatch)
                // ------------  Codesign  ------------
                // ----  Fix or make this simpler  ----
                // ------------------------------------
                Button("Codesign") {
                    showingSheet = true
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
                        task.arguments = [Bundle.main.path(forResource: "codesignkk", ofType: "sh")!]
                        
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
        if toggleKKPlug1 || KK_app1 {
            Hack_1_KK(KK_app1: self.KK_app1, KK_plug1: self.toggleKKPlug1, defaultHeight: self.defaultHeight)
            Hack_2_KK(KK_app1: self.KK_app1, KK_plug1: self.toggleKKPlug1, minHeight: self.minHeight)
        }
        if KK_plug3 || KK_app3 {
            Hack_3_KK(KK_app3: self.KK_app3, KK_plug3: self.KK_plug3, fontButtons: self.fontButtons)
            Hack_4_KK(KK_app3: self.KK_app3, KK_plug3: self.KK_plug3, fontDevLabels: self.fontDevLabels)
            FontFixKK1(KK_app3: self.KK_app3, KK_plug3: self.KK_plug3)
            FontFixKK2(KK_app3: self.KK_app3, KK_plug3: self.KK_plug3)
        }
        if KK_plug5 || KK_app5 {
            WideBrowserKK_fix(KK_app5: self.KK_app5, KK_plug5: self.KK_plug5)
            Hack_5_KK(KK_app5: self.KK_app5, KK_plug5: self.KK_plug5)
            
        }
        logoReplaceKK()
    }
}

struct KompleteKontrolView_Previews: PreviewProvider {
    static var previews: some View {
        KompleteKontrolView()
    }
}
