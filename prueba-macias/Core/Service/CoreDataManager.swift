//
//  CoreDataManager.swift
//  prueba-macias
//
//  Created by Jonathan Macias on 2/5/22.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    private let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "posts")
        setupDatabase()
    }
    
    private func setupDatabase() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("error en leer: \(desc) error \(error)")
            }
            print("DATABASE READY")
        }
    }
    func addPost(posts: [Post]) {
        let context = container.viewContext
        for postTmp in posts {
            let newPost = NSEntityDescription.insertNewObject(forEntityName: "CorePost", into: context)
            newPost.setValue(postTmp.title, forKey: "title")
            newPost.setValue(postTmp.body, forKey: "body")
            newPost.setValue(postTmp.id, forKey: "id")
            newPost.setValue(postTmp.userID, forKey: "userID")
            do {
                try context.save()
                print("POST GUARDADO")
            } catch {
                print("ERROR \(error)")
            }
        }
    }
    
    func fetchPosts() -> [Post]? {
        let fetchRequest : NSFetchRequest<CorePost> = CorePost.fetchRequest()
        do {
            var posts: [Post] = []
            let result = try container.viewContext.fetch(fetchRequest)
            for res in result {
                let post = Post(userID: Int(res.userID), id: Int(res.id), title: res.title, body: res.body, isFavorite: res.isFavorite)
                if res.isFavorite {
                    posts.insert(post, at: 0)
                } else {
                    posts.append(post)
                }
            }
            return posts
            } catch {
                print("El error obteniendo usuario(s) \(error)")
                return nil
             }
    }
    
    func updateFavorite(postId: Int16, isFavorite: Bool) {
        let post: CorePost!
        let context = container.viewContext
        let fetchPost: NSFetchRequest<CorePost> = CorePost.fetchRequest()
        fetchPost.predicate = NSPredicate(format: "id = %@", argumentArray: [postId])
        let results = try? context.fetch(fetchPost)
        // UPDATE POST
        post = results?.first
        post.isFavorite = !isFavorite
        do {
            try context.save()
            print("FAVORITO ACTUALIZADO")
        } catch {
            print("ERROR \(error)")
        }
    }
    
    func deleteAllPost() {
        let context = container.viewContext
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "CorePost")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do
        {
            try context.execute(deleteRequest)
            try context.save()
            print("POSTS ELIMINADOS")
        }
        catch
        {
            print("ERROR \(error)")
        }
    }
}
