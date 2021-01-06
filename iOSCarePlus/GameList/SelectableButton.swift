//
//  selectableButton.swift
//  iOSCarePlus
//
//  Created by 송서영 on 2021/01/06.
//

import UIKit

class SelectableButton: UIButton {
    //view 가 메모리에 올라가고나서 호출되는 라이프사이클
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setTitleColor(UIColor(named: "black"), for: .selected)
        setTitleColor(UIColor.init(named: "VeryLightPink"), for: .normal)
        tintColor = .clear
    }
}
//    func select(_ value: Bool){
//        if value {
//            setTitleColor(UIColor.init(named: "black"), for: .normal)
//        }else{
//            setTitleColor(UIColor.init(named: "VeryLightPink"), for: .normal)
//        }
//    }
//}
