//
//  URL+storeURL.swift
//  andIQuote
//
//  Created by s on 4/16/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import UIKit


extension URL {
    static func storeURL(for appGroup: String = "group.com.hectorstevenvillasano.andIQuote.LocalCache", dataBaseName: String) -> URL {
        guard let fileContainer = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroup) else {
            fatalError("storeURL error")
        }

        return fileContainer.appendingPathExtension("\(dataBaseName).sqlite")
    }
}
