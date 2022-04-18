//
//  GameSearchService.swift
//  ToGaming
//
//  Created by felipe azevedo on 15/04/22.
//

import Foundation
import Alamofire
import SwiftyJSON

class IgdbService {
    
    private let baseURL = "https://api.igdb.com/v4/"
    private var clientId: String = ""
    private var token: String = ""
    
    func config() {
        let userConfig = PersistenceController().getUserConfig()
        
        clientId = userConfig?.clientId ?? ""
        token = userConfig?.secretKey ?? ""
    }
 
    func searchGame(name: String, result: @escaping([GameSearchViewModel]?) -> ()) {
        
        let uri = "games"
        let url = "\(baseURL)\(uri)"
        
        let body = """
        search "\(name)"; fields name, first_release_date, aggregated_rating, platforms.name, cover.url, involved_companies.developer, involved_companies.company.name;
        """
        
        let headers: HTTPHeaders = ["client-id": "\(clientId)", "authorization": "Bearer \(token)"]
        
        do {
            var request = try URLRequest(url: URL(string: url)!, method: .post, headers: headers)
            request.httpBody = body.data(using: .utf8)
            
            AF.request(request).responseData { response in
                switch response.result {
                case .success(let jsonData):
                    do {
                        let json = try JSON(data: jsonData).array
                        if let json = json {
                            let results = json.compactMap{ GameSearchViewModel(
                                id: $0["id"].intValue,
                                aggregatedRating: $0["aggregated_rating"].double,
                                cover: $0["cover"]["id"].exists() ? CoverGameSearchViewModel(
                                    id: $0["cover"]["id"].intValue,
                                    url: $0["cover"]["url"].stringValue) : nil,
                                firstReleaseDate: $0["first_release_date"].int,
                                name: $0["name"].stringValue,
                                platforms: $0["platforms"].arrayValue.compactMap({ platform in
                                    PlatformGameSearchViewModel(
                                        id: platform["id"].intValue,
                                        name: platform["name"].stringValue) }),
                                involvedCompanies: $0["involved_companies"].arrayValue.compactMap({ companies in
                                    InvolvedCompanyGameSearchViewModel(
                                        id: companies["id"].intValue,
                                        company: CompanyGameSearchViewModel(
                                            id: companies["company"]["id"].intValue,
                                            name: companies["company"]["name"].stringValue),
                                        developer: companies["developer"].boolValue)
                                })) }
                            result(results)
                        } else {
                            result([])
                        }
                    } catch {
                        result(nil)
                    }
                    break
                case .failure(let error):
                    print(error)
                    result(nil)
                    break
                }
            }
        } catch {
            result(nil)
        }
    }
}
