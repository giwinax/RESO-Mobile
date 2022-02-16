//
//  OfficeListModel.swift
//  RESO Mobile
//
//  Created by s b on 16.02.2022.
//

struct OfficeListModel: Decodable {
    let IDOKRUG: Int
    let NDISTANSE: Double
    let NLONG: Double
    let SADDRESS: String
    let SSHORTNAME: String
    let SSHORTADDRESS: String
    let LBANKOMAT: Bool?
    let LSPR: Bool?
    let LREG_CENTER: Bool?
    let IDUNDERGROUND: [IDUNDERGROUNDStruct]
    let LPAYBYCARD: Bool?
    let SPHONE: String
    let SGRAF: String?
    let SGRAFSPR: String?
    let GRAF: [GRAFStruct]?
    let NLAT: Double
    let CPHONE: [CPHONEStruct]
    let NTIMEZONE: String
    let ID: Int
    let SEMAIL: String?
    let SWAY: String?
}

struct GRAFStruct: Decodable {
    let SBEGIN: String
    let NDAY: Int
    let SEND: String
}

struct CPHONEStruct: Decodable {
    let SPHONE: String
    let SPHONETYPE: String
    let SPHONEADD: String
}

struct IDUNDERGROUNDStruct: Decodable {
    let SNAME: String
    let ID: Int

}

