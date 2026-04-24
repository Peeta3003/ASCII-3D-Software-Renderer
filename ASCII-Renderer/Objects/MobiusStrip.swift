//
//  MobiusStrip.swift
//  ASCII-Renderer
//
//  Created by Petr Vodák on 24.04.2026.
//

import Foundation

let mobiusStripMesh = makeMobiusStrip()

func makeMobiusStrip(
    radius: Double = 1.0,
    width: Double = 0.4,
    segments: Int = 128,
    strips: Int = 24
) -> Mesh {
    var vertices: [Vector3] = []
    var faces: [(Int, Int, Int)] = []

    for i in 0..<segments {
        let t = Double(i) / Double(segments) * 2.0 * .pi

        for j in 0..<strips {
            let s = (Double(j) / Double(strips) - 0.5) * width

            let x = (radius + s * cos(t / 2)) * cos(t)
            let y = (radius + s * cos(t / 2)) * sin(t)
            let z = s * sin(t / 2)

            vertices.append(Vector3(x: x, y: y, z: z))
        }
    }

    for i in 0..<segments {
        let nextI = (i + 1) % segments

        for j in 0..<strips - 1 {
            let a = i * strips + j
            let b = nextI * strips + j
            let c = nextI * strips + (j + 1)
            let d = i * strips + (j + 1)

            faces.append((a, b, c))
            faces.append((a, c, d))
        }
    }

    return Mesh(vertices: vertices, edges: nil, faces: faces)
}
