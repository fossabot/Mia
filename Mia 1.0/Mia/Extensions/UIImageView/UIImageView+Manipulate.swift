public extension UIImageView {
    
    public func clipToPolygon(corners: Int, file: String = #file, function: String = #function) {
        guard corners >= 3 else {
            Rosewood.Framework.print(framework: "Mia.Extensions", message: "\(file)\(function) corners must be >= 3")
            return
        }
        let radius = min(self.frame.width/2.0,self.frame.height/2.0)
        let center = CGPoint(x:self.bounds.width/2.0,y:self.bounds.height/2.0)
        let path = UIBezierPath()
        path.lineWidth = 1
        for index in 0...corners {
            let rad = (Double.pi / Double(corners) ) * Double(index * 2 + 1)
            print(rad * 180 / Double.pi)
            let drawPoint = CGPoint(x: center.x + radius * CGFloat(cos(rad)),
                                    y: center.y + radius * CGFloat(sin(rad)))
            if (index == 0) {
                path.move(to: drawPoint)
                
            } else if (index == corners  ) {
                path.close()
            } else {
                path.addLine(to: drawPoint)
            }
            
        }
        
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
        self.layer.masksToBounds = false
    }
}
