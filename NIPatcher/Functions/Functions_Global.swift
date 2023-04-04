//  Functions_Global.swift

import Cocoa
import AppKit
import Foundation

// -------------------------------------------------------------
// Check if Maschine app and Plugins exist in the expected paths
// Some people might have the plugs in /User/Library instead ??
// -------------------------------------------------------------

let filePaths = ["/Library/Audio/Plug-Ins/VST/Maschine 2.vst",
                 "/Library/Audio/Plug-Ins/VST3/Maschine 2.vst3",
                 "/Library/Audio/Plug-Ins/Components/Maschine 2.component",
                 "/Library/Application Support/Avid/Audio/Plug-Ins/Maschine 2.aaxplugin",
                 "/Applications/Native Instruments/Maschine 2/Maschine 2.app"]

let fileLabels = ["VST", "VST3", "AU", "AAX", "App"]

func checkFiles() -> [Bool] {
    let fileManager = FileManager.default
    var fileExists: [Bool] = []
    
    for filePath in filePaths {
        if fileManager.fileExists(atPath: filePath) {
            print("\(filePath) exists")
            fileExists.append(true)
        } else {
            print("\(filePath) does not exist")
            fileExists.append(false)
        }
    }
    
    return fileExists
}

// -------------------------------------------------------------
//   Check if KK app and Plugins exist in the expected paths
// -------------------------------------------------------------

let filePathsKK = ["/Library/Audio/Plug-Ins/VST/Komplete Kontrol.vst",
                 "/Library/Audio/Plug-Ins/VST3/Komplete Kontrol.vst3",
                 "/Library/Audio/Plug-Ins/Components/Komplete Kontrol.component",
                 "/Library/Application Support/Avid/Audio/Plug-Ins/Komplete Kontrol.aaxplugin",
                 "/Applications/Native Instruments/Komplete Kontrol/Komplete Kontrol.app"]

let fileLabelsKK = ["VST", "VST3", "AU", "AAX", "App"]

func checkFilesKK() -> [Bool] {
    let fileManager = FileManager.default
    var fileExists: [Bool] = []
    
    for filePath in filePathsKK {
        if fileManager.fileExists(atPath: filePath) {
            print("\(filePath) exists")
            fileExists.append(true)
        } else {
            print("\(filePath) does not exist")
            fileExists.append(false)
        }
    }
    
    return fileExists
}
