//
//  ClubViewController.swift
//  Czyste Auto
//
//  Created by Adrian Derdaś on 22/05/2023.
//

import UIKit
import SwiftUI

class SwiftUIClubViewController: UIHostingController<SwiftUIClubView> {
    required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder, rootView: SwiftUIClubView())
        }
    
}


