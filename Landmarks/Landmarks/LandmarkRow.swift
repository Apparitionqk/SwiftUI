//
//  RowView.swift
//  Landmarks
//
//  Created by 123 on 2020/3/1.
//  Copyright © 2020 123. All rights reserved.
//

import SwiftUI

struct LandmarkRow: View {
    var landMark: Landmark
    var body: some View {
        HStack {
            landMark.image
                .resizable()
                .frame(width: 50, height: 50)
            Text(landMark.name)
            Spacer()
        }
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            LandmarkRow(landMark:landMarkData[0])
            LandmarkRow(landMark:landMarkData[1])
        }
        .previewLayout(.fixed(width: 300, height: 70))

    }
}
