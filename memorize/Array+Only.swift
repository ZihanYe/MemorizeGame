//
//  Array+Only.swift
//  memorize
//
//  Created by ZihanYe on 08/07/2020.
//  Copyright © 2020 ZihanYe. All rights reserved.
//

import Foundation

extension Array {
    var only : Element? {
        count == 1 ? first : nil
    }
}
