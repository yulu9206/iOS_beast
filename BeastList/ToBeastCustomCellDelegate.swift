//
//  ToBeastCustomCellDelegate.swift
//  BeastList
//
//  Created by Lu Yu on 9/23/16.
//  Copyright © 2016 Lu Yu. All rights reserved.
//

import Foundation; import UIKit

protocol ToBeastCustomCellDelegate: class {
    func didSelectButtonAtIndexPathOfCell(sender: ToBeastCustomCell)
}
