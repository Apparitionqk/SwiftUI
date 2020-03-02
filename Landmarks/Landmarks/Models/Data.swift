//
//  Data.swift
//  Landmarks
//
//  Created by 123 on 2020/3/1.
//  Copyright © 2020 123. All rights reserved.
//

import UIKit
import SwiftUI
import CoreLocation

let landMarkData: [Landmark] = load("landmarkData.json")

func load <T:Decodable>(_ filename: String, as type: T.Type = T.self) -> T {
    let data:Data
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
        fatalError("couldn't find \(filename) in main bundle")
    }
    do {
       data = try Data(contentsOf: file)
    } catch  {
        fatalError("Could't load \(filename) from main bundle \(error)")
    }
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch  {
        fatalError("Couldn't parse \(filename) as \(T.self)\n\(error)")
    }
}

/**
 Swfit 中 final 可用于修饰 class、func、var
 作用
 1.提升性能---效果有限
 2.权限控制，即这个方法或者类不希望被重写
    a.类或者方法的功能确实已经完备了
    b.避免子类集成或修改造成危险
    c.为了让父类中某些代码一定会执行
 */
final class ImageStore{
    typealias _ImageDictionary = [String: CGImage]
    fileprivate var images:_ImageDictionary = [:]
    fileprivate static var scale = 2
    static var shared = ImageStore()
    func iamge(name:String) -> Image {
        let index = _guaranteeImage(name: name)
        return Image(images.values[index], scale: CGFloat(ImageStore.scale), label: Text(verbatim: name))
    }
    /**
     在Swift中static func 相当于class final func。禁止这个方法被重写
     */
     static func loadImage(name: String) -> CGImage {
        guard
            let url = Bundle.main.url(forResource: name, withExtension: "jpg"),
            let imageSource = CGImageSourceCreateWithURL(url as NSURL, nil),
            let image = CGImageSourceCreateImageAtIndex(imageSource, 0, nil)
        else {
            fatalError("Couldn't load image  \(name).jpg from main bundle")
        }
        return image
    }
    fileprivate func _guaranteeImage(name: String) -> _ImageDictionary.Index {
        if let index = images.index(forKey: name) { return index }
        
        images[name] = ImageStore.loadImage(name: name)
        return (images.index(forKey: name) ?? nil)!
    }
}
