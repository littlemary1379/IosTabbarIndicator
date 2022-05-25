//
//  Tabbar.swift
//  UpperTabbar3
//
//  Created by onnoffcompany on 2022/05/10.
//

import UIKit

protocol PagingTabbarDelegate : AnyObject {
    func scrollToIndex(to index: Int)
}

@IBDesignable
class Tabbar: UIView {
        
    let testName = ["test1" , "test2" , "test3", "test4" , "test5" , "test6", "test7" , "test8" , "test9", "test10", "test11", "test12" , "test13", "test14" , "test15" , "test16", "test17" , "test18" , "test19", "test20"]
    
    @IBOutlet var tabbarView: UIView!
    @IBOutlet weak var tabbarCollectionView: UICollectionView!
    @IBOutlet weak var indicatorView: UIView!
    
    var indicatorLeadingConstraint : NSLayoutConstraint!
    private var view : UIView!
    
    weak var delegate : PagingTabbarDelegate?
    
    var indicatorViewWidthConstraint : NSLayoutConstraint!
    var indicatorViewLeadingConstraint : NSLayoutConstraint!

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        print("override init ?????")
        super.init(frame: frame)
        commonInit()
        setIndicator()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
        //setDelegate()
        setIndicator()
        
    }
    
    private func commonInit() {
        let bundle = Bundle(for: type(of: self))
        bundle.loadNibNamed("Tabbar", owner: self, options: nil)
        addSubview(tabbarView)
        initCollectionView()
        //setIndicator()
    }
    
    
    func initCollectionView() {
        print("initCollectionView")
        let bundle = Bundle(for: TabbarCell.self)
        let nib = UINib(nibName: "TabbarCell", bundle: bundle)
        tabbarCollectionView.dataSource = self
        tabbarCollectionView.delegate = self
        tabbarCollectionView.register(nib, forCellWithReuseIdentifier: "TabbarCell")
        
        let firstIndexPath = IndexPath(item: 0, section: 0)
        tabbarCollectionView.delegate?.collectionView?(tabbarCollectionView, didSelectItemAt: firstIndexPath)

        tabbarCollectionView.selectItem(at: firstIndexPath, animated: false, scrollPosition: .right)
        print("????")
                
    }
    
    private func setIndicator() {
        indicatorView.frame.size = CGSize(width: 120, height: 5)
        tabbarCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: [])
        print("set?")
        //todo
        //indicatorView.isHidden = true
        addSubview(indicatorView)
        
    }
    
    func scrollContent(indexPath : IndexPath) {
        tabbarCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        tabbarCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .right)
        
        guard let cell = tabbarCollectionView.cellForItem(at: indexPath) as? TabbarCell
        else {
            return;
        }
           
        delegate?.scrollToIndex(to: indexPath.row)

        NSLayoutConstraint.deactivate(constraints)

        let constraints : [NSLayoutConstraint];
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        constraints = [
            indicatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            indicatorView.heightAnchor.constraint(equalToConstant: 5),
            indicatorView.leadingAnchor.constraint(equalTo: cell.leadingAnchor),
            indicatorView.trailingAnchor.constraint(equalTo: cell.trailingAnchor),
            tabbarCollectionView.heightAnchor.constraint(equalToConstant: 60),
        ]
        
        NSLayoutConstraint.activate(constraints)
        UIView.animate(withDuration: 0.2) {
            self.layoutIfNeeded()
        }
    }

}

extension Tabbar : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TabbarCell", for: indexPath) as? TabbarCell else {
            fatalError("can't dequene Cell")
        }
        cell.tabbarLabel.text = testName[indexPath.row]
        cell.isSelected = false;
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = tabbarCollectionView.cellForItem(at: indexPath) as? TabbarCell
        else {
            return;
        }
           
        delegate?.scrollToIndex(to: indexPath.row)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        NSLayoutConstraint.deactivate(constraints)

        let constraints : [NSLayoutConstraint];
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        constraints = [
            indicatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            indicatorView.heightAnchor.constraint(equalToConstant: 5),
            indicatorView.leadingAnchor.constraint(equalTo: cell.leadingAnchor),
            indicatorView.trailingAnchor.constraint(equalTo: cell.trailingAnchor),
            tabbarCollectionView.heightAnchor.constraint(equalToConstant: 60),
        ]
        
        NSLayoutConstraint.activate(constraints)
        UIView.animate(withDuration: 0.2) {
            self.layoutIfNeeded()
        }

    }
}
