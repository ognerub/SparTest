import UIKit
class DiagonalLineView: UIView {
    
    var startInset: CGFloat = 5
    var endIndet: CGFloat = 5
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if let context = UIGraphicsGetCurrentContext() {
            context.setStrokeColor(UIColor.blackColor.cgColor)
            context.setLineWidth(2.0)
            let startPoint = CGPoint(x: startInset, y: rect.height - endIndet * 1.3)
            let endPoint = CGPoint(x: rect.width - endIndet * 1.3, y: startInset)
            context.move(to: startPoint)
            context.addLine(to: endPoint)
            context.strokePath()
        }
    }
}
