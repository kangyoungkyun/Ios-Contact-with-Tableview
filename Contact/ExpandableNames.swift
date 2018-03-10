//
//  ExpandableNames.swift
//  Contact
//
//  Created by MacBookPro on 2018. 3. 10..
//  Copyright © 2018년 MacBookPro. All rights reserved.
//

import Foundation

//펼쳐져 있는지 체크
struct ExpandableNames {
    var isExpanded: Bool
    var names: [Contact]
}


//좋아요 눌렀는지 채크
struct Contact {
    let name: String
    var hasFavorited: Bool
}
