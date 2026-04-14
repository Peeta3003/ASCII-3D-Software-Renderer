//
//  Renderer.swift
//  ASCII-Renderer
//
//  Created by Petr Vodák on 07.04.2026.
//

import Foundation

final class Renderer {
    let width = 80
    let height = 40
    let scale: Double = 34
    let aspect: Double = 2
    
    var buffer: [[String]]
    var zBuffer: [[Double]]

    init() {
        buffer = Array(repeating: Array(repeating: " ", count: width), count: height)
        zBuffer = Array(repeating: Array(repeating: -Double.infinity, count: width), count: height)
    }

    func project(_ point: Vector3) -> Vector2 {
        // Perspective factor
        let distance = 3.0
        let factor = scale / (distance - point.z)
        
        // Map 3D x/y to 2D screen coords
        let x2D = Int((point.x * factor * aspect) + Double(width) / 2)
        let y2D = Int((point.y * factor) + Double(height) / 2)
        
        return Vector2(x: x2D, y: y2D)
    }

    func drawLine(p0: Vector3, p1: Vector3) {
        let v0 = project(p0)
        let v1 = project(p1)
        
        var x0 = v0.x, y0 = v0.y
        let x1 = v1.x, y1 = v1.y
        
        // Distance between the points
        let dx = abs(x1 - x0)
        let dy = -abs(y1 - y0)
        
        // Direction of the movement
        let sx = x0 < x1 ? 1 : -1
        let sy = y0 < y1 ? 1 : -1
        
        // Cumulative error term that decides when to move vertically vs hoirzonrally
        var err = dx + dy
        
        let steps = max(abs(x1 - x0), abs(y1 - y0))
        
        var x = Double(x0)
        var y = Double(y0)
        
        for i in 0...steps {
            let t = steps == 0 ? 0 : Double(i)/Double(steps)
            let z = p0.z + (p1.z - p0.z) * t
            
            let xi = Int(x)
            let yi = Int(y)
            if yi >= 0 && yi < height && xi >= 0 && xi < width {
                if z > zBuffer[yi][xi] {
                    zBuffer[yi][xi] = z
                    buffer[yi][xi] = "#"
                }
            }
            let e2 = 2*err
            if e2 >= dy { err += dy; x0 += sx; x += Double(sx) }
            if e2 <= dx { err += dx; y0 += sy; y += Double(sy) }
        }
    }
    
    func edgeFunction(_ a: Vector2, _ b: Vector2, _ c: Vector2) -> Double {
        return Double(c.x - a.x) * Double(b.y - a.y) - Double(c.y - a.y) * Double(b.x - a.x)
    }
    
    func drawTriangle(v0: Vector3, v1: Vector3, v2: Vector3) {
        let p0 = project(v0)
        let p1 = project(v1)
        let p2 = project(v2)
        
        // Bouding box
        let minX = max(0, min(p0.x, min(p1.x, p2.x)))
        let maxX = min(width-1, max(p0.x, max(p1.x, p2.x)))
        let minY = max(0, min(p0.y, min(p1.y, p2.y)))
        let maxY = min(height-1, max(p0.y, max(p1.y, p2.y)))
        
        let area = edgeFunction(p0, p1, p2)
        if area == 0 { return }
        
        // Compute face normal
        let ux = v1.x - v0.x
        let uy = v1.y - v0.y
        let uz = v1.z - v0.z
        
        let vx = v2.x - v0.x
        let vy = v2.y - v0.y
        let vz = v2.z - v0.z
        
        // Cross product
        let nx = uy*vz - uz*vy
        let ny = uz*vx - ux*vz
        let nz = ux*vy - uy*vx
        
        // Normalize
        var len = sqrt(nx*nx + ny*ny + nz*nz)
        let nnx = nx/len
        let nny = ny/len
        let nnz = nz/len
        
        for y in minY...maxY {
            for x in minX...maxX {
                let p = Vector2(x: x, y: y)
                
                let w0 = edgeFunction(p1, p2, p)
                let w1 = edgeFunction(p2, p0, p)
                let w2 = edgeFunction(p0, p1, p)
                
                if (w0 >= 0 && w1 >= 0 && w2 >= 0) ||
                   (w0 <= 0 && w1 <= 0 && w2 <= 0) {
                    // Normalize barycentric coords
                    let alpha = w0 / area
                    let beta = w1 / area
                    let gamma = w2 / area
                    
                    // Interpolate depth
                    let z =  alpha * v0.z + beta * v1.z + gamma * v2.z
                    
                    if z > zBuffer[y][x] {
                        zBuffer[y][x] = z
                        
                        // Light direction
                        let lx = 0.5, ly = -0.7, lz = 0.5
                        len = sqrt(lx*lx + ly*ly + lz*lz)
                        let nlx = lx / len
                        let nly = ly / len
                        let nlz = lz / len

                        
                        var L = nnx*nlx + nny*nly + nnz*nlz
                        L = max(L, 0)
                        L = pow(max(L, 0), 0.7)
                        
                        let chars = Array("'.:-=+*#%@")
                        let index = Int(L * Double(chars.count - 1))
                        
                        buffer[y][x] = String(chars[index])
                    }
                }
            }
        }
    }
}

