//
//  CommentsVC.swift
//  prueba-macias
//
//  Created by Jonathan Macias on 2/5/22.
//

import UIKit

// MARK: -PROTOCOLOS
protocol CommentsVCDeledate
{
    func CommentsVCResponse(isUpdateData: Bool)
}

class CommentsVC: UIViewController {
    
    // MARK: - OULETS
    @IBOutlet weak var lblPostDescription: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblUserEmail: UILabel!
    @IBOutlet weak var lblUserPhone: UILabel!
    @IBOutlet weak var userWebsite: UILabel!
    @IBOutlet weak var tableComments: UITableView!
    @IBOutlet weak var btnAddFav: UIBarButtonItem!
    
    // MARK: - VARIABLES
    var post: Post?
    var postService = PostService()
    var dataSource = CommentDataSource()
    var delegate = CommentTableDelegate()
    var delegateCommentVC: CommentsVCDeledate?
    var coreManager = CoreDataManager()
    var user: User? {
        didSet {
            loadInfo()
        }
    }
    var comments: [Comment]? {
        didSet {
            self.dataSource.comments = self.comments
            tableComments.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        tableComments.rowHeight = UITableView.automaticDimension
        tableComments.estimatedRowHeight = 400
        tableComments.dataSource = dataSource
        tableComments.delegate = delegate
        
        if let post = self.post {
            loadDataPost()
            getUser(userId: post.userID)
            getCommentsByPost(postID: post.id)
        }
        // Do any additional setup after loading the view.
    }
    
    func loadInfo() {
        lblUserName.text = user?.username
        lblUserEmail.text = user?.email
        lblUserPhone.text = user?.phone
        userWebsite.text = user?.website
    }
    
    func loadDataPost() {
        lblPostDescription.text = post?.body
        if post?.isFavorite ?? false {
            btnAddFav.image? = UIImage(systemName: "star.fill")!
        } else {
            btnAddFav.image? = UIImage(systemName: "star")!
        }
    }

    func getCommentsByPost(postID: Int) {
        postService.GetCommentsByPost(postID: postID) { resp, error in
            guard let resp = resp else {
                return
            }
            self.comments = resp
        }
    }
    
    func getUser(userId: Int) {
        postService.GetUser(userId: userId) { userRes, error in
            guard let user = userRes else {
                return
            }
            self.user = user[0]
        }
    }
    
    // MARK: - ACTIONS
    @IBAction func actionAddFav(_ sender: Any) {
        coreManager.updateFavorite(postId: Int16(post!.id), isFavorite: post!.isFavorite ?? false)
        let isFavoriteTmp = post?.isFavorite ?? false
        post!.isFavorite = !isFavoriteTmp
        if post?.isFavorite ?? false {
            btnAddFav.image? = UIImage(systemName: "star.fill")!
        } else {
            btnAddFav.image? = UIImage(systemName: "star")!
        }
        self.delegateCommentVC?.CommentsVCResponse(isUpdateData: true)
        
    }
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
