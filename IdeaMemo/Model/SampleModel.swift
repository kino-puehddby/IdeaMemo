//
//  SampleModel.swift
//  IdeaMemo
//
//  Created by Hisaya Sugita on 2020/11/13.
//

import Foundation

struct SampleModel: Codable, Equatable {
    var id: Int
    var topic: String
    
    static func == (lhs: SampleModel, rhs: SampleModel) -> Bool {
        return lhs.id == rhs.id
    }
}
