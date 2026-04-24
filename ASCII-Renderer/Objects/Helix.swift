//
//  Helix.swift
//  ASCII-Renderer
//
//  Created by Petr Vodák on 24.04.2026.
//

import Foundation

let helixMesh = makeHelix()

func makeHelix(turns: Int = 3, segments: Int = 64, radius: Double = 1.0) -> Mesh {
    var vertices: [Vector3] = []
    var faces: [(Int, Int, Int)] = []

    for i in 0..<segments {
        let t = Double(i) / Double(segments) * Double(turns) * 2.0 * .pi

        let x = cos(t) * radius
        let y = sin(t) * radius
        let z = Double(i) * 0.05 - 1.0

        vertices.append(Vector3(x: x, y: y, z: z))
    }

    // simple line-strip triangulation (optional upgrade later)
    for i in 0..<segments-2 {
        faces.append((i, i+1, i+2))
    }

    return Mesh(vertices: vertices, edges: nil, faces: faces)
}
