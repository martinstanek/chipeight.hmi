import Foundation

public final class Essentials
{
    public static func hexStringToBytes(string: String) -> [UInt8]
    {
        let cleaned = string
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "\n", with: "")
            .lowercased()

        let hex = cleaned.count % 2 == 0
            ? cleaned
            : "0" + cleaned

        var bytes: [UInt8] = []
        
        bytes.reserveCapacity(hex.count / 2)

        var index = hex.startIndex
        
        while index < hex.endIndex
        {
            let next = hex.index(index, offsetBy: 2)
            let byteString = hex[index..<next]
            
            if let value = UInt8(byteString, radix: 16)
            {
                bytes.append(value)
            }
            else
            {
                continue;
            }
            
            index = next
        }

        return bytes
    }
    
    public static func bytesToHexString(bytes: [UInt8]) -> String
    {
        return ""
    }
}
