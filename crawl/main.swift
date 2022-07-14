//
//  main.swift
//  crawl
//
//  Created by Kaiya Takahashi on 2022-07-13.
//

import Foundation

var fileManager = FileManager.default

func crawl(url: URL) {
    crawlHelper(url: url, count: 0)
}

var isDir: ObjCBool = false
func crawlHelper(url: URL, count: Int) {
    let space = spaceManager(count: count)
    if fileManager.fileExists(atPath: url.path, isDirectory: &isDir) {
        if isDir.boolValue {
            // Exists and Dir
            let dirs = try! fileManager.contentsOfDirectory(at: url, includingPropertiesForKeys: [], options: .skipsHiddenFiles)
            for dir in dirs {
                if dirs[dirs.count - 1] != dir {
                    print(space + "├─\(dir.lastPathComponent)")
                } else {
                    print(space + "└─\(dir.lastPathComponent)")
                    return
                }
                crawlHelper(url: dir, count: count + 1)
            }
        }
    }
    return
}

func spaceManager(count: Int) -> String {
    var space: String = ""
    for _ in 0..<count {
        space += "|     "
    }
    return space
}

let url = fileManager.urls(for: .desktopDirectory, in: .userDomainMask).first!
crawl(url: url)
