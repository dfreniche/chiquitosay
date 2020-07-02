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

        let sema = DispatchSemaphore( value: 0)
        
        let task = URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            do {
                if let data = data, let originalImage = NSImage(data: data) {
                    let imageWithText = originalImage.print(text: message)
                    let imageWithTextFile = try Folder.temporary.createFile(at: "tmp.png", contents: imageWithText.png)

                    Process.launch(command: "/usr/bin/open", arguments: ["\(imageWithTextFile.path)"])
                }
    
            } catch {
                print("Error creating file")
            }
            
            sema.signal() // signals the process to continue
                
            end = true
        };

        task.resume()
        
        while (!end) {
            sema.wait()
            print("...", separator: "", terminator: "")
            sema.signal()
        }
    }
}
