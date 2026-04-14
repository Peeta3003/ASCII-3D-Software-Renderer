//
//  Diamond.swift
//  ASCII-Renderer
//
//  Created by Petr Vodák on 07.04.2026.
//

import Foundation

// 6 Vertices
let diamondVertices: [Vector3] = [
    Vector3(x:  0, y:  1.2, z:  0), // 0: Top
    Vector3(x:  0, y: -1.2, z:  0), // 1: Bottom
    Vector3(x: -1, y:  0,   z:  1), // 2: Front-Left
    Vector3(x:  1, y:  0,   z:  1), // 3: Front-Right
    Vector3(x:  1, y:  0,   z: -1), // 4: Back-Right
    Vector3(x: -1, y:  0,   z: -1)  // 5: Back-Left
]

// 8 Faces
let diamondFaces: [(Int, Int, Int)] = [
    (0, 2, 3), (0, 3, 4), (0, 4, 5), (0, 5, 2), // Upper half
    (1, 3, 2), (1, 4, 3), (1, 5, 4), (1, 2, 5) // Lower half
]
