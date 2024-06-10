import Foundation
import CoreData

@objc(TransactionData)
public class TransactionData: NSManagedObject {

}

extension TransactionData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TransactionData> {
        return NSFetchRequest<TransactionData>(entityName: "TransactionData")
    }

    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var date: String
    @NSManaged public var price: Double
    @NSManaged public var type: String
    @NSManaged public var transactionCategory: String
    @NSManaged public var bankCard: BankCardData?

}
