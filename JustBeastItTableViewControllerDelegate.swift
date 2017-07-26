//
//  JustBeastItTableViewControllerDelegate.swift
//  BeastList
//
//  Created by Lu Yu on 9/23/16.
//  Copyright © 2016 Lu Yu. All rights reserved.
//

import Foundation; import UIKit

protocol JustBeastItTableViewControllerDelegate: class {
    func justBeastItViewController(_ controller: JustBeastItTableViewController, didFinishAddingBeast task: String, date: Date, beasted: Bool)
    func justBeastItViewController(_ controller: JustBeastItTableViewController, didFinishEditingBeast task: String, date: Date, beasted: Bool)
}
