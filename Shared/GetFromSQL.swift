//
//  GetFromSQL.swift
//  SmartHouse
//
//  Created by Admin on 10.11.2021.
//
import Foundation
import PostgresClientKit
class GetFromSQL {
    func getSQLStatistics(name:String, sensor:String,whatDayGet:String,  completion: @escaping ([[String]]) -> Void) {
        var result: [[String]] = []
        do {
            var configuration = PostgresClientKit.ConnectionConfiguration()
            configuration.host = "ec2-176-34-168-83.eu-west-1.compute.amazonaws.com"
            configuration.database = "d8uq0o35eq55kl"
            configuration.user = "zftenjusikiyjk"
            configuration.credential = .md5Password(password: "7369c86979b2cbf92b10879ec08ba1ca99394ea761c0462a4baf24d3a2225685")
            
            
            let connection = try PostgresClientKit.Connection(configuration: configuration)
            defer { connection.close() }
            let statement = try connection.prepareStatement(text: "select * from \(name) WHERE sensor = \(sensor) AND (CAST(date AS DATE) = CAST('\(whatDayGet)' AS DATE)) ORDER BY date;")
            defer { statement.close() }
            
            let cursor = try statement.execute()
            defer { cursor.close() }
            
            for row in cursor {
                let columns = try row.get().columns
                let date = try columns[0].string()
                //let date = try columns[0].date().dateComponents
                //let hour = try date.hour.postgresValue.string()
                //let minute = try date.minute.postgresValue.string()
                let temperature = try columns[1].string()
                let humidity = try columns[2].string()
                //let buff = [hour, minute, temperature, humidity]
                let buff = [date, temperature, humidity]
                print(buff)
                result.append(buff)
            }
            statement.close()
            completion(result)
        } catch {
            print(error) // better error handling goes here
        }
    }
    /*                    val date = rs.getTimestamp("date")
     val temperature = rs.getFloat("temperature")
     val humidity = rs.getFloat("humidity")
     val calendar = dateToCalendar(date)
     val day = calendar[Calendar.DAY_OF_MONTH]
     val month = calendar[Calendar.MONTH]
     val year = calendar[Calendar.YEAR]
     val hour = calendar[Calendar.HOUR]
     val min = calendar[Calendar.MINUTE]
     val buffArray = arrayOf(
         day.toString(),
         month.toString(),
         hour.toString(),
         min.toString(),
         temperature.toString(),
         humidity.toString()
     )*/
    
}
