//
//  TabRulesViewCellDelegate.swift
//  X-SwiftFormat
//
//  Created by Rui Aureliano on 31/03/2020.
//  Copyright © 2020 Rui Aureliano. All rights reserved.
//

import Cocoa

protocol TabRulesViewCellDelegate: class {

	func switchChanged(key: String, labelValue: Bool, switchValue: Bool)
}
