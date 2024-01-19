//
//  checkResponseItem.swift
//  Pruebas
//
//  Created by c035 DIT UPM on 14/12/23.
//

import Foundation

struct checkResponseItem : Codable {
    let quizId : Int
    let answer : String
    let result : Bool
 }
