//
//  Landmark.swift
//  Landmarks
//
//  Created by 123 on 2020/3/1.
//  Copyright © 2020 123. All rights reserved.
//

import SwiftUI
import CoreLocation

struct Landmark:Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    fileprivate var imageName: String
    fileprivate var coordinates: Coordinates
    var state: String
    var park: String
    var category: LandCategory
    
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude)
    }
  
    enum LandCategory: String, RawRepresentable, CaseIterable, Hashable, Codable {
        case featured = "Featured"
        case lakes = "Lakes"
        case rivers = "Rivers"
    }
}

extension Landmark {
    var image:Image {
          ImageStore.shared.iamge(name: imageName)
      }
}
struct Coordinates: Hashable, Codable {
    var latitude: Double
    var longitude: Double
}
