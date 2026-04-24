//
//  Icosphere.swift
//  ASCII-Renderer
//
//  Created by Petr Vodák on 07.04.2026.
//

import Foundation

let phi = (1.0 + sqrt(5.0)) / 2.0

let icosphereMesh = Mesh(
    // 12 Vertices
    vertices: [
        Vector3(x: -1, y:  phi, z:  0), Vector3(x:  1, y:  phi, z:  0),
        Vector3(x: -1, y: -phi, z:  0), Vector3(x:  1, y: -phi, z:  0),
        
        Vector3(x:  0, y: -1, z:  phi), Vector3(x:  0, y:  1, z:  phi),
        Vector3(x:  0, y: -1, z: -phi), Vector3(x:  0, y:  1, z: -phi),
        
        Vector3(x:  phi, y:  0, z: -1), Vector3(x:  phi, y:  0, z:  1),
        Vector3(x: -phi, y:  0, z: -1), Vector3(x: -phi, y:  0, z:  1)
    ].map { v in
        // Normalize them so the sphere has a radius of 1.0
        let length = sqrt(v.x*v.x + v.y*v.y + v.z*v.z)
        return Vector3(x: v.x/length, y: v.y/length, z: v.z/length)
    },
    edges: nil,
    // 20 Triangular Faces
    faces: [
        (0, 11, 5), (0, 5, 1), (0, 1, 7), (0, 7, 10), (0, 10, 11),
        (1, 5, 9), (5, 11, 4), (11, 10, 2), (10, 7, 6), (7, 1, 8),
        (3, 9, 4), (3, 4, 2), (3, 2, 6), (3, 6, 8), (3, 8, 9),
        (4, 9, 5), (2, 4, 11), (6, 2, 10), (8, 6, 7), (9, 8, 1)
    ]
)

