import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var sliderImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
  static  func nib()->UINib{
        return UINib(nibName: "CollectionViewCell", bundle: nil)
    }

}
