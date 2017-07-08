import UIKit

class BaseNibView: UIView, ViewNib {
    var viewNibName: String?
}

protocol ViewNib {}

extension ViewNib where Self: BaseNibView  {
    
    internal func setupView() {
        let view = viewFromNib()
        view.frame = self.bounds
        
        // Auto-layout stuff.
        view.autoresizingMask = [
            UIViewAutoresizing.flexibleWidth,
            UIViewAutoresizing.flexibleHeight
        ]
        
        // Show the view.
        self.addSubview(view)
    }
    
    internal func viewFromNib() -> UIView {
        let bundle = Bundle.main
        let nibName = viewNibName ?? String("\(self.classForCoder)")
        let nib = UINib(nibName: nibName!, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        return view
    }
}
