import UIKit
import AVKit

class CollectionViewCell: UICollectionViewCell {
    
    var player: AVQueuePlayer?
    var playerLayer: AVPlayerLayer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // No setup here, it's moved to configure(with:) method
    }
    
    func configure(with videoName: String) {
        guard let videoURL = Bundle.main.url(forResource: videoName, withExtension: "mp4") else {
            print("Video file not found")
            return
        }
        
        let asset = AVAsset(url: videoURL)
        let playerItem = AVPlayerItem(asset: asset)
        
        // Create an AVQueuePlayer with the playerItem
        player = AVQueuePlayer(playerItem: playerItem)
        
        // Create an AVPlayerLooper to loop the playerItem
        let looper = AVPlayerLooper(player: player!, templateItem: playerItem)
        
        // Set up the player and player layer
        setupPlayerAndLayer()
        
        // Start playing the video
        player?.play()
    }

    func setupPlayerAndLayer() {
        playerLayer?.removeFromSuperlayer()
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.frame = bounds
        playerLayer?.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer!)
    }

    @objc func loopVideo() {
        // Call setupPlayerAndLayer() after each loop iteration
        setupPlayerAndLayer()
        
        player?.seek(to: .zero)
        player?.play()
    }

    
    static func nib() -> UINib {
        return UINib(nibName: "CollectionViewCell", bundle: nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        player?.pause()
        playerLayer?.removeFromSuperlayer()
        player = nil
        playerLayer = nil
    }
}
