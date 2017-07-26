//
//  CancelButtonDelegate.swift
//  BeastList
//
//  Created by Lu Yu on 9/23/16.
//  Copyright © 2016 Lu Yu. All rights reserved.
//

import Foundation

import UIKit

protocol CancelButtonDelegate: class {
    func cancelButtonPressedFrom(controller: UITableViewController)
}
