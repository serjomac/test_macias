//
//  HomeVC.swift
//  prueba-macias
//
//  Created by Jonathan Macias on 1/5/22.
//

import UIKit

class HomeVC: UIViewController {
    
    // MARK: -OULETS
    @IBOutlet weak var PostsTableView: UITableView!
    @IBOutlet weak var scPosts: UISegmentedControl!
    
    fileprivate var dataSource = PostDataSource()
    fileprivate var delegate = PostTableDelegate()
    var coreManager = CoreDataManager()
    var postService = PostService()
    
    var postList: [Post]?
    var favoriteList: [Post]?
    
    var rowsToDisplay: [Post]? {
        didSet {
            dataSource.posts = self.rowsToDisplay
            delegate.posts = self.rowsToDisplay
            delegate.vc = self
            PostsTableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        PostsTableView.rowHeight = UITableView.automaticDimension
        PostsTableView.estimatedRowHeight = 200
        delegate.postDelegate = self
        PostsTableView.dataSource = dataSource
        PostsTableView.delegate = delegate
        scPosts.addTarget(self, action: #selector(handleSegmentChange), for: .valueChanged)
        getPost()
        // Do any additional setup after loading the view.
    }
    
    @objc
    fileprivate func handleSegmentChange() {
        setDisplayList()
    }
    
    func getPost() {
        print("OBTENIENDO POSTS....")
        if let corePost = self.coreManager.fetchPosts(), !corePost.isEmpty {
            self.postList = corePost
            self.addFavorites()
            self.setDisplayList()
        } else {
            postService.GetAllPost { postResp, error in
                guard let posts = postResp else {
                    print("ERROR: " + error.debugDescription)
                    return
                }
                self.postList = posts
                self.addFavorites()
                self.setDisplayList()
                self.coreManager.addPost(posts: self.postList!)
            }
        }
    }
    
    func addFavorites() {
        let favorites = self.postList?.filter({ item in
            item.isFavorite ?? false
        })
        if let favs = favorites {
            favoriteList = favs
        }
    }
    
    func setDisplayList() {
        switch scPosts.selectedSegmentIndex {
        case 0:
            rowsToDisplay = self.postList
        case 1:
            rowsToDisplay = self.favoriteList
        default:
            rowsToDisplay = self.postList
        }
    }
    
    // MARK: - OULETS
    @IBAction func actionReloadPosts(_ sender: Any) {
        getPost()
    }
    
    @IBAction func actionDeletePosts(_ sender: Any) {
        coreManager.deleteAllPost()
        rowsToDisplay = []
        postList = []
        favoriteList = []
    }
    
}

extension HomeVC: CommentsVCDeledate, PostTableDelegateDelegate {
    func selectPostRow(post: Post) {
        let comentVC = self.storyboard!.instantiateViewController(withIdentifier: "commentVC") as? CommentsVC
        comentVC?.post = post
        comentVC?.delegateCommentVC = self
        self.navigationController?.pushViewController(comentVC!, animated: true)
    }
    
    // METODO DELEGADO PARA ACTUALIAR POSTS
    func CommentsVCResponse(isUpdateData: Bool) {
        if isUpdateData {
            getPost()
        }
    }
    
    func deleteRow(post: Post) {
        print("SE ELIMINA EL POST")
    }
}
