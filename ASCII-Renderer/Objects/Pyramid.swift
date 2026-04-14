//
//  Pyramid.swift
//  ASCII-Renderer
//
//  Created by Petr Vodák on 07.04.2026.
//

import Foundation

import Foundation

// Define Pyramid vertices
let pyramidVertices: [Vector3] = [
    Vector3(x:  0, y:  1, z:  0),  // 0: Top Apex
    Vector3(x: -1, y: -1, z:  1),  // 1: Front-Left Base
    Vector3(x:  1, y: -1, z:  1),  // 2: Front-Right Base
    Vector3(x:  1, y: -1, z: -1),  // 3: Back-Right Base
    Vector3(x: -1, y: -1, z: -1)   // 4: Back-Left Base
]

// Define Pyramid faces
let pyramidFaces: [(Int, Int, Int)] = [
    // Sides
    (0, 1, 2), // Front face
    (0, 2, 3), // Right face
    (0, 3, 4), // Back face
    (0, 4, 1), // Left face
    
    // Base (Two triangles to make a square)
    (1, 3, 2), // Base Tri 1
    (1, 4, 3)  // Base Tri 2
]
