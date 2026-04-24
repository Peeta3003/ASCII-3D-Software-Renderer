//
//  Torus.swift
//  ASCII-Renderer
//
//  Created by Petr Vodák on 24.04.2026.
//

import Foundation

let torusMesh = makeTorus()

func makeTorus(
    R: Double = 0.8,   // major radius (distance from center of tube to center of torus)
    r: Double = 0.4,   // minor radius (tube radius)
    segments: Int = 128,
    rings: Int = 64
) -> Mesh {

    var vertices: [Vector3] = []
    var faces: [(Int, Int, Int)] = []

    // 1. Generate vertices
    for i in 0..<rings {
        let theta = Double(i) / Double(rings) * 2.0 * .pi

        let cosTheta = cos(theta)
        let sinTheta = sin(theta)

        for j in 0..<segments {
            let phi = Double(j) / Double(segments) * 2.0 * .pi

            let cosPhi = cos(phi)
            let sinPhi = sin(phi)

            // torus equation
            let x = (R + r * cosPhi) * cosTheta
            let y = (R + r * cosPhi) * sinTheta
            let z = r * sinPhi

            vertices.append(Vector3(x: x, y: y, z: z))
        }
    }

    // 2. Generate faces (two triangles per quad)
    for i in 0..<rings {
        let nextI = (i + 1) % rings

        for j in 0..<segments {
            let nextJ = (j + 1) % segments

            let a = i * segments + j
            let b = nextI * segments + j
            let c = nextI * segments + nextJ
            let d = i * segments + nextJ

            faces.append((a, b, c))
            faces.append((a, c, d))
        }
    }

    return Mesh(vertices: vertices, edges: nil, faces: faces)
}
