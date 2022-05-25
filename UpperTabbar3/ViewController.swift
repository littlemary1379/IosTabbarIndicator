//
//  ViewController.swift
//  UpperTabbar3
//
//  Created by onnoffcompany on 2022/05/10.
//

import UIKit

class ViewController: UIViewController{
    
    let testName = ["test1" , "test2" , "test3", "test4" , "test5" , "test6", "test7" , "test8" , "test9", "test10", "test11", "test12" , "test13", "test14" , "test15" , "test16", "test17" , "test18" , "test19", "test20"]

    @IBOutlet weak var tabbarContainer: Tabbar!
    
    @IBOutlet weak var contentCollectionView: UICollectionView!
    
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    

    var direction = -2
    var indexPath : Int = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        initDelegate()
        
        //테스트 오토레이아웃
        let cellWidth = UIScreen.main.bounds.width
        let cellHeight = contentCollectionView.bounds.height

        print(cellWidth)
        print(cellHeight)

        let layout = contentCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        
        //contentCollectionView.backgroundColor = .gray
        contentCollectionView.showsHorizontalScrollIndicator = false
        contentCollectionView.isPagingEnabled = true
        
        tabbarContainer.delegate = self
        //감속 설정?
        //contentCollectionView.decelerationRate = UIScrollViewDecelerationRateFast

    }
    
    func initDelegate() {
        contentCollectionView.dataSource = self
        contentCollectionView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

//컬렉션 뷰
extension ViewController : UICollectionViewDataSource, UICollectionViewDelegate, PagingTabbarDelegate {


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20;
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = contentCollectionView.dequeueReusableCell(withReuseIdentifier: "ContentCell", for: indexPath) as? ContentCell else {
            print("non connection?")
            fatalError("can't dequene Cell")
        }

        cell.backgroundColor = [.systemRed , .systemBlue , .systemCyan, .systemFill, .systemGray, .systemMint, .systemPink, .systemTeal , .systemBrown, .systemGray2, .systemGray3, .systemGray4, .systemGray5, .systemGray6 , .systemGreen , .systemIndigo, .systemOrange, .systemPurple, .systemYellow, .white][indexPath.row]

        return cell
    }
    
    func scrollToIndex(to index: Int) {
        let indexPath = IndexPath(item : index, section : 0)
        contentCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
}

//스크롤뷰
extension ViewController : UIScrollViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        let layout = self.contentCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing

        var offset = targetContentOffset.pointee
        var index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        var roundedIndex = round(index)
        
        print("----------------------")
        print(index)
        print(roundedIndex)

        if scrollView.contentOffset.x > targetContentOffset.pointee.x {
            print("floor ?")
            
            roundedIndex = round(index)
        } else if scrollView.contentOffset.x < targetContentOffset.pointee.x {
            print("cell ?")
            roundedIndex = ceil(index)
        } else {
            print("round ?")
            roundedIndex = round(index)
        }
        
        print("----------------------")
        print(roundedIndex)

        offset = CGPoint(x : roundedIndex * cellWidthIncludingSpacing, y : 0)

        targetContentOffset.pointee = offset
        
        tabbarContainer.scrollContent(indexPath: IndexPath(row: Int(roundedIndex), section: 0))
    }
}

