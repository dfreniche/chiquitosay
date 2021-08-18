import AppKit
import Foundation
import ANSITerminal
import Files

struct ChiquitoSay {
    let imageURL: URL
    let message: String

    func alAtaqueerl() {
        print("Downloading \( imageURL ) ...".blue)
        var end = false

        let sema = DispatchSemaphore( value: 1) // just one concurrent operation at a time
        
        let task = URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            sema.wait() // decrement semaphore, no more operations at the time

            do {
                if let data = data, let originalImage = NSImage(data: data) {
                    let imageWithText = originalImage.print(text: message)
                    let imageWithTextFile = try Folder.temporary.createFile(at: "tmp.png", contents: imageWithText.png)

                    Process.launch(command: "/usr/bin/open", arguments: ["\(imageWithTextFile.path)"])
                }
    
            } catch {
                print("Error creating file")
            }
            
            sema.signal() // increment, done with this semaphore
            end = true
        };

        task.resume() // launch task
        
        // show ASCII animation while downloading
        let animation = ["|", "/", "-", "\\"]
        var animationIndex = 0
        while (!end) {
            print("\(animation[animationIndex])\r", separator: "", terminator: "")

            if animationIndex < animation.count - 1 {
                animationIndex = animationIndex + 1
            } else {
                animationIndex = 0
            }
        }
        
        print("\r  ")
    }
}
