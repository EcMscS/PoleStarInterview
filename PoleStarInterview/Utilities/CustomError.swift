//
//  CustomError.swift
//  PoleStarInterview
//
//  Created by Christopher Hefferman on 03/08/2020.
//  Copyright © 2020 Chris Hefferman. All rights reserved.
//

import Foundation

enum CustomError: String, Error {
    case invalidUsername = "This username created an invalid request, please try again."
    case unableToComplete = "Unable to complete your request, please check your internet connection."
    case invalidResponse = "Invalid response from the server, please try again."
    case invalidData = "The data recieved from the server was invalid. Please try again."
}
