import Foundation

prefix operator ^

extension Optional where Wrapped == String? {
    public static prefix func ^ (rhs: Wrapped?) -> String {
        if let unWrapped = rhs, let data = unWrapped {
            return data
        }
        return ""
    }
}

extension String {
    public static prefix func ^ (rhs: String) -> String {
        return rhs
    }
}
