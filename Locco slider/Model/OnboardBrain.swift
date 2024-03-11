import Foundation

struct OnboardBrain{
    let onboardScreenData = [
        OnboardData(id: 1, heading: "DISCOVER", description: "your surroundings like never before", iconImage: "Map Arrow Up", backgroundImage: "slide1"),
        OnboardData(id: 2, heading: "LISTEN", description: "to exciting stories on the go", iconImage: "Headphones Round Sound",backgroundImage: "slide2"),
        OnboardData(id: 3, heading: "AUDIOS", description: "play in the exact right moment", iconImage: "Microphone",backgroundImage: "slide3")
    ]
    
    var currentPage = 0;    
}
