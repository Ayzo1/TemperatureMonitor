import Foundation

class ClimateCharacteristicsParser {
    
    static func parse(data: Data) -> ClimateCharacteristics {
        let multiplyer: Float = 255
        let secondByte = Float(data[1])
        let firstByte = Float(data[0])
        let temp = secondByte * multiplyer + firstByte
        
        let floatTemp = temp / 100
        
        return ClimateCharacteristics(temperature: floatTemp, humidity: Float(data[2]))
    }
}
