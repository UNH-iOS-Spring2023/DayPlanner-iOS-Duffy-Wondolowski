//
//  Persistence.swift
//  DayPlanner
//
//  Created by Orion Duffy on 3/17/23.
//

import Foundation

//The saving and loading feature is mostly copied from Apple's developer guide with some modifications
struct Persistence {
    private static func eventFileURL() throws -> URL {
            try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                .appendingPathComponent("events.data")
    }
    
    static func eventSave(events: [Event], completion: @escaping (Result<Int, Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(events)
                let outfile = try eventFileURL()
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
    
    static func eventLoad(completion: @escaping (Result<[Event], Error>)->Void) {
            DispatchQueue.global(qos: .background).async {
                do {
                    let fileURL = try eventFileURL()
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
    
    private static func userFileURL() throws -> URL {
            try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                .appendingPathComponent("user.data")
    }
    
    static func userSave(user: User, completion: @escaping (Result<Int, Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(user)
                let outfile = try userFileURL()
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(0))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    static func userLoad(completion: @escaping (Result<User, Error>)->Void) {
            DispatchQueue.global(qos: .background).async {
                do {
                    let fileURL = try userFileURL()
                    guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                        DispatchQueue.main.async {
                            completion(.success(User()))
                        }
                        return
                    }
                    let user = try JSONDecoder().decode(User.self, from: file.availableData)
                    DispatchQueue.main.async {
                        completion(.success(user))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                }
            }
        }
    }
    static func save(user: User, events: [Event], completion: @escaping (Result<Int, Error>, Result<Int, Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            var userResult: Result<Int, Error> = .success(0)
            var eventResult: Result<Int, Error> = .success(0)
            
            userSave(user: user) { result in //Callback hell is necessary to avoid potential async issues
                userResult = result
//                print("Day Planner: User save result \(userResult)")
                
                eventSave(events: events) { result in
                    eventResult = result
//                    print("Day Planner: Event save result \(eventResult)")
                    
                    DispatchQueue.main.async {
                        completion(userResult, eventResult)
                    }
                }
            }
        }
    }
    
    static func load(completion: @escaping (Result<User, Error>, Result<[Event], Error>)->Void) {
            DispatchQueue.global(qos: .background).async {
                var userResult: Result<User, Error> = .success(User())
                var eventResult: Result<[Event], Error> = .success([])
                
                userLoad{ result in //Callback hell is necessary to avoid potential async issues
                    userResult = result
//                    print("Day Planner: User load result \(userResult)")
                    
                    eventLoad{ result in
                        eventResult = result
//                        print("Day Planner: Event load result \(eventResult)")
                        
                        DispatchQueue.main.async {
//                            print("event load result \(eventResult)")
                            completion(userResult, eventResult)
                        }
                    }
                }
        }
    }
}
