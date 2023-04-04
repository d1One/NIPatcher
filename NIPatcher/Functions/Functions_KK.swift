// Functions_KK.swift

import Cocoa
import AppKit
import Foundation

// -------------------------------------------------------------
//     Copy all KK plugins and app to a folder on the desktop
// -------------------------------------------------------------

func copyFilesToNIPatcherFolder_KK() throws {
    let fileManager = FileManager.default
    let desktopURL = fileManager.urls(for: .desktopDirectory, in: .userDomainMask).first!
    let destinationURL = desktopURL.appendingPathComponent("NIPatcher")
    
    try fileManager.createDirectory(at: destinationURL, withIntermediateDirectories: true, attributes: nil)
    
    let fileURLs = [
        URL(fileURLWithPath: "/Library/Audio/Plug-Ins/VST/Komplete Kontrol.vst"),
        URL(fileURLWithPath: "/Library/Audio/Plug-Ins/VST3/Komplete Kontrol.vst3"),
        URL(fileURLWithPath: "/Library/Audio/Plug-Ins/Components/Komplete Kontrol.component"),
        URL(fileURLWithPath: "/Library/Application Support/Avid/Audio/Plug-Ins/Komplete Kontrol.aaxplugin"),
        URL(fileURLWithPath: "/Applications/Native Instruments/Komplete Kontrol/Komplete Kontrol.app")
    ]
    
    for fileURL in fileURLs {
        let destinationFileURL = destinationURL.appendingPathComponent(fileURL.lastPathComponent)
        do {
            if fileManager.fileExists(atPath: destinationFileURL.path) {
                try fileManager.removeItem(at: destinationFileURL)
            }
            try fileManager.copyItem(at: fileURL, to: destinationFileURL)
        } catch {
            print("Error copying file at \(fileURL.path): \(error.localizedDescription)")
        }
    }
}

// -------------------------------------------------------------
//              Create shortcuts in the desktop.
// -------------------------------------------------------------

func createAliasesForFolders_KK() {
    let fileManager = FileManager.default
    
    let folders = [
        "/Library/Audio/Plug-Ins/VST/",
        "/Library/Audio/Plug-Ins/VST3/",
        "/Library/Audio/Plug-Ins/Components/",
        "/Library/Application Support/Avid/Audio/Plug-Ins/",
        "/Applications/Native Instruments/Komplete Kontrol/"
    ]
    
    let folderNames = [
        "/Library/Audio/Plug-Ins/VST/": "VST",
        "/Library/Audio/Plug-Ins/VST3/": "VST3",
        "/Library/Audio/Plug-Ins/Components/": "AU",
        "/Library/Application Support/Avid/Audio/Plug-Ins/": "AAX",
        "/Applications/Native Instruments/Komplete Kontrol/": "KK App"
    ]
    
    let destinationFolder = URL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent("Desktop/NIPatcher")
    
    do {
        try fileManager.createDirectory(at: destinationFolder, withIntermediateDirectories: true, attributes: nil)
    } catch {
        print("Error creating directory: \(error.localizedDescription)")
    }
    
    for folder in folders {
        let sourceFolder = URL(fileURLWithPath: folder)
        
        if let folderName = folderNames[folder] {
            do {
                try fileManager.createSymbolicLink(at: destinationFolder.appendingPathComponent(folderName), withDestinationURL: sourceFolder)
            } catch {
                print("Error creating alias for \(folder): \(error.localizedDescription)")
            }
        } else {
            print("No folder name found for \(folder)")
        }
    }
}

// -----------------------------------------------------------------
//                  WINDOW HEIGHT SIZE - Hack_1_KK
//                (When KK Opens without instruments)
//     /Contents/Resources/skin/stylesheets/Komplete/KK/KPI.txt
// -----------------------------------------------------------------

let inputAppFiles1_KK = "/Komplete Kontrol.app/Contents/Resources/skin/stylesheets/Komplete/KK/KPI.txt"
let inputPlugFiles1_KK = [
          "/Komplete Kontrol.vst/Contents/Resources/skin/stylesheets/Komplete/KK/KPI.txt",
         "/Komplete Kontrol.vst3/Contents/Resources/skin/stylesheets/Komplete/KK/KPI.txt",
    "/Komplete Kontrol.aaxplugin/Contents/Resources/skin/stylesheets/Komplete/KK/KPI.txt",
    "/Komplete Kontrol.component/Contents/Resources/skin/stylesheets/Komplete/KK/KPI.txt"
]

func Hack_1_KK(KK_app1: Bool, KK_plug1: Bool, defaultHeight: String) {
    
    if KK_app1 {
        let inputFile = basePath + inputAppFiles1_KK
        let outputFile = inputFile
        
        do {
            let input = try String(contentsOfFile: inputFile)
            var lines = input.components(separatedBy: .newlines)
            
            lines[24] = "    default-height:                 \(defaultHeight);"
            
            let output = lines.joined(separator: "\n")
            try output.write(toFile: outputFile, atomically: true, encoding: .utf8)
        }
        
        catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    if KK_plug1 {
        for inputFile in inputPlugFiles1_KK {
            let inputFile = basePath + inputFile
            let outputFile = inputFile
            
            do {
                let input = try String(contentsOfFile: inputFile)
                var lines = input.components(separatedBy: .newlines)
                
                lines[24] = "    font-size:                  \(defaultHeight);"
                
                let output = lines.joined(separator: "\n")
                try output.write(toFile: outputFile, atomically: true, encoding: .utf8)
            }
            catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}

// -----------------------------------------------------------------
//                  WINDOW HEIGHT SIZE - Hack_2_KK
//                  (when there IS Plugin loaded)
//     lines 798 803 - fix the text not fitting
//     Contents/Resources/skin/stylesheets/Komplete/KK/BrowserPanel.txt
// -----------------------------------------------------------------

let inputAppFiles2_KK = "/Komplete Kontrol.app/Contents/Resources/skin/stylesheets/Komplete/KK/BrowserPanel.txt"
let inputPlugFiles2_KK = [
          "/Komplete Kontrol.vst/Contents/Resources/skin/stylesheets/Komplete/KK/BrowserPanel.txt",
         "/Komplete Kontrol.vst3/Contents/Resources/skin/stylesheets/Komplete/KK/BrowserPanel.txt",
    "/Komplete Kontrol.aaxplugin/Contents/Resources/skin/stylesheets/Komplete/KK/BrowserPanel.txt",
    "/Komplete Kontrol.component/Contents/Resources/skin/stylesheets/Komplete/KK/BrowserPanel.txt"
]

func Hack_2_KK(KK_app1: Bool, KK_plug1: Bool, minHeight: String) {
    
    if KK_app1 {
        let inputFile = basePath + inputAppFiles2_KK
        let outputFile = inputFile
        
        do {
            let input = try String(contentsOfFile: inputFile)
            var lines = input.components(separatedBy: .newlines)
            
            lines[8] = "    min-height:                                 \(minHeight);"
            
            let output = lines.joined(separator: "\n")
            try output.write(toFile: outputFile, atomically: true, encoding: .utf8)
        }
        
        catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    if KK_plug1 {
        for inputFile in inputPlugFiles2_KK {
            let inputFile = basePath + inputFile
            let outputFile = inputFile
            
            do {
                let input = try String(contentsOfFile: inputFile)
                var lines = input.components(separatedBy: .newlines)
                
                lines[8] = "    min-height:                                 \(minHeight);"
                
//                lines[797] = "    width:                                      79;"
//                lines[802] = "    width:                                     120;"
                
                let output = lines.joined(separator: "\n")
                try output.write(toFile: outputFile, atomically: true, encoding: .utf8)
            }
            catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}

// -----------------------------------------------------------------
//                     FONT SIZE Buttons - Hack_3_KK
//                  ()
//     Contents/Resources/skin/stylesheets/Komplete/Global/Buttons.txt
// -----------------------------------------------------------------

let inputAppFiles3_KK = "/Komplete Kontrol.app/Contents/Resources/skin/stylesheets/Komplete/Global/Buttons.txt"
let inputPlugFiles3_KK = [
          "/Komplete Kontrol.vst/Contents/Resources/skin/stylesheets/Komplete/Global/Buttons.txt",
         "/Komplete Kontrol.vst3/Contents/Resources/skin/stylesheets/Komplete/Global/Buttons.txt",
    "/Komplete Kontrol.aaxplugin/Contents/Resources/skin/stylesheets/Komplete/Global/Buttons.txt",
    "/Komplete Kontrol.component/Contents/Resources/skin/stylesheets/Komplete/Global/Buttons.txt"
]

func Hack_3_KK(KK_app3: Bool, KK_plug3: Bool, fontButtons: String) {
    
    if KK_app3 {
        let inputFile = basePath + inputAppFiles3_KK
        let outputFile = inputFile
        
        do {
            let input = try String(contentsOfFile: inputFile)
            var lines = input.components(separatedBy: .newlines)
            
            lines[21] = "    font-size:                          \(fontButtons);"
            
            let output = lines.joined(separator: "\n")
            try output.write(toFile: outputFile, atomically: true, encoding: .utf8)
        }
        
        catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    if KK_plug3 {
        for inputFile in inputPlugFiles3_KK {
            let inputFile = basePath + inputFile
            let outputFile = inputFile
            
            do {
                let input = try String(contentsOfFile: inputFile)
                var lines = input.components(separatedBy: .newlines)
                
                lines[21] = "    font-size:                          \(fontButtons);"
                
                let output = lines.joined(separator: "\n")
                try output.write(toFile: outputFile, atomically: true, encoding: .utf8)
            }
            catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}

// -----------------------------------------------------------------
//                     FONT SIZE Buttons - Hack_4_KK
//                  ()
//  /Contents/Resources/skin/stylesheets/Komplete/Development/Dev_Labels.txt
// -----------------------------------------------------------------

let inputAppFiles4_KK = "/Komplete Kontrol.app/Contents/Resources/skin/stylesheets/Komplete/Development/Dev_Labels.txt"
let inputPlugFiles4_KK = [
          "/Komplete Kontrol.vst/Contents/Resources/skin/stylesheets/Komplete/Development/Dev_Labels.txt",
         "/Komplete Kontrol.vst3/Contents/Resources/skin/stylesheets/Komplete/Development/Dev_Labels.txt",
    "/Komplete Kontrol.aaxplugin/Contents/Resources/skin/stylesheets/Komplete/Development/Dev_Labels.txt",
    "/Komplete Kontrol.component/Contents/Resources/skin/stylesheets/Komplete/Development/Dev_Labels.txt"
]

func Hack_4_KK(KK_app3: Bool, KK_plug3: Bool, fontDevLabels: String) {
    
    if KK_app3 {
        let inputFile = basePath + inputAppFiles4_KK
        let outputFile = inputFile
        
        do {
            let input = try String(contentsOfFile: inputFile)
            var lines = input.components(separatedBy: .newlines)
            
            lines[9] = "    font-size:                  \(fontDevLabels);"
            
            let output = lines.joined(separator: "\n")
            try output.write(toFile: outputFile, atomically: true, encoding: .utf8)
        }
        
        catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    if KK_plug3 {
        for inputFile in inputPlugFiles4_KK {
            let inputFile = basePath + inputFile
            let outputFile = inputFile
            
            do {
                let input = try String(contentsOfFile: inputFile)
                var lines = input.components(separatedBy: .newlines)
                
                lines[9] = "    font-size:                  \(fontDevLabels);"
                
                let output = lines.joined(separator: "\n")
                try output.write(toFile: outputFile, atomically: true, encoding: .utf8)
            }
            catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}

// -----------------------------------------------------------------
//                   FIX needed after Hacks 2 and 3
//
// lines 798 803 of the og, paths constants not needed, reusing the ones from Hack2. Fix wrapper of "Types" "Character" tittle tags
//
//     Contents/Resources/skin/stylesheets/Komplete/KK/BrowserPanel.txt
// -----------------------------------------------------------------

func FontFixKK1(KK_app3: Bool, KK_plug3: Bool) {
    
    if KK_app3 {
        let inputFile = basePath + inputAppFiles2_KK
        let outputFile = inputFile
        
        do {
            let input = try String(contentsOfFile: inputFile)
            var lines = input.components(separatedBy: .newlines)
            
            lines[797] = "    width:                                      79;"
            lines[802] = "    width:                                     120;"
            
            let output = lines.joined(separator: "\n")
            try output.write(toFile: outputFile, atomically: true, encoding: .utf8)
        }
        
        catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    if KK_plug3 {
        for inputFile in inputPlugFiles2_KK {
            let inputFile = basePath + inputFile
            let outputFile = inputFile
            
            do {
                let input = try String(contentsOfFile: inputFile)
                var lines = input.components(separatedBy: .newlines)
                
                lines[797] = "    width:                                      79;"
                lines[802] = "    width:                                     120;"
                
                let output = lines.joined(separator: "\n")
                try output.write(toFile: outputFile, atomically: true, encoding: .utf8)
            }
            catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}



// -----------------------------------------------------------------
//                   FIX needed after Hacks 2 and 3
//
// lines 72 79 170 176 327 - Fixes button sizes for Scale, Arp & MIDI Learn
//
//     /Contents/Resources/skin/stylesheets/Komplete/KK/ParameterArea.txt
// -----------------------------------------------------------------

let inputAppFix2_KK = "/Komplete Kontrol.app/Contents/Resources/skin/stylesheets/Komplete/KK/ParameterArea.txt"
let inputPlugFix2_KK = [
          "/Komplete Kontrol.vst/Contents/Resources/skin/stylesheets/Komplete/KK/ParameterArea.txt",
         "/Komplete Kontrol.vst3/Contents/Resources/skin/stylesheets/Komplete/KK/ParameterArea.txt",
    "/Komplete Kontrol.aaxplugin/Contents/Resources/skin/stylesheets/Komplete/KK/ParameterArea.txt",
    "/Komplete Kontrol.component/Contents/Resources/skin/stylesheets/Komplete/KK/ParameterArea.txt"
]

func FontFixKK2(KK_app3: Bool, KK_plug3: Bool) {
    
    if KK_app3 {
        let inputFile = basePath + inputAppFix2_KK
        let outputFile = inputFile
        
        do {
            let input = try String(contentsOfFile: inputFile)
            var lines = input.components(separatedBy: .newlines)
            
            lines[71] = "    width:                      89;"
            lines[78] = "    width:                      76;"
            lines[169] = "    width:                      55;"
            lines[175] = "    width:                      42;"
            lines[326] = "    width:                     102;"
            
            let output = lines.joined(separator: "\n")
            try output.write(toFile: outputFile, atomically: true, encoding: .utf8)
        }
        
        catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    if KK_plug3 {
        for inputFile in inputPlugFix2_KK {
            let inputFile = basePath + inputFile
            let outputFile = inputFile
            
            do {
                let input = try String(contentsOfFile: inputFile)
                var lines = input.components(separatedBy: .newlines)
                
                lines[71] = "    width:                      89;"
                lines[78] = "    width:                      76;"
                lines[169] = "    width:                      55;"
                lines[175] = "    width:                      42;"
                lines[326] = "    width:                     102;"
                
                let output = lines.joined(separator: "\n")
                try output.write(toFile: outputFile, atomically: true, encoding: .utf8)
            }
            catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}


// -----------------------------------------------------------------
//                  WIDER BROWSER - Hack_5_KK
//
// /   Resources/skin/stylesheets/Komplete/Definitions/Metrics.txt
//
// -----------------------------------------------------------------

let inputAppFiles5_KK = "/Komplete Kontrol.app/Contents/Resources/skin/stylesheets/Komplete/Definitions/Metrics.txt"
let inputPlugFiles5_KK = [
          "/Komplete Kontrol.vst/Contents/Resources/skin/stylesheets/Komplete/Definitions/Metrics.txt",
         "/Komplete Kontrol.vst3/Contents/Resources/skin/stylesheets/Komplete/Definitions/Metrics.txt",
    "/Komplete Kontrol.aaxplugin/Contents/Resources/skin/stylesheets/Komplete/Definitions/Metrics.txt",
    "/Komplete Kontrol.component/Contents/Resources/skin/stylesheets/Komplete/Definitions/Metrics.txt"
]

func Hack_5_KK(KK_app5: Bool, KK_plug5: Bool) {
    
    if KK_app5 {
        let inputFile = basePath + inputAppFiles5_KK
        let outputFile = inputFile
        
        do {
            let input = try String(contentsOfFile: inputFile)
            var lines = input.components(separatedBy: .newlines)
            
            lines[5] = "@define $browserMainWidth       430;"
            
            let output = lines.joined(separator: "\n")
            try output.write(toFile: outputFile, atomically: true, encoding: .utf8)
        }
        
        catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    if KK_plug5 {
        for inputFile in inputPlugFiles5_KK {
            let inputFile = basePath + inputFile
            let outputFile = inputFile
            
            do {
                let input = try String(contentsOfFile: inputFile)
                var lines = input.components(separatedBy: .newlines)
                
                lines[5] = "@define $browserMainWidth       430;"
                
                let output = lines.joined(separator: "\n")
                try output.write(toFile: outputFile, atomically: true, encoding: .utf8)
            }
            catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}

// -----------------------------------------------------------------
//                  WIDER BROWSER - Hack_5_KK_fix
// -----------------------------------------------------------------
//        Multiple fixes needed when changing the browser width
// /Contents/Resources/skin/stylesheets/Komplete/KK/BrowserPanel.txt
// -----------------------------------------------------------------
// Reusing path constants of HACK 2 since it's the same .txt file
// inputAppFiles2_KK and inputPlugFiles2_KK


func WideBrowserKK_fix(KK_app5: Bool, KK_plug5: Bool) {
    
    if KK_app5 {
        let inputFile = basePath + inputAppFiles2_KK
        let outputFile = inputFile
        
        do {
            let input = try String(contentsOfFile: inputFile)
            var lines = input.components(separatedBy: .newlines)
            
            lines[40] = "    width:                                      430;"
            lines[53] = "   width:                                      430;"
            lines[185] = "   width:                                       311;"
            lines[532] = "    width:                                      430;"
            lines[594] = "   width:                                      414;"
            lines[605] = "    width:                                      416;"
            lines[1124] = "    width:                                      370;"//can crash, add a delay?

            let output = lines.joined(separator: "\n")
            try output.write(toFile: outputFile, atomically: true, encoding: .utf8)
        }
        
        catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    if KK_plug5 {
        for inputFile in inputPlugFiles2_KK {
            let inputFile = basePath + inputFile
            let outputFile = inputFile
            
            do {
                let input = try String(contentsOfFile: inputFile)
                var lines = input.components(separatedBy: .newlines)
                
                lines[40] = "    width:                                      430;"
                lines[53] = "   width:                                      430;"
                lines[185] = "   width:                                       311;"
                lines[532] = "    width:                                      430;"
                lines[594] = "   width:                                      414;"
                lines[605] = "    width:                                      416;"
                lines[1124] = "    width:                                      370;"
                
                let output = lines.joined(separator: "\n")
                try output.write(toFile: outputFile, atomically: true, encoding: .utf8)
            }
            catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
