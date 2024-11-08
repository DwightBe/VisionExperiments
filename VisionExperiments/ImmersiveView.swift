//
//  ImmersiveView.swift
//  VisionExperiments
//
//  Created by Dwight Benignus on 7/22/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
    var appData: AppData
    @State var totalTranslation: Double = 0.0
    @State var allowDragDown: Bool = false
    @State var currentYPos: Double = 0.0
    @State var isMovingUp: Bool = false
    @State var currentCount: Int = 0
    @State var discsFullyExtended: Bool = false
    @State var resetDiscs: Bool = false
    @State var cube: ModelEntity = ModelEntity( mesh: .generateBox(size: 0.26), materials: [SimpleMaterial(color: .white, isMetallic: true)])
    @State var circle: ModelEntity =  ModelEntity( mesh: .generatePlane(width: 0.22, depth: 0.22, cornerRadius: 0.22), materials: [SimpleMaterial(color: .white, isMetallic: true)])
    @State var circle2: ModelEntity =  ModelEntity( mesh: .generatePlane(width: 0.22, depth: 0.22, cornerRadius: 0.22), materials: [SimpleMaterial(color: .blue, isMetallic: true)])
    
    var body: some View {
        VStack {
            RealityView { content in
                
                cube.scale = [1, 1, 1]
                cube.position.z = -1
                cube.position.y = 0.5
                cube.position.x = 0.5
                cube.generateCollisionShapes(recursive: false)
                cube.components.set(InputTargetComponent())
                cube.components[PhysicsMotionComponent.self] = .init()
                cube.name = "iCube"
            
                circle.position.y = 0.5
                circle.position.x = 0.5
                circle.position.z = -1
                circle.transform.rotation = simd_quatf(angle: Float.pi/2, axis: SIMD3<Float>(1, 0, 0))
                circle.name = "iCircle"
                let phoneMesh = MeshResource.generateText("\(appData.contactsArray[appData.count].phoneNumber)", extrusionDepth: 0.001, font: .boldSystemFont(ofSize: 0.02))
                /*
                 generateText(textString,
                    extrusionDepth: depthVar,
                    font: fontVar,
                    containerFrame: containerFrameVar,
                    alignment: alignmentVar,
                    lineBreakMode: lineBreakModeVar)
                 */
                let phoneText = ModelEntity(mesh: phoneMesh)
                phoneText.name = "phoneText"
                phoneText.position.x = -0.08
                phoneText.position.z = 0.01
                phoneText.transform.rotation = simd_quatf(angle: 3 * (Float.pi/2), axis: SIMD3<Float>(1, 0, 0))
                phoneText.model?.materials = [UnlitMaterial(color: .white)]
                
                circle.addChild(phoneText)

                circle2.position.y = 0.5
                circle2.position.x = 0.5
                circle2.position.z = -1
                circle2.transform.rotation = simd_quatf(angle: Float.pi/2, axis: SIMD3<Float>(1, 0, 0))
                circle2.name = "iCircle2"
                
                let emailMesh = MeshResource.generateText("\(appData.contactsArray[appData.count].email)", extrusionDepth: 0.001, font: .boldSystemFont(ofSize: 0.015))
                let emailText = ModelEntity(mesh: emailMesh)
                emailText.name = "emailText"
                emailText.position.x = -0.1
                emailText.position.z = 0.01
                emailText.transform.rotation = simd_quatf(angle: 3 * (Float.pi/2), axis: SIMD3<Float>(1, 0, 0))
                emailText.model?.materials = [UnlitMaterial(color: .white)]
                
                circle2.addChild(emailText)
                                          
                content.add(circle)
                content.add(circle2)
                content.add(cube)
              
            }
            update: { content in
                
                let contact = appData.count >= 0 ? appData.contactsArray[appData.count]: appData.contactsArray[appData.contactsArray.count + appData.count]
                let phoneText = content.entities.first { entity in
                    entity.name == "iCircle"
                }?.children.first?.findEntity(named: "phoneText") as! ModelEntity
               
                let phoneMesh = MeshResource.generateText("\(contact.phoneNumber)", extrusionDepth: 0.001, font: .boldSystemFont(ofSize: 0.02))
                phoneText.model?.mesh = phoneMesh
                
                let emailText = content.entities.first { entity in
                    entity.name == "iCircle2"
                }?.children.first?.findEntity(named: "emailText") as! ModelEntity
                let emailMesh = MeshResource.generateText("\(contact.email)", extrusionDepth: 0.001, font: .boldSystemFont(ofSize: 0.017))
                emailText.model?.mesh = emailMesh
             
            }
            .gesture(tapGesture)
        }
      
    }
    
    var tapGesture: some Gesture {
        TapGesture(count: 1)
            .targetedToAnyEntity()
            .onEnded{ value in
                discsFullyExtended = false
                allowDragDown = false
                
                if discsFullyExtended {
                    return
                }
              
                circle.position.y = 0.5
                circle.scale = [1,1,1]
                circle2.position.x = 0.5
                circle2.scale = [1,1,1]

            }
            .simultaneously(with: dragGesture)
    }

    var longPress: some Gesture {
        LongPressGesture(minimumDuration: 0.4)
            .targetedToAnyEntity()
            .onEnded { value in
                value.entity.scale = [1.04, 1.04, 1.04]
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    value.entity.scale = [1, 1, 1]
                }
                
                if(resetDiscs){
                   
                    circle.position.y = 0.5
                    circle.scale = [1,1,1]
            
                    circle2.position.x = 0.5
                    circle2.scale = [1,1,1]
                    
                    resetDiscs = false
                }
                allowDragDown = true
            }

        }
    
   
    var dragGesture: some Gesture {
        DragGesture()
            .targetedToAnyEntity()
            .onChanged{ value in
                if(!allowDragDown){
                    /*
                    if(discsFullyExtended){
                        if let circle = value.entity.parent?.findEntity(named: "iCircle"){
                            circle.position.y = 0.5
                            circle.scale = [1,1,1]
                        }
                        
                        if let circle2 = value.entity.parent?.findEntity(named: "iCircle2"){
                            circle2.position.x = 0.5
                            circle2.scale = [1,1,1]
                        }
                    }
                     */
                    
                    value.entity.transform.rotation = simd_quaternion(Float((value.translation3D.x/54)*(Double.pi/2)), simd_float3(x:0,y:1, z:0))
                }
                
                
                // if dragging up or down
                if(currentYPos == 0.0){
                    currentYPos = value.location3D.y
                    resetDiscs = true
                } else if(value.location3D.y > currentYPos) {
                    isMovingUp = false
                    currentYPos = value.location3D.y
                } else if(value.location3D.y < currentYPos) {
                    isMovingUp = true
                    currentYPos = value.location3D.y
                }
                

                if(allowDragDown) {
 
                    if(circle.position.y > 0.8) {
                        circle.position.y = 0.8
                    }
                    if(circle.position.y < 0.5) {
                        circle.position.y = 0.5
                    }
                    if(circle.scale.x > 1.4) {
                        circle.scale = [1.4, 1.4, 1.4]
                    }
                    if(circle.scale.x < 1) {
                        circle.scale = [1, 1, 1]
                    }
                    if(circle.position.y <= 0.8 && circle.position.y >= 0.5){
                        circle.position.y += (!isMovingUp ? 0.03 : -0.03)
                        if(circle.scale.x >= 1 && circle.scale.x <= 1.4) {
                            circle.scale += (!isMovingUp ? 0.05 : -0.05)
                        }
                    }
                    
                    discsFullyExtended = (circle.position.y > 0.78) ? true : false
                    
                    if(circle2.position.x > 0.8) {
                        circle2.position.x = 0.8
                    }
                    if(circle2.position.x < 0.5 ) {
                        circle2.position.x = 0.53
                    }
                    if(circle2.scale.x > 1.4) {
                        circle2.scale = [1.4, 1.4, 1.4]
                    }
                    if(circle2.scale.x < 1) {
                        circle2.scale = [1, 1, 1]
                    }
                    if(circle2.position.x <= 0.8 && circle2.position.x >= 0.5){
                        circle2.position.x += (!isMovingUp ? 0.03 : -0.03)
                        if(circle2.scale.x >= 1 && circle2.scale.x <= 1.4) {
                            circle2.scale += (!isMovingUp ? 0.05 : -0.05)
                        }
                    }
            
                  
                    
                        /*
                        if((value.translation3D.y - 10) <= 50){
                            circle2.position.x += 0.01 * (Float(value.translation3D.y - 10)/50)
                        }
                         */

                
                }
            }
            .onEnded { value in
                if(value.translation3D.x != 0 && !allowDragDown){
                    let currentTranslation = value.translation3D.x
                    print(currentTranslation)
                    totalTranslation += currentTranslation
                    let newCount = Int(round(totalTranslation/54))
                    appData.count = newCount
                    totalTranslation = Double(newCount) * 54
                    
                    value.entity.transform.rotation = simd_quaternion(Float((Double(newCount))*(Double.pi/2)), simd_float3(x:0,y:1, z:0))
                    
                }
                
                currentYPos = 0.0
                allowDragDown = false
                
                if discsFullyExtended {
                    return
                }
                circle.position.y = 0.5
                circle.scale = [1,1,1]
                circle2.position.x = 0.53
                circle2.scale = [1,1,1]
                
            
            }
            .simultaneously(with: longPress)
    }
    
  }

#Preview {
    ImmersiveView(appData: AppData())
}
