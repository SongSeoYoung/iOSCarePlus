//
//  NewGameResponse.swift
//  iOSCarePlus
//
//  Created by 송서영 on 2020/12/16.
//

import Foundation

struct NewGameResponse: Decodable {
    let contents: [NewGameContent]
    let length: Int
    let offset: Int
    let total: Int
}

struct NewGameContent: Decodable {
    let formalName: String
    let heroBannerURL: String
    let screenshots: [ScreenShotContent]
//    let id: Int
    enum CodingKeys: String, CodingKey {
        case formalName = "formal_name"
        case heroBannerURL = "hero_banner_url"
    }
}

struct ScreenShotContent: Decodable{
    let images: [String]
}
