import Foundation
import ANSITerminal
import ArgumentParser

@main
struct MainChiquitoSay: ParsableCommand {
    @Flag(help: "Print a text banner instead of image")
    var printBanner = false
    
    @Flag(help: "Say text aloud")
    var sayText = false

    @Argument(help: "URL with the image to show")
    var imageURL: String
    
    @Argument(help: "The message to print")
    var message: String
    
    
    /// Main function, starting point
    func run() throws {
        print("ChiquitoSay starting".green)
        
        guard !message.isEmpty else {
            print("Error: message can't be empty")
            return
        }
        
        guard let url = URL(string: imageURL) else {
            print("Error: problem understanding URL \( imageURL )")
            return
        }

        // here we do all heavy lifting
        ChiquitoSay(imageURL: url, message: message).alAtaqueerl()
        
        if printBanner {
            Banner.print(message: message)
        }
        
        if sayText {
            Process.launch(command: "/usr/bin/say", arguments: [message])
        }
    }
}
