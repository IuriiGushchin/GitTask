//
//  rssParser.swift
//  Frontend
//
//  Created by iMac27 on 09.06.2018.
//  Copyright © 2018 iMac27. All rights reserved.
//

import Foundation


class rssParser: NSObject, XMLParserDelegate {
    
    private var rssItems : [RSSItem] = []
    private var currentElement = ""
    private var currentPubDate : String = "" {
        didSet { //когда будем объявлять текущие данные для ячейки обрежем ненужные символы
            currentPubDate = currentPubDate.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentTitle : String = ""{
        didSet { //когда будем объявлять текущие данные для ячейки
            currentTitle = currentTitle.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentDescription : String = ""{
        didSet { //когда будем объявлять текущие данные для ячейки
            currentDescription = currentDescription.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    private var parserComplitionHandler : (([RSSItem]) -> Void)?
    
    
    func parseFeed(url: String, completionHandler: (([RSSItem]) -> Void)?){
        self.parserComplitionHandler = completionHandler
        let url = URL(string: url)
        let request = URLRequest(url: url!)
        let session = URLSession.shared
        _ = session.dataTask(with: request) { (data, responce, error) in
            let data = data!
            let responce = responce!
            print(data)
            
            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
            
        }.resume()
    }
    
    
    //XMLParserDelegate
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        if currentElement == "item" { //если нашли новый итем - обнулили заголовок,время публикации и описание
            currentPubDate = ""
            currentTitle = ""
            currentDescription = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch currentElement {
        case "Title":
            currentTitle += string
        case "pubDate":
            currentPubDate += string
        case "description":
            currentDescription += string
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        currentElement = elementName
        if currentElement == "item"{//закончили итем - добавили в array
            let rssItem = RSSItem(title: currentTitle, description: currentDescription, pubDate: currentPubDate)
            self.rssItems.append(rssItem)
        }
    
        func parserDidEndDocument(_ parser : XMLParser){
            parserComplitionHandler?(rssItems)
        }
        
        func parser(_ parser: XMLParser, parseErrorOccurred: Error){
            print(parseErrorOccurred.localizedDescription)
        }
    }
}
