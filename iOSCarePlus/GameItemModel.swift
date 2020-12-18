//
//  GameItemModel.swift
//  iOSCarePlus
//
//  Created by 송서영 on 2020/12/16.
//

import Foundation
struct GameItemModel {
    let gameTitle: String
    let gameOriginPrice: Int
    let gameDiscountPrice: Int?     //깂이 있을 수도 , 없을 수도 있어서 옵셔널
    let imageURL: String
}
