import UIKit
import AVKit

class CollectionViewCell: UICollectionViewCell {
    
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    var videoName: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Setup player and layer only if videoName is set
        if let videoName = videoName {
            setupPlayer(with: videoName)
        }
    }
    
    func setupPlayer(with videoName: String) {
        guard let videoURL = Bundle.main.url(forResource: videoName, withExtension: "mp4") else {
            print("Video file not found")
            return
        }
        
        let asset = AVAsset(url: videoURL)
        let playerItem = AVPlayerItem(asset: asset)
        
        player = AVPlayer(playerItem: playerItem)
        
        playerLayer?.removeFromSuperlayer()
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.frame = bounds
        playerLayer?.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer!)
        
        // Loop the video by observing AVPlayerItemDidPlayToEndTime notification
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: .AVPlayerItemDidPlayToEndTime, object: playerItem)
        
        // Start playing the video
        player?.play()
    }
    
    @objc func playerItemDidReachEnd() {
        // Seek back to the beginning to loop the video
        player?.seek(to: .zero, completionHandler: { _ in
            // Start playing the video again
            self.player?.play()
        })
    }
    
    func configure(with videoName: String) {
        // Store videoName and trigger layoutSubviews to setup player and layer
        self.videoName = videoName
        setNeedsLayout()
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "CollectionViewCell", bundle: nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // Pause player and remove layer
        player?.pause()
        playerLayer?.removeFromSuperlayer()
        
        // Remove videoName to prevent unwanted setup during reuse
        videoName = nil
        
        // Remove observer
        NotificationCenter.default.removeObserver(self)
    }
}
