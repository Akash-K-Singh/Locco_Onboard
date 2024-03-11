import UIKit
import AVKit

class OnboardingController: UIViewController {
      
    var onboardBrain = OnboardBrain()
    
    @IBOutlet weak var iconView: UIView!
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var sliderControl: UIPageControl!
    
    @IBAction func skipPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "GoToHomeScreenBentobox", sender: self)
    }
        
    @IBAction func nextPressed(_ sender: UIButton) {
        onboardBrain.currentPage = sliderControl.currentPage
        let nextPage = min(onboardBrain.currentPage + 1, onboardBrain.onboardScreenData.count - 1)
        sliderControl.currentPage = nextPage
        if(onboardBrain.currentPage == onboardBrain.onboardScreenData.count - 2){
            nextButton.setTitle("Start", for: .normal)
        }
        if(onboardBrain.currentPage == onboardBrain.onboardScreenData.count - 1){
            performSegue(withIdentifier: "GoToHomeScreenBentobox", sender: self)
        } else {
            iconImage.image = UIImage(named: onboardBrain.onboardScreenData[onboardBrain.currentPage + 1].iconImage)
            headingLabel.text = onboardBrain.onboardScreenData[onboardBrain.currentPage + 1].heading
            descriptionLabel.text = onboardBrain.onboardScreenData[onboardBrain.currentPage + 1].description
        }
        previousButton.alpha = 1
        let nextIndexPath = IndexPath(item: nextPage, section: 0)
        myCollectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
    }
    
    @IBAction func previouspressed(_ sender: UIButton) {
        onboardBrain.currentPage = sliderControl.currentPage
        let previousPage = max(onboardBrain.currentPage - 1, 0)
        sliderControl.currentPage = previousPage
        if(onboardBrain.currentPage <= onboardBrain.onboardScreenData.count - 1){
            nextButton.setTitle("Next", for: .normal)
        }
        iconImage.image = UIImage(named: onboardBrain.onboardScreenData[onboardBrain.currentPage - 1].iconImage)
        headingLabel.text = onboardBrain.onboardScreenData[onboardBrain.currentPage - 1].heading
        descriptionLabel.text = onboardBrain.onboardScreenData[onboardBrain.currentPage - 1].description
        if(onboardBrain.currentPage == 1){
            previousButton.alpha = 0
        }
        let previousIndexPath = IndexPath(item: previousPage, section: 0)
        myCollectionView.scrollToItem(at: previousIndexPath, at: .centeredHorizontally, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sliderControl.currentPage = onboardBrain.currentPage
        sliderControl.numberOfPages = onboardBrain.onboardScreenData.count
        previousButton.alpha = 0
        nextButton.layer.cornerRadius = 20
        nextButton.layer.masksToBounds = true
        myCollectionView.isUserInteractionEnabled = false
        iconView.layer.cornerRadius = iconView.bounds.width/2
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        myCollectionView.register(CollectionViewCell.nib(), forCellWithReuseIdentifier: "CollectionViewCell")
                
                let layout = UICollectionViewFlowLayout()
                layout.scrollDirection = .horizontal
                myCollectionView.collectionViewLayout = layout
                myCollectionView.reloadData()
    }
}

extension OnboardingController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onboardBrain.onboardScreenData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        let videoName = onboardBrain.onboardScreenData[indexPath.item].backgroundVideo
        cell.configure(with: videoName)
        return cell
    }
}

extension OnboardingController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
}
