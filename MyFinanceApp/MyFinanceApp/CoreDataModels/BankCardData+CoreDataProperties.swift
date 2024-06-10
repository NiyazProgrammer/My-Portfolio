import Foundation
import CoreData

@objc(BankCardData)
public class BankCardData: NSManagedObject {

}

extension BankCardData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BankCardData> {
        return NSFetchRequest<BankCardData>(entityName: "BankCardData")
    }

    @NSManaged public var id: UUID
    @NSManaged public var backImage: String
    @NSManaged public var name: String
    @NSManaged public var totalMoney: Double
    @NSManaged public var icon: String
    @NSManaged public var transactions: Set<TransactionData>?
}

// MARK: Generated accessors for transactions
extension BankCardData {

    @objc(insertObject:inTransactionsAtIndex:)
    @NSManaged public func insertIntoTransactions(_ value: TransactionData, at idx: Int)

    @objc(removeObjectFromTransactionsAtIndex:)
    @NSManaged public func removeFromTransactions(at idx: Int)

    @objc(insertTransactions:atIndexes:)
    @NSManaged public func insertIntoTransactions(_ values: [TransactionData], at indexes: NSIndexSet)

    @objc(removeTransactionsAtIndexes:)
    @NSManaged public func removeFromTransactions(at indexes: NSIndexSet)

    @objc(replaceObjectInTransactionsAtIndex:withObject:)
    @NSManaged public func replaceTransactions(at idx: Int, with value: TransactionData)

    @objc(replaceTransactionsAtIndexes:withTransactions:)
    @NSManaged public func replaceTransactions(at indexes: NSIndexSet, with values: [TransactionData])

    @objc(addTransactionsObject:)
    @NSManaged public func addToTransactions(_ value: TransactionData)

    @objc(removeTransactionsObject:)
    @NSManaged public func removeFromTransactions(_ value: TransactionData)

    @objc(addTransactions:)
    @NSManaged public func addToTransactions(_ values: NSOrderedSet)

    @objc(removeTransactions:)
    @NSManaged public func removeFromTransactions(_ values: NSOrderedSet)

}
