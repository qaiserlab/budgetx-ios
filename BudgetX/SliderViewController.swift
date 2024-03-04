//
//  SliderViewController.swift
//  budgetx
//
//  Created by Kabylake on 12/02/24.
//

import UIKit

class SliderCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgImage: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UITextView!
    
    func setup(_ slide: SliderItem) {
        imgImage.image = slide.image
        lblTitle.text = slide.title
        lblDescription.text = slide.description
    }
}

var sliderItems: [SliderItem] = [
    SliderItem(image: UIImage(named: "Slide1")!, title: "Manage Your Budgeting", description: "Easy manage your income and expense into category."),
    SliderItem(image: UIImage(named: "Slide2")!, title: "Track Your Expense", description: "Easy tracking and find your most spending at."),
    SliderItem(image: UIImage(named: "Slide3")!, title: "Set Your Goal", description: "You can set goals for your income and expense.")
    
]

class SliderViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        pageControl.numberOfPages = sliderItems.count
        pageControl.currentPage = 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sliderItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderCell", for: indexPath) as! SliderCollectionViewCell
        cell.setup(sliderItems[indexPath.row])
        
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        pageControl.currentPage = Int(scrollView.contentOffset.x / width)
    }
    
}
