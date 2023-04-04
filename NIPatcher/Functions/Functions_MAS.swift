// Eventually Function names should match filepath somehow?
// in case more hacks relate to the same file in the future,
// only applies to hacks that change the line count of the og file.

import Foundation

// -----------------------------------------------------------------------
//                     Logo replace (2 files)
// extended attributes have to be removed from pngs for it to work xattr -rc .
// -----------------------------------------------------------------------

func logoReplaceMAS() {
    let fileManager = FileManager.default
    
    // Get the URLs for the images in the project folder
    guard let mainImageURL = Bundle.main.url(forResource: "HDR_LOGO_MAS_Main", withExtension: "png"),
          let pictoImageURL = Bundle.main.url(forResource: "HDR_LOGO_MAS_Picto", withExtension: "png") else {
        print("Error: Failed to get image URLs")
        return
    }
    
    // Get the URL for the NIPatcher folder on the desktop
    guard let desktopURL = fileManager.urls(for: .desktopDirectory, in: .userDomainMask).first else {
        print("Error: Failed to get desktop URL")
        return
    }
    let nipatcherURL = desktopURL.appendingPathComponent("NIPatcher")
    
    // Define the destination paths for the images
    let destinationPaths = [
        "/Maschine 2.app/Contents/Resources/skin/pictures/Maschine/Header/",
        "/Maschine 2.vst/Contents/Resources/skin/pictures/Maschine/Header/",
        "/Maschine 2.vst3/Contents/Resources/skin/pictures/Maschine/Header/",
        "/Maschine 2.aaxplugin/Contents/Resources/skin/pictures/Maschine/Header/",
        "/Maschine 2.component/Contents/Resources/skin/pictures/Maschine/Header/"
    ]
    
    // Copy the images to their destination
    for path in destinationPaths {
        let mainDestinationURL = nipatcherURL.appendingPathComponent(path + "HDR_LOGO_MAS_Main.png")
        let pictoDestinationURL = nipatcherURL.appendingPathComponent(path + "HDR_LOGO_MAS_Picto.png")
        
        do {
            if fileManager.fileExists(atPath: mainDestinationURL.path) {
                try fileManager.removeItem(at: mainDestinationURL)
                try fileManager.copyItem(at: mainImageURL, to: mainDestinationURL)
            }
            
            if fileManager.fileExists(atPath: pictoDestinationURL.path) {
                try fileManager.removeItem(at: pictoDestinationURL)
                try fileManager.copyItem(at: pictoImageURL, to: pictoDestinationURL)
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
 // /Contents/Resources/skin/pictures/Komplete/KK/Header

// -------------------------------------------------------------
//     Copy all plugins and app to a folder on the desktop
// -------------------------------------------------------------

func copyFilesToNIPatcherFolder() throws {
    let fileManager = FileManager.default
    let desktopURL = fileManager.urls(for: .desktopDirectory, in: .userDomainMask).first!
    let destinationURL = desktopURL.appendingPathComponent("NIPatcher")
    
    try fileManager.createDirectory(at: destinationURL, withIntermediateDirectories: true, attributes: nil)
    
    let fileURLs = [
        URL(fileURLWithPath: "/Library/Audio/Plug-Ins/VST/Maschine 2.vst"),
        URL(fileURLWithPath: "/Library/Audio/Plug-Ins/VST3/Maschine 2.vst3"),
        URL(fileURLWithPath: "/Library/Audio/Plug-Ins/Components/Maschine 2.component"),
        URL(fileURLWithPath: "/Library/Application Support/Avid/Audio/Plug-Ins/Maschine 2.aaxplugin"),
        URL(fileURLWithPath: "/Applications/Native Instruments/Maschine 2/Maschine 2.app")
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

func createAliasesForFolders() {
    let fileManager = FileManager.default
    
    let folders = [
        "/Library/Audio/Plug-Ins/VST/",
        "/Library/Audio/Plug-Ins/VST3/",
        "/Library/Audio/Plug-Ins/Components/",
        "/Library/Application Support/Avid/Audio/Plug-Ins/",
        "/Applications/Native Instruments/Maschine 2/"
    ]
    
    let folderNames = [
        "/Library/Audio/Plug-Ins/VST/": "VST",
        "/Library/Audio/Plug-Ins/VST3/": "VST3",
        "/Library/Audio/Plug-Ins/Components/": "AU",
        "/Library/Application Support/Avid/Audio/Plug-Ins/": "AAX",
        "/Applications/Native Instruments/Maschine 2/": "MAS App"
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

// ---------------------------------------------------------------------
//               HACK #1 - Plugin sizes - Panels_TopLevel
//
//            /skin/stylesheets/Maschine/Panels/TopLevel.txt
// ---------------------------------------------------------------------
// For now I use the smallWidth for smallWidthBrowser - revist later

// Grab the desktop path ?? MOVE THIS TO GLOBAL FUNCTIONS FILE?
let fileManager = FileManager.default
let desktopURL = try! fileManager.url(for: .desktopDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
let nipatcherURL = desktopURL.appendingPathComponent("NIPatcher")
let basePath = nipatcherURL.path


let inputAppFiles = "/Maschine 2.app/Contents/Resources/skin/stylesheets/Maschine/Panels/TopLevel.txt"
let inputPlugFiles = [
    "/Maschine 2.vst/Contents/Resources/skin/stylesheets/Maschine/Panels/TopLevel.txt",
    "/Maschine 2.vst3/Contents/Resources/skin/stylesheets/Maschine/Panels/TopLevel.txt",
    "/Maschine 2.aaxplugin/Contents/Resources/skin/stylesheets/Maschine/Panels/TopLevel.txt",
    "/Maschine 2.component/Contents/Resources/skin/stylesheets/Maschine/Panels/TopLevel.txt"
]

func Hack_1(inputAppFiles: String, inputPlugFiles: [String], app1: Bool, plug1: Bool, MminHeight: String, smallWidth: String, smallWidthBrowser: String, smallHeight: String, medWidth: String, medHeight: String, largeWidth: String, largeHeight: String) {
    
    if app1 {
        let inputFile = basePath + inputAppFiles
        let outputFile = inputFile
        
        do {
            // Read the input file into an array of lines
            let input = try String(contentsOfFile: inputFile)
            var lines = input.components(separatedBy: .newlines)
            
            // Create an array of new lines to insert
            let newLines = [
                "    min-height:                         \(MminHeight);",
                "",
                "    window-small-width:                 \(smallWidth);",
                "",
                "    window-small-width-browser:         \(smallWidth);",
                "    window-small-height:                \(smallHeight);",
                "",
                "    window-medium-width:                \(medWidth);",
                "    window-medium-height:               \(medHeight);",
                "",
                "    window-large-width:                 \(largeWidth);",
                "    window-large-height:                \(largeHeight);"
            ]
            
            // Replace the lines in the specified range with the new lines
            lines.replaceSubrange(20..<32, with: newLines)
            
            // Write the modified array of lines to the output file
            let output = lines.joined(separator: "\n")
            try output.write(toFile: outputFile, atomically: true, encoding: .utf8)
            
            // Print the output file path - Remove later
            print("Hack #1 Applied: \(outputFile)")
        }
        catch {
            print("Error in Hack #1: \(error.localizedDescription)")
        }
    }
    
    if plug1 {
        for inputFile in inputPlugFiles {
            let inputFile = basePath + inputFile
            let outputFile = inputFile
            
            do {
                // Read the input file into an array of lines
                let input = try String(contentsOfFile: inputFile)
                var lines = input.components(separatedBy: .newlines)
                
                // Create an array of new lines to insert
                let newLines = [
                    "    min-height:                         \(MminHeight);",
                    "",
                    "    window-small-width:                 \(smallWidth);",
                    "",
                    "    window-small-width-browser:         \(smallWidthBrowser);",
                    "    window-small-height:                \(smallHeight);",
                    "",
                    "    window-medium-width:                \(medWidth);",
                    "    window-medium-height:               \(medHeight);",
                    "",
                    "    window-large-width:                 \(largeWidth);",
                    "    window-large-height:                \(largeHeight);"
                ]
                
                // Replace the lines in the specified range with the new lines
                lines.replaceSubrange(20..<32, with: newLines)
                
                // Write the modified array of lines to the output file
                let output = lines.joined(separator: "\n")
                try output.write(toFile: outputFile, atomically: true, encoding: .utf8)
                
                // Print the output file path - Remove later
                print("Hack 1 Applied: \(outputFile)")
            }
            catch {
                print("Error in Panels_TopLevel: \(error.localizedDescription)")
            }
        }
    }
}


// -----------------------------------------------------------------
//                    HACK 2 - Font size #1 Labels
//           /skin/stylesheets/Maschine/Standard/Labels.txt
//
// Hack 2 and 3 are always both applied regardless, for simplicity.
// -----------------------------------------------------------------

let inputAppFiles2 = "/Maschine 2.app/Contents/Resources/skin/stylesheets/Maschine/Standard/Labels.txt"

let inputPlugFiles2 = [
    "/Maschine 2.vst/Contents/Resources/skin/stylesheets/Maschine/Standard/Labels.txt",
    "/Maschine 2.vst3/Contents/Resources/skin/stylesheets/Maschine/Standard/Labels.txt",
    "/Maschine 2.aaxplugin/Contents/Resources/skin/stylesheets/Maschine/Standard/Labels.txt",
    "/Maschine 2.component/Contents/Resources/skin/stylesheets/Maschine/Standard/Labels.txt"
]

func Hack_2(app2: Bool, plug2: Bool, fontLabel: String) {
    
    if app2 {
        let inputFile = basePath + inputAppFiles2
        let outputFile = inputFile
        
        do {
            let input = try String(contentsOfFile: inputFile)
            var lines = input.components(separatedBy: .newlines)
            
            lines[11] = "    font-size:                  \(fontLabel);"
            
            let output = lines.joined(separator: "\n")
            try output.write(toFile: outputFile, atomically: true, encoding: .utf8)
        }
        
        catch {
            print("Error in Hack #2: \(error.localizedDescription)")
        }
    }
    
    if plug2 {
        for inputFile in inputPlugFiles2 {
            let inputFile = basePath + inputFile
            let outputFile = inputFile
            
            do {
                let input = try String(contentsOfFile: inputFile)
                var lines = input.components(separatedBy: .newlines)
                
                lines[11] = "    font-size:                  \(fontLabel);"
                
                let output = lines.joined(separator: "\n")
                try output.write(toFile: outputFile, atomically: true, encoding: .utf8)
            }
            catch {
                print("Error in Hack #2: \(error.localizedDescription)")
            }
        }
    }
}

// ------------------------------------------------------------
//                HACK 3 - Font size #2 Buttons
//      /skin/stylesheets/Maschine/Standard/Buttons.txt
// ------------------------------------------------------------

let inputAppFiles3 = "/Maschine 2.app/Contents/Resources/skin/stylesheets/Maschine/Standard/Buttons.txt"
let inputPlugFiles3 = [
    "/Maschine 2.vst/Contents/Resources/skin/stylesheets/Maschine/Standard/Buttons.txt",
    "/Maschine 2.vst3/Contents/Resources/skin/stylesheets/Maschine/Standard/Buttons.txt",
    "/Maschine 2.aaxplugin/Contents/Resources/skin/stylesheets/Maschine/Standard/Buttons.txt",
    "/Maschine 2.component/Contents/Resources/skin/stylesheets/Maschine/Standard/Buttons.txt"
]

func Hack_3(app2: Bool, plug2: Bool, fontButton: String) {
    
    if app2 {
        
        let inputFile = basePath + inputAppFiles3
        let outputFile = inputFile
        
        do {
            let input = try String(contentsOfFile: inputFile)
            var lines = input.components(separatedBy: .newlines)
            lines.remove(at: 21)
            lines.insert("    font-size:                          \(fontButton);", at: 21)
            
            let output = lines.joined(separator: "\n")
            try output.write(toFile: outputFile, atomically: true, encoding: .utf8)
            
            print("Hack #3 Applied: \(outputFile)")
        }
        catch {
            print("Error in Hack #3: \(error.localizedDescription)")
        }
    }
    if plug2 {
        for inputFile in inputPlugFiles3 {
            let inputFile = basePath + inputFile
            let outputFile = inputFile
            
            do {
                let input = try String(contentsOfFile: inputFile)
                var lines = input.components(separatedBy: .newlines)
                lines.remove(at: 21)
                lines.insert("    font-size:                          \(fontButton);", at: 21)
                
                let output = lines.joined(separator: "\n")
                try output.write(toFile: outputFile, atomically: true, encoding: .utf8)
                
                print("Hack 3 Applied: \(outputFile)")
            }
            catch {
                print("Error in Hack #3: \(error.localizedDescription)")
            }
        }
        
    }
}

// -------------------------------------------------------------------------
//                             HACK 2 / HACK 3 fix
//   Also need to edit BrowserPanel.txt or "character/type" text wont fit
//            /skin/stylesheets/Maschine/Panels/BrowserPanel.txt
// -------------------------------------------------------------------------

let inputAppFiles2_BrowserPanel = "/Maschine 2.app/Contents/Resources/skin/stylesheets/Maschine/Panels/BrowserPanel.txt"

let inputPlugFiles2_BrowserPanel = [
    "/Maschine 2.vst/Contents/Resources/skin/stylesheets/Maschine/Panels/BrowserPanel.txt",
    "/Maschine 2.vst3/Contents/Resources/skin/stylesheets/Maschine/Panels/BrowserPanel.txt",
    "/Maschine 2.aaxplugin/Contents/Resources/skin/stylesheets/Maschine/Panels/BrowserPanel.txt",
    "/Maschine 2.component/Contents/Resources/skin/stylesheets/Maschine/Panels/BrowserPanel.txt"
]

func Hack_2_3_fix(app2: Bool, plug2: Bool) {
    
    if app2 {
        let inputFile = basePath + inputAppFiles2_BrowserPanel
        let outputFile = inputFile
        
        do {
            let input = try String(contentsOfFile: inputFile)
            var lines = input.components(separatedBy: .newlines)
            
            lines.remove(at: 879)
            lines.insert("    width:                                      80;", at: 879)
            lines.remove(at: 884)
            lines.insert("    width:                                     150;", at: 884)
            
            let output = lines.joined(separator: "\n")
            try output.write(toFile: outputFile, atomically: true, encoding: .utf8)
        }
        
        catch {
            print("Error in Hack #2: \(error.localizedDescription)")
        }
    }
    
    if plug2 {
        for inputFile in inputPlugFiles2_BrowserPanel {
            let inputFile = basePath + inputFile
            let outputFile = inputFile
            
            do {
                let input = try String(contentsOfFile: inputFile)
                var lines = input.components(separatedBy: .newlines)
                
                lines.remove(at: 879)
                lines.insert("    width:                                      80;", at: 879)
                lines.remove(at: 884)
                lines.insert("    width:                                     150;", at: 884)
                
                let output = lines.joined(separator: "\n")
                try output.write(toFile: outputFile, atomically: true, encoding: .utf8)
            }
            catch {
                print("Error in Hack #2: \(error.localizedDescription)")
            }
        }
    }
}


// ------------------------------------------------------------
//               HACK 4 - Stop Button --- APP ONLY!
//                      TransportSection.lua
//         /Scripts/Shared/Components/TransportSection.lua
// ------------------------------------------------------------

let inputAppFiles4 = "/Maschine 2.app/Contents/Resources/Scripts/Shared/Components/TransportSection.lua"

func SC_TransportSection() {
    let inputFile = basePath + inputAppFiles4
    let outputFile = inputFile
    
    do {
        var lines = try String(contentsOfFile: inputFile).components(separatedBy: .newlines)
        
        lines.replaceSubrange(106..<113, with: [
            "    function TransportSection:onStop(Pressed)",
            "",
            "       if Pressed and MaschineHelper.isPlaying() then",
            "          NI.DATA.TransportAccess.togglePlay(App)",
            "       else",
            "          if Pressed and not MaschineHelper.isPlaying() then",
            "             NI.DATA.TransportAccess.restartTransport(App)",
            "             NI.DATA.TransportAccess.togglePlay(App)",
            "          end",
            "",
            "       end",
            "",
            "    end",
        ])
        
        try lines.joined(separator: "\n").write(toFile: outputFile, atomically: true, encoding: .utf8)
        
        print("Hack #4 Applied: \(outputFile)")
    } catch {
        print("Error in Hack #4: \(error.localizedDescription)")
    }
}

// ------------------------------------------------------------
//                HACK 5 - Font size #2 Buttons
//        /Scripts/Maschine/Helper/PatternHelper.lua
// ------------------------------------------------------------
// https://community.native-instruments.com/discussion/5072/tip-changing-patterns-on-the-maschine-jam-without-changing-focus

let inputAppFiles5 = "/Maschine 2.app/Contents/Resources/Scripts/Maschine/Helper/PatternHelper.lua"
let inputPlugFiles5 = [
     "/Maschine 2.vst/Contents/Resources/Scripts/Maschine/Helper/PatternHelper.lua",
    "/Maschine 2.vst3/Contents/Resources/Scripts/Maschine/Helper/PatternHelper.lua",
        "/Maschine 2.aaxplugin/Resources/Scripts/Maschine/Helper/PatternHelper.lua",
        "/Maschine 2.component/Resources/Scripts/Maschine/Helper/PatternHelper.lua"
]

func MH_PatternHelper(app5: Bool, plug5: Bool) {
    
    if app5 {
        let inputFile = basePath + inputAppFiles5
        let outputFile = inputFile
        
        do {
            let input = try String(contentsOfFile: inputFile)
            var lines = input.components(separatedBy: .newlines)
            
            let newLines = [
                "function PatternHelper.focusPatternByGroupAndByIndex(GroupIndex, PatternIndex, CreateIfEmpty)",
                "",
                "    if PatternIndex == nil or PatternIndex < 0 or GroupIndex == nil or GroupIndex < 0 then",
                "        return",
                "    end",
                "",
                "    local FocusGroup = NI.DATA.StateHelper.getFocusGroupIndex(App)",
                "    local Group = MaschineHelper.getGroupAtIndex(GroupIndex)",
                "",
                "    if Group then",
                "        local Pattern = Group:getPatterns():find(PatternIndex)",
                "",
                "        if Pattern then",
                "            local FocusSection = NI.DATA.StateHelper.getFocusSection(App)",
                "            local FocusScene = NI.DATA.StateHelper.getFocusScene(App)",
                "            local FocusScenePattern = FocusScene and NI.DATA.SceneAccess.getPattern(FocusScene, Group)",
                "            local HasFocus = Pattern == FocusScenePattern",
                "",
                "            if HasFocus then",
                "                if FocusSection then",
                "                    NI.DATA.SectionAccess.removePattern(App, FocusSection, Group)",
                "                else -- In Idea Space we work on Scenes directly.",
                "                    NI.DATA.SceneAccess.removePattern(App, FocusScene, Group)",
                "                end",
                "            else",
                "                NI.DATA.GroupAccess.insertPatternAndFocus(App, Group, Pattern)",
                "            end",
                "            if FocusGroup ~= GroupIndex then",
                "                MaschineHelper.setFocusGroup(FocusGroup + 1, false)",
                "            end",
                "        elseif CreateIfEmpty == true then",
                "            -- note: AudioPatterns can't currently be empty, so CreateIfEmpty is n/a",
                "            PatternHelper.insertNewPattern(PatternIndex, Group)",
                "        end",
                "    end",
                "end"
            ]

            lines.replaceSubrange(181..<218, with: newLines)
            
            let output = lines.joined(separator: "\n")
            try output.write(toFile: outputFile, atomically: true, encoding: .utf8)
            
            print("Hack #5 Applied: \(outputFile)")
        }
        catch {
            print("Error in Hack #5: \(error.localizedDescription)")
        }
    }
    if plug5 {
        for inputFile in inputPlugFiles5 {
            let inputFile = basePath + inputFile
            let outputFile = inputFile
            
            do {
                let input = try String(contentsOfFile: inputFile)
                var lines = input.components(separatedBy: .newlines)
                
                let newLines = [
                    "function PatternHelper.focusPatternByGroupAndByIndex(GroupIndex, PatternIndex, CreateIfEmpty)",
                    "",
                    "    if PatternIndex == nil or PatternIndex < 0 or GroupIndex == nil or GroupIndex < 0 then",
                    "        return",
                    "    end",
                    "",
                    "    local FocusGroup = NI.DATA.StateHelper.getFocusGroupIndex(App)",
                    "    local Group = MaschineHelper.getGroupAtIndex(GroupIndex)",
                    "",
                    "    if Group then",
                    "        local Pattern = Group:getPatterns():find(PatternIndex)",
                    "",
                    "        if Pattern then",
                    "            local FocusSection = NI.DATA.StateHelper.getFocusSection(App)",
                    "            local FocusScene = NI.DATA.StateHelper.getFocusScene(App)",
                    "            local FocusScenePattern = FocusScene and NI.DATA.SceneAccess.getPattern(FocusScene, Group)",
                    "            local HasFocus = Pattern == FocusScenePattern",
                    "",
                    "            if HasFocus then",
                    "                if FocusSection then",
                    "                    NI.DATA.SectionAccess.removePattern(App, FocusSection, Group)",
                    "                else -- In Idea Space we work on Scenes directly.",
                    "                    NI.DATA.SceneAccess.removePattern(App, FocusScene, Group)",
                    "                end",
                    "            else",
                    "                NI.DATA.GroupAccess.insertPatternAndFocus(App, Group, Pattern)",
                    "            end",
                    "            if FocusGroup ~= GroupIndex then",
                    "                MaschineHelper.setFocusGroup(FocusGroup + 1, false)",
                    "            end",
                    "        elseif CreateIfEmpty == true then",
                    "            -- note: AudioPatterns can't currently be empty, so CreateIfEmpty is n/a",
                    "            PatternHelper.insertNewPattern(PatternIndex, Group)",
                    "        end",
                    "    end",
                    "end"
                ]

                lines.replaceSubrange(181..<218, with: newLines)
                
                let output = lines.joined(separator: "\n")
                try output.write(toFile: outputFile, atomically: true, encoding: .utf8)
                
                print("Hack #5 Applied: \(outputFile)")
            }
            catch {
                print("Error in Hack #5: \(error.localizedDescription)")
            }
        }
        
    }
}
