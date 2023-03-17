//
//  Persistence.swift
//  DayPlanner
//
//  Created by Orion Duffy on 3/17/23.
//

import Foundation

//The saving and loading feature is mostly copied from Apple's developer guide with some modifications
struct Persistence {
    private static func fileURL() throws -> URL {
            try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                .appendingPathComponent("events.data")
    }
    
    static func save(events: [Event], completion: @escaping (Result<Int, Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(events)
                let outfile = try fileURL()
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(events.count))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    static func load(completion: @escaping (Result<[Event], Error>)->Void) {
            DispatchQueue.global(qos: .background).async {
                do {
                    let fileURL = try fileURL()
                    guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                        DispatchQueue.main.async {
                            completion(.success([]))
                        }
                        return
                    }
                    let events = try JSONDecoder().decode([Event].self, from: file.availableData)
                    DispatchQueue.main.async {
                        completion(.success(events))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                }
            }
        }
    }
}
