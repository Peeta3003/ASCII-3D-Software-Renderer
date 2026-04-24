//
//  Wave.swift
//  ASCII-Renderer
//
//  Created by Petr Vodák on 24.04.2026.
//

import Foundation

let waveMesh = makeWave()

func makeWave(size: Int = 20, scale: Double = 0.2) -> Mesh {
    var vertices: [Vector3] = []
    var faces: [(Int, Int, Int)] = []

    for z in 0..<size {
        for x in 0..<size {
            let xf = Double(x - size/2) * scale
            let zf = Double(z - size/2) * scale

            let y = sin(xf * 2) * cos(zf * 2)

            vertices.append(Vector3(x: xf, y: y, z: zf))
        }
    }

    for z in 0..<size-1 {
        for x in 0..<size-1 {
            let i = z * size + x

            faces.append((i, i+1, i+size))
            faces.append((i+1, i+size+1, i+size))
        }
    }

    return Mesh(vertices: vertices, edges: nil, faces: faces)
}
