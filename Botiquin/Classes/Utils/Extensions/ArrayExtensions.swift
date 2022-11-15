//
//  ArrayExtensions.swift
//  Botiquin
//
//  Created by Javier Castañeda on 14/11/22.
//

import Foundation

extension Array {
    // Safely lookup an index that might be out of bounds,
    // returning nil if it does not exist
    func get(_ index: Int) -> Element? {
      guard index >= 0, index < count else { return nil }
      return self[index]
    }
}
