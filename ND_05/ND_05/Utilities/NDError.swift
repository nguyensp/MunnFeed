//
//  NDError.swift
//  ND_05
//
//  Created by Paul Nguyen on 7/5/22.
//

import Foundation

enum NDError: String, Error {
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidData = "The data received from the server was invalid. Please try again."
    case unableToDecode = "JSONDECODER Fail."
}
