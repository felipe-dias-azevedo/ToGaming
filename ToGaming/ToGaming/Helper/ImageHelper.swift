//
//  ImageHelper.swift
//  ToGaming
//
//  Created by felipe azevedo on 19/04/22.
//

import Foundation

class ImageHelper {
    
    enum FormatTypes: String, CaseIterable, Codable {
        case coverSmall = "cover_small"
        case coverBig = "cover_big"
        case screenshotMed = "screenshot_med"
        case screenshotBig = "screenshot_big"
        case screenshotHuge = "screenshot_huge"
        case hd = "720p"
        case fullhd = "1080p"
    }
    
    static func formatToURL(_ image: String, format: FormatTypes = .hd) -> URL? {
        let url = self.format(image, format: format)
        return toURL(url)
    }
    
    static func format(_ image: String, format: FormatTypes = .hd) -> String {
        return "https:" + image.replacingOccurrences(of: "thumb", with: format.rawValue)
    }
    
    static func toURL(_ image: String) -> URL? {
        return URL(string: image)
    }
}
