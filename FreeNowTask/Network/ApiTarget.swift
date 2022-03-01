//
//  ApiTarget.swift
//  FreeNowTask
//
//  Created by Mena Gamal on 01/03/2022.
//

import Foundation
import Moya
typealias MoyaMethod = Moya.Method
enum ApiTarget {
    case listVehicleData(p1Lat: Double,
                         p1Lon: Double,
                         p2Lat: Double,
                         p2Lon: Double)
}
extension ApiTarget: TargetType {
    var baseURL: URL {
        URL(string: "https://poi-api.mytaxi.com/PoiService/")!
    }
    
    var path: String {
        switch self {
        case.listVehicleData(_,_,_,_):
            return "poi/v1"
        }
    }
    
    var method: MoyaMethod {
        switch self {
        case .listVehicleData(_,_,_,_):
            return .get
        }
    }
    
    var sampleData: Data {
        return  Data()
    }
    
    var task: Task {
        switch self {
            
        case .listVehicleData(let p1Lat,
                              let p1Lon,
                              let p2Lat,
                              let p2Lon):
            var urlParams =  [String:Any]()
            urlParams = [
                "p2Lat": p2Lat,
                "p1Lon": p1Lon,
                "p1Lat": p1Lat,
                "p2Lon": p2Lon
                
            ]
            return .requestParameters(parameters: urlParams, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
}
extension TargetType {
    public func debugLog() -> Self {
        #if DEBUG
        debugPrint("=======================================")
        debugPrint(self)
        print("Base Url =============", baseURL)
        print("Path =================", path)
        print("URL ==================", baseURL,path)
        print("HTTP Method ==========", method.rawValue)
        print("Task =================", task)
        print("Headers ==============", headers ?? "No Headers")
        debugPrint("=======================================")
        #endif
        return self
    }
}

extension Response {
    public func debugLog() -> Self {
        #if DEBUG
        debugPrint("=======================================")
        debugPrint(self)
        debugPrint(String(data: self.data, encoding: .utf8))
        debugPrint("=======================================")
        #endif
        return self
    }
}

