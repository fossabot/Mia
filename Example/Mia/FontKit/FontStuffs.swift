//
//  FontStuffs.swift
//  Mia_Example
//
//  Created by Michael Hedaitulla on 10/4/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import Mia


class FontStuffs: UIViewController {

    @IBOutlet var stacks: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadFontKit()
        addLabels()
    }
    
    
    func loadFontKit()  {
        FontKit.Configuration.debugMode = true
        FontKit.Loader.load(bundle: Mia.bundle)
    }
    
    func addLabels()  {
        // Regular
        stacks.addArrangedSubview(generateLabel(style: .robotoBlack))
        stacks.addArrangedSubview(generateLabel(style: .robotoBlackItalic))
        stacks.addArrangedSubview(generateLabel(style: .robotoBold))
        stacks.addArrangedSubview(generateLabel(style: .robotoBoldItalic))
        stacks.addArrangedSubview(generateLabel(style: .robotoMedium))
        stacks.addArrangedSubview(generateLabel(style: .robotoMediumItalic))
        stacks.addArrangedSubview(generateLabel(style: .robotoRegular))
        stacks.addArrangedSubview(generateLabel(style: .robotoItalic))
        stacks.addArrangedSubview(generateLabel(style: .robotoLight))
        stacks.addArrangedSubview(generateLabel(style: .robotoLightItalic))
        stacks.addArrangedSubview(generateLabel(style: .robotoThin))
        stacks.addArrangedSubview(generateLabel(style: .robotoThinItalic))
        
        // Mono
        stacks.addArrangedSubview(generateLabel(style: .robotoMonoBold))
        stacks.addArrangedSubview(generateLabel(style: .robotoMonoBoldItalic))
        stacks.addArrangedSubview(generateLabel(style: .robotoMonoMedium))
        stacks.addArrangedSubview(generateLabel(style: .robotoMonoMediumItalic))
        stacks.addArrangedSubview(generateLabel(style: .robotoMonoRegular))
        stacks.addArrangedSubview(generateLabel(style: .robotoMonoItalic))
        stacks.addArrangedSubview(generateLabel(style: .robotoMonoLight))
        stacks.addArrangedSubview(generateLabel(style: .robotoMonoLightItalic))
        stacks.addArrangedSubview(generateLabel(style: .robotoMonoThin))
        stacks.addArrangedSubview(generateLabel(style: .robotoMonoThinItalic))
        
        // Condensed
        stacks.addArrangedSubview(generateLabel(style: .robotoCondensedBold))
        stacks.addArrangedSubview(generateLabel(style: .robotoCondensedBoldItalic))
        stacks.addArrangedSubview(generateLabel(style: .robotoCondensedRegular))
        stacks.addArrangedSubview(generateLabel(style: .robotoCondensedItalic))
        stacks.addArrangedSubview(generateLabel(style: .robotoCondensedLight))
        stacks.addArrangedSubview(generateLabel(style: .robotoCondensedLightItalic))
        
        // Slab
        stacks.addArrangedSubview(generateLabel(style: .robotoSlabBold))
        stacks.addArrangedSubview(generateLabel(style: .robotoSlabRegular))
        stacks.addArrangedSubview(generateLabel(style: .robotoSlabLight))
        stacks.addArrangedSubview(generateLabel(style: .robotoSlabThin))
    }
}





private func generateLabel(style: FontKit.Font) -> UILabel {
    let l = UILabel()
    l.text = style.rawValue
    l.font = style.of(size: 16)
    return l
}
