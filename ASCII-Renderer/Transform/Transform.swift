//
//  Transform.swift
//  ASCII-Renderer
//
//  Created by Petr Vodák on 07.04.2026.
//

import Foundation

func rotateY(_ v: Vector3, theta: Double) -> Vector3 {
    let xRot = v.x*cos(theta) + v.z*sin(theta)
    let zRot = -v.x*sin(theta) + v.z*cos(theta)
    return Vector3(x: xRot, y: v.y, z: zRot)
}

func rotateX(_ v: Vector3, theta: Double) -> Vector3 {
    let yRot = v.y*cos(theta) + v.z*sin(theta)
    let zRot = -v.y*sin(theta) + v.z*cos(theta)
    return Vector3(x: v.x, y: yRot, z: zRot)
}
