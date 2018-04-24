//
//  Date+Extension.swift
//  Encryptugla
//
//  Created by Mitchell Murphy on 4/24/18.
//  Copyright © 2018 Mitchell Murphy. All rights reserved.
//

import Foundation

extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
}
