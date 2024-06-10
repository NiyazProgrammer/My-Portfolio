//
//  String + ext.swift
//  MyFinanceApp
//
//  Created by Нияз Ризванов on 29.04.2024.
//

import Foundation

extension String {
    func dateParse() -> Date {
        guard let parsedDate = DateFormatter.allNumericRUS.date(from: self) else { return Date()}
        return parsedDate
    }
}
