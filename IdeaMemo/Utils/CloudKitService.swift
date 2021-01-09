//
//  CloudMemoRecord.swift
//  IdeaMemo
//
//  Created by Hisaya Sugita on 2021/01/06.
//

import Combine
import CloudKit

struct CloudMemoRecord {
    static func get(completion: @escaping (Result<[Memo], Error>) -> Void) {
        let database = CKContainer.default().privateCloudDatabase
        let predicate = NSPredicate(format: "TRUEPREDICATE")
        let query = CKQuery(recordType: "Memo", predicate: predicate)
        
        database.perform(query, inZoneWith: nil) { records, error in
            if let error = error {
                completion(.failure(error))
            }
            let list = records?.map { Memo(id: $0.recordID.recordName, title: $0["title"]!, content: $0["content"]!) }
            guard let memoList = list else {
                completion(.failure(AppError.system))
                return
            }
            
            completion(.success(memoList))
        }
    }
    
    static func create(title: String, content: String, completion: @escaping (Result<Memo, Error>) -> Void) {
        let database = CKContainer.default().privateCloudDatabase
        let record = CKRecord(recordType: "Memo")
        record["title"] = title
        record["content"] = content
        database.save(record) { record, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let record = record else {
                completion(.failure(AppError.system))
                return
            }
            let memo = Memo(
                id: record.recordID.recordName,
                title: title,
                content: content
            )
            completion(.success(memo))
        }
    }
    
    static func update(memo: Memo, completion: @escaping (Result<Memo, Error>) -> Void) {
        let database = CKContainer.default().privateCloudDatabase
        let recordId = CKRecord.ID(recordName: memo.id)
        database.fetch(withRecordID: recordId) { record, error in
            if let error = error {
                completion(.failure(error))
            }

            guard let record = record else {
                completion(.failure(AppError.system))
                return
            }

            record["title"] = memo.title
            record["content"] = memo.content
            database.save(record) { record, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let record = record else {
                    completion(.failure(AppError.system))
                    return
                }
                let memo = Memo(
                    id: record.recordID.recordName,
                    title: memo.title,
                    content: memo.content
                )
                completion(.success(memo))
            }
        }
    }
    
    static func delete(recordName: String, completion: @escaping (Result<String, Error>) -> Void) {
        let database = CKContainer.default().privateCloudDatabase
        let recordId = CKRecord.ID(recordName: recordName)
        database.delete(withRecordID: recordId) { recordId, error in
            if let error = error {
                completion(.failure(error))
            }
            guard let recordId = recordId else {
                completion(.failure(AppError.system))
                return
            }
            completion(.success(recordId.recordName))
        }
    }
    
    private static func validAccountStatus(_ completion: @escaping (Result<Void, Error>) -> Void) {
        CKContainer.default().accountStatus { accountStatus, error in
            if let error = error {
                completion(.failure(error))
            }
            
            guard accountStatus != .noAccount else {
                completion(.failure(AppError.icloud))
                return
            }
            completion(.success(()))
        }
    }
}

// ---------------------
// methods for Combine
// ---------------------
extension CloudMemoRecord {
    static func get() -> AnyPublisher<[Memo], Error> {
        return Future<Void, Error> { promise in
            validAccountStatus { result in
                switch result {
                case .success:
                    promise(.success(()))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .flatMap { _ in
            Future<[Memo], Error> { promise in
                get { result in
                    switch result {
                    case .success(let memoList):
                        promise(.success(memoList))
                    case .failure(let error):
                        promise(.failure(error))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    static func create(title: String, content: String) -> AnyPublisher<Memo, Error> {
        return Future<Void, Error> { promise in
            validAccountStatus { result in
                switch result {
                case .success:
                    promise(.success(()))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .flatMap { _ in
            Future<Memo, Error> { promise in
                create(title: title, content: content) { result in
                    switch result {
                    case .success(let memo):
                        promise(.success(memo))
                    case .failure(let error):
                        promise(.failure(error))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    static func update(memo: Memo) -> AnyPublisher<Memo, Error> {
        return Future<Void, Error> { promise in
            validAccountStatus { result in
                switch result {
                case .success:
                    promise(.success(()))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .flatMap { _ in
            Future<Memo, Error> { promise in
                update(memo: memo) { result in
                    switch result {
                    case .success(let memo):
                        promise(.success(memo))
                    case .failure(let error):
                        promise(.failure(error))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    static func delete(recordName: String) -> AnyPublisher<String, Error> {
        return Future<Void, Error> { promise in
            validAccountStatus { result in
                switch result {
                case .success:
                    promise(.success(()))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .flatMap { _ in
            Future<String, Error> { promise in
                delete(recordName: recordName) { result in
                    switch result {
                    case .success(let recordName):
                        promise(.success(recordName))
                    case .failure(let error):
                        promise(.failure(error))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
