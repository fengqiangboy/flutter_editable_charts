//
//  ColorUtil.swift
//  flutter_editable_charts
//
//  Created by 奉强 on 2019/4/11.
//

import Foundation

func ColorFromRGB(rgbValue: Int) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0x00FF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x0000FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x000000FF) / 255.0,
        alpha: CGFloat((UInt64(rgbValue) & UInt64(0xFF000000)) >> 24) / 255
    )
}
