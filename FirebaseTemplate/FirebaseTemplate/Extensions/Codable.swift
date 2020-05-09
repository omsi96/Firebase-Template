

import Foundation

extension Encodable {
  var dictionary: [String: Any]? {
    guard let data = try? JSONEncoder().encode(self) else { return nil }
    return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
  }
}


extension Decodable{

//    init?(from dictionary: [String: Any])
//    {
//        
//        guard let data = try? JSONSerialization.data(withJSONObject: dictionary, options: .fragmentsAllowed) else {return}
//        return try? JSONDecoder().decode(Self.self, from: data)
//        
//    }
}

