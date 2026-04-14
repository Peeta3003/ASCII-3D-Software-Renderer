//
//  main.swift
//  ASCII-Renderer
//
//  Created by Petr Vodák on 07.04.2026.
//

import Foundation

var theta: Double = 0

let renderer = Renderer()

while true {
    renderer.buffer = Array(repeating: Array(repeating: " ", count: renderer.width), count: renderer.height)
    renderer.zBuffer = Array(repeating: Array(repeating: -Double.infinity, count: renderer.width), count: renderer.height)
        
    
    let rotatedVertices = icoVertices.map { v -> Vector3 in
        var rotated = v
        rotated = rotateY(rotated, theta: theta)
        rotated = rotateX(rotated, theta: theta/2)
        return rotated
    }
    
    /*
    for edge in cubeEdges {
        renderer.drawLine(p0: rotatedVertices[edge.0], p1: rotatedVertices[edge.1])
    }
     */
     
    
    for face in icoFaces {
        renderer.drawTriangle(
            v0: rotatedVertices[face.0],
            v1: rotatedVertices[face.1],
            v2: rotatedVertices[face.2]
        )
    }
     
    
    // Move cursor to top-left to redraw
    print("\u{001B}[H", terminator: "")
 
    let frameString = renderer.buffer.map { $0.joined() }.joined(separator: "\n")
    print(frameString)
    
    theta += 0.05 // Rotation speed
    Thread.sleep(forTimeInterval: 0.05)
}
