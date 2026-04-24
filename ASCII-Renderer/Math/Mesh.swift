//
//  Mesh.swift
//  ASCII-Renderer
//
//  Created by Petr Vodák on 24.04.2026.
//

import Foundation

typealias Edge = (Int, Int)
typealias Face = (Int, Int, Int)

struct Mesh {
    let vertices: [Vector3]
    let edges: [Edge]?
    let faces: [Face]
}
