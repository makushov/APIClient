import Foundation

public protocol APIErrorProcessing {
    
    func processErrorWithResponse(_ response: APIClient.HTTPResponse) -> Error
    
}

public struct APIErrorProcessor: APIErrorProcessing {
    
    private let deserializer = JSONDeserializer()
    
    public func processErrorWithResponse(_ response: APIClient.HTTPResponse) -> Error {
        if let dictionary = (try? deserializer.deserialize(response.0, data: response.1)) as? [String: AnyObject] {
                return NetworkError(statusCode: response.0.statusCode, rawResponseDictionary: dictionary)
        }
        
        return NetworkError.undefined
    }
    
}
