//
//  MVCloudCAPackOfData.swift
//  ViettelPortal
//
//  Created by hungnm98 on 28/07/2022.
//  Copyright © 2022 PPCLINK. All rights reserved.
//

import Foundation
import ObjectMapper

class MVCloudCAPackOfData: NSObject, Mappable {
    var errorCode = 0
    var message = ""
    var data: [MVCloudCAPackOfDataItem]?
    var tranIdTracking: String?

    override init() {
    }

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        errorCode <- map["errorCode"]
        message <- map["message"]
        data <- map["data"]
        tranIdTracking <- map["tranIdTracking"]
    }
}

class MVCloudCAPackOfDataItem: NSObject, Mappable {
    var tableName: String?
    var type: [String]?
    var type1: String?
    var id: String?
    var code: String?
    var telecomserviceId: String?
    var title: String?
    var summery: String?
    var thoigiansudung: String?
    var tonggiagoi: String?
    var startDate: String?
    var endDate: String?
    var status: [String]?
    var status2: String?
    var sortOrder: String?
    var regReasonCode: String?
    var groupType: String?
    var updateTime: String?
    var lastUpdateTime: String?
    var createdYear: String?
    var createdMonth: String?
    var createdDay: String?
    var createdTime: String?
    var version: Int?

    override init() {
    }

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        tableName <- map["table_name"]
        type <- map["type"]
        type1 <- map["type1"]
        id <- map["id"]
        code <- map["code"]
        telecomserviceId <- map["telecomserviceId"]
        title <- map["title"]
        summery <- map["summery"]
        thoigiansudung <- map["thoigiansudung"]
        tonggiagoi <- map["tonggiagoi"]
        startDate <- map["startDate"]
        endDate <- map["endDate"]
        status <- map["status"]
        status2 <- map["status2"]
        sortOrder <- map["sortOrder"]
        regReasonCode <- map["regReasonCode"]
        groupType <- map["groupType"]
        updateTime <- map["updateTime"]
        lastUpdateTime <- map["lastUpdateTime"]
        createdYear <- map["createdYear"]
        createdMonth <- map["createdMonth"]
        createdDay <- map["createdDay"]
        createdTime <- map["createdTime"]
        version <- map["_version_"]
    }
}
