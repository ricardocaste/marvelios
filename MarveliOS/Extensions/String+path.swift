//
//  String+path.swift
//  MarveliOS
//
//  Created by Ricardo Castellanos on 19/9/22.
//

import Foundation

extension String {

    func path() -> String {
        return URL(fileURLWithPath: self).deletingPathExtension().lastPathComponent
    }

    func fileExtension() -> String {
        return URL(fileURLWithPath: self).pathExtension
    }
}
