protocol FraseMotResponseProtocol: AnyObject{
func salvar(item: FraseMotResponse)
}

struct FraseMotResponse: Codable
{
    var quoteText,
        quoteAuthor,
        senderName,
        senderLink,
        quoteLink: String?
    
    public func toString() -> String {
        return "Frases: \(quoteText!)"
        
    }
}
