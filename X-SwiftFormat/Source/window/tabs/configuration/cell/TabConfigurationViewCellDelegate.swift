//
//  TabConfigurationViewCellDelegate.swift
//  X-SwiftFormat
//
//  Created by Rui Aureliano on 31/03/2020.
//  Copyright © 2020 Rui Aureliano. All rights reserved.
//

import Cocoa

protocol TabConfigurationViewCellDelegate: class {

	func switchChanged(key: String, labelValue: Bool, switchValue: Bool)
	func numberChanged(key: String, labelValue: Bool, stepperValue: Int)
	func objectChanged(key: String, labelValue: Bool, popup: String, stepperValue: Int)
}
