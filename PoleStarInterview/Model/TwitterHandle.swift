//
//  TwitterHandle.swift
//  PoleStarInterview
//
//  Created by Christopher Hefferman on 03/08/2020.
//  Copyright © 2020 Chris Hefferman. All rights reserved.
//

import Foundation

struct TwitterHandle: Codable {
    var user: User
    var text: String
    var favorite_count: Int
}


struct User: Codable {
    var screen_name: String
    var name: String
    var profile_image_url: String
}
