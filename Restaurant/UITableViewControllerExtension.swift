import UIKit

extension UITableViewController {
    func fitDetailLabels() {
        for cell in tableView.visibleCells {
            fitDetailLabel(in: cell)
        }
    }
    
    func fitDetailLabel(in cell: UITableViewCell) {
        guard let imageView = cell.imageView else { return }
        guard let textLabel = cell.textLabel else { return }
        guard let detailTextLabel = cell.detailTextLabel else { return }
        
        let imageWidth = imageView.frame.width
        let textWidth = textLabel.frame.width
        let detailWidth = detailTextLabel.frame.width
        let totalWidth = imageWidth + textWidth + detailWidth
        
        detailTextLabel.sizeToFit()
        imageView.frame.size.width = imageWidth
        
        let newDetailWidth = detailTextLabel.frame.width
        let newTextWidth = totalWidth - imageWidth - newDetailWidth
        guard newTextWidth < textWidth else { return }
        
        textLabel.frame.size.width = newTextWidth
        textLabel.adjustsFontSizeToFitWidth = true
        detailTextLabel.frame.origin.x -= newDetailWidth - detailWidth
    }
    
    func fitImage(in cell: UITableViewCell) {
        guard let imageView = cell.imageView else { return }
        let oldWidth = imageView.frame.width
        
        imageView.frame.size = CGSize(width: 100, height: 100)
        imageView.layer.cornerRadius = 50
        imageView.layer.masksToBounds = true
        
        let leftShift = oldWidth - imageView.frame.width
        guard let textLabel = cell.textLabel else { return }

        textLabel.frame.origin.x -= leftShift        
    }
}
