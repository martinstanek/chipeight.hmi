infix operator ^^

extension Bool
{
    static func ^^(lhs:Bool, rhs:Bool) -> Bool
    {
        return (lhs && !rhs) || (!lhs && rhs)
    }
}
