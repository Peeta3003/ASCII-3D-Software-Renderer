//
//  Cube.swift
//  ASCII-Renderer
//
//  Created by Petr Vodák on 07.04.2026.
//

import Foundation

let cubeMesh = Mesh(
    vertices: [
        Vector3(x: -1, y: -1, z: -1),
        Vector3(x:  1, y: -1, z: -1),
        Vector3(x:  1, y:  1, z: -1),
        Vector3(x: -1, y:  1, z: -1),
        Vector3(x: -1, y: -1, z:  1),
        Vector3(x:  1, y: -1, z:  1),
        Vector3(x:  1, y:  1, z:  1),
        Vector3(x: -1, y:  1, z:  1)
    ],
    edges: [
        (0, 1), (1, 2), (2, 3), (3, 0), // back face
        (4, 5), (5, 6), (6, 7), (7, 4), // front face
        (0, 4), (1, 5), (2, 6), (3, 7)  // connecting edges
    ],
    faces: [
        (4,5,6), (4,6,7), // Front
        (1,0,3), (1,3,2), // Back
        (0,4,7), (0,7,3), // Left
        (5,1,2), (5,2,6), // Right
        (3,2,6), (3,6,7), // Top
        (1,0,4), (1,4,5)  // Bottom
    ]
)
