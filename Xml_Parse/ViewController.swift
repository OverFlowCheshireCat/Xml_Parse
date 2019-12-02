import UIKit

class ViewController: UIViewController, XMLParserDelegate {

    var item: [String : String] = [:]
    
    var itemList: [[String : String]] = []
    
    var currentElement = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*let path = Bundle.main.url(forResource: "Fruit", withExtension: "xml") // .xml 파일 형식 파싱
        
        if path != nil {
            let parser = XMLParser(contentsOf: path!)
            
            if parser != nil {
                parser?.delegate = self
                
                if (parser?.parse())! {
                    print(itemList)
                } else {
                    print("Parse Error")
                }
            } else {
                print("Parser Nil Pointer Error")
            }
        } else {
            print("Not Found File Error")
        }*/
        
        let url = "http://api.androidhive.info/pizza/?format=xml" // xml 웹 형식 파싱
        
        let path = NSURL(string: url)
        
        if path != nil {
            let parser = XMLParser(contentsOf: path! as URL)
            
            if parser != nil {
                parser?.delegate = self
                
                if (parser?.parse())! {
                    print(itemList)
                } else {
                    print("Parse Error")
                }
            } else {
                print("Parser Nil Pointer Error")
            }
        } else {
            print("Not Found File Error")
        }
    }
    
    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
    }
    
    public func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        
        if !data.isEmpty {
            item[currentElement] = data
        }
    }
    
    public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            itemList.append(item)
        }
    }
}
