//
//  BinService.swift
//  MLAddCard
//
//  Created by Juan sebastian Sanzone on 6/2/19.
//

import Foundation

let GOLD_COLOR = UIColor(red:0.77, green:0.58, blue:0.35, alpha:1.0)
let PLATINUM_COLOR = UIColor(red:0.62, green:0.64, blue:0.64, alpha:1.0)
let BLACK_COLOR = UIColor(red:0.04, green:0.04, blue:0.04, alpha:1.0)

struct BinService {

    var cardBinColorsMap = BinStorage()

    mutating func initialize() {
        // Santander Rio
        cardBinColorsMap.put("544014", GOLD_COLOR);
        cardBinColorsMap.put("419551", GOLD_COLOR);
        cardBinColorsMap.put("458900", GOLD_COLOR);
        cardBinColorsMap.put("410719", GOLD_COLOR);
        cardBinColorsMap.put("523731", GOLD_COLOR);
        cardBinColorsMap.put("450995", GOLD_COLOR);

        cardBinColorsMap.put("433074", PLATINUM_COLOR);
        cardBinColorsMap.put("442015", PLATINUM_COLOR);
        cardBinColorsMap.put("530058", PLATINUM_COLOR);
        cardBinColorsMap.put("523916", PLATINUM_COLOR);
        cardBinColorsMap.put("487506", PLATINUM_COLOR);
        cardBinColorsMap.put("487221", PLATINUM_COLOR);

        cardBinColorsMap.put("553670", BLACK_COLOR);
        cardBinColorsMap.put("423985", BLACK_COLOR);
        cardBinColorsMap.put("433060", BLACK_COLOR);
        cardBinColorsMap.put("442014", BLACK_COLOR);
        cardBinColorsMap.put("407865", BLACK_COLOR);

        // Banco Ciudad
        cardBinColorsMap.put("433810", PLATINUM_COLOR);

        cardBinColorsMap.put("468531", BLACK_COLOR);

        // Banco Comafi
        cardBinColorsMap.put("525860", GOLD_COLOR);
        cardBinColorsMap.put("402786", GOLD_COLOR);

        cardBinColorsMap.put("402787", PLATINUM_COLOR);
        cardBinColorsMap.put("451696", PLATINUM_COLOR);
        cardBinColorsMap.put("404370", PLATINUM_COLOR);
        cardBinColorsMap.put("433807", PLATINUM_COLOR);

        // Banco Frances
        cardBinColorsMap.put("493715", GOLD_COLOR);
        cardBinColorsMap.put("472090", GOLD_COLOR);
        cardBinColorsMap.put("454070", GOLD_COLOR);
        cardBinColorsMap.put("454073", GOLD_COLOR);

        cardBinColorsMap.put("452405", PLATINUM_COLOR);
        cardBinColorsMap.put("485749", PLATINUM_COLOR);
        cardBinColorsMap.put("433831", PLATINUM_COLOR);

        cardBinColorsMap.put("470455", BLACK_COLOR);
        cardBinColorsMap.put("516585", BLACK_COLOR);

        // Banco Hipotecario
        cardBinColorsMap.put("430497", GOLD_COLOR);

        // Banco Patagonia
        cardBinColorsMap.put("422409", GOLD_COLOR);
        cardBinColorsMap.put("493770", GOLD_COLOR);
        cardBinColorsMap.put("450994", GOLD_COLOR);
        cardBinColorsMap.put("544312", GOLD_COLOR);
        cardBinColorsMap.put("376714", GOLD_COLOR);
        cardBinColorsMap.put("554791", GOLD_COLOR);
        cardBinColorsMap.put("528168", GOLD_COLOR);
        cardBinColorsMap.put("528169", GOLD_COLOR);

        cardBinColorsMap.put("433898", PLATINUM_COLOR);
        cardBinColorsMap.put("451451", PLATINUM_COLOR);
        cardBinColorsMap.put("469701", PLATINUM_COLOR);
        cardBinColorsMap.put("558642", PLATINUM_COLOR);
        cardBinColorsMap.put("521388", PLATINUM_COLOR);

        cardBinColorsMap.put("526396", BLACK_COLOR);
        cardBinColorsMap.put("527619", BLACK_COLOR);

        // Cencosud
        cardBinColorsMap.put("519767", GOLD_COLOR);
        cardBinColorsMap.put("557935", GOLD_COLOR);
        cardBinColorsMap.put("550218", GOLD_COLOR);

        cardBinColorsMap.put("559137", PLATINUM_COLOR);

        cardBinColorsMap.put("527104", BLACK_COLOR);
        cardBinColorsMap.put("512533", BLACK_COLOR);
        cardBinColorsMap.put("510541", BLACK_COLOR);

        // Banco Galicia
        cardBinColorsMap.put("493702", GOLD_COLOR);
        cardBinColorsMap.put("545652", GOLD_COLOR);
        cardBinColorsMap.put("452489", GOLD_COLOR);

        cardBinColorsMap.put("411436", PLATINUM_COLOR);
        cardBinColorsMap.put("523937", PLATINUM_COLOR);
        cardBinColorsMap.put("433830", PLATINUM_COLOR);

        cardBinColorsMap.put("550568", BLACK_COLOR);
        cardBinColorsMap.put("459354", BLACK_COLOR);

        // Banco Hsbc
        cardBinColorsMap.put("492137", GOLD_COLOR);
        cardBinColorsMap.put("455349", GOLD_COLOR);
        cardBinColorsMap.put("459474", GOLD_COLOR);

        cardBinColorsMap.put("425822", PLATINUM_COLOR);
        cardBinColorsMap.put("433851", PLATINUM_COLOR);
        cardBinColorsMap.put("425821", PLATINUM_COLOR);
        cardBinColorsMap.put("524930", PLATINUM_COLOR);

        cardBinColorsMap.put("465403", BLACK_COLOR);
        cardBinColorsMap.put("465494", BLACK_COLOR);

        // Banco ICBC
        cardBinColorsMap.put("454659", GOLD_COLOR);
        cardBinColorsMap.put("530841", GOLD_COLOR);

        //Banco Itau
        cardBinColorsMap.put("476606", GOLD_COLOR);

        cardBinColorsMap.put("451446", PLATINUM_COLOR);

        // Banco Supervielle
        cardBinColorsMap.put("420061", GOLD_COLOR);
        cardBinColorsMap.put("410855", GOLD_COLOR);
        cardBinColorsMap.put("455198", GOLD_COLOR);
        cardBinColorsMap.put("455141", GOLD_COLOR);
        cardBinColorsMap.put("455193", GOLD_COLOR);
        cardBinColorsMap.put("455194", GOLD_COLOR);

        cardBinColorsMap.put("410854", PLATINUM_COLOR);
        cardBinColorsMap.put("493768", PLATINUM_COLOR);
        cardBinColorsMap.put("433822", PLATINUM_COLOR);
        cardBinColorsMap.put("433846", PLATINUM_COLOR);

        // Banco Macro
        cardBinColorsMap.put("411087", GOLD_COLOR);
        cardBinColorsMap.put("532378", GOLD_COLOR);
        cardBinColorsMap.put("490791", GOLD_COLOR);
        cardBinColorsMap.put("550230", GOLD_COLOR);

        cardBinColorsMap.put("531407", PLATINUM_COLOR);
        cardBinColorsMap.put("469700", PLATINUM_COLOR);
        cardBinColorsMap.put("523758", PLATINUM_COLOR);

        cardBinColorsMap.put("515810", BLACK_COLOR);
        cardBinColorsMap.put("524233", BLACK_COLOR);
        cardBinColorsMap.put("527608", BLACK_COLOR);
        cardBinColorsMap.put("553649", BLACK_COLOR);
        cardBinColorsMap.put("469771", BLACK_COLOR);

        // Other
        cardBinColorsMap.put("377791", GOLD_COLOR);
        cardBinColorsMap.put("405071", PLATINUM_COLOR);
        cardBinColorsMap.put("469724", PLATINUM_COLOR);
        cardBinColorsMap.put("536087", PLATINUM_COLOR);
        cardBinColorsMap.put("466057", BLACK_COLOR);

        // MLA - Datadog
        cardBinColorsMap.put("532384", GOLD_COLOR);
        cardBinColorsMap.put("454642", GOLD_COLOR);
        cardBinColorsMap.put("482469", PLATINUM_COLOR);
        cardBinColorsMap.put("417006", BLACK_COLOR);

        // MLB - Datadog
        cardBinColorsMap.put("544731", GOLD_COLOR);
        cardBinColorsMap.put("523421", GOLD_COLOR);
        cardBinColorsMap.put("550209", GOLD_COLOR);
        cardBinColorsMap.put("516220", GOLD_COLOR);
        cardBinColorsMap.put("530034", GOLD_COLOR);
        cardBinColorsMap.put("453211", GOLD_COLOR);
        cardBinColorsMap.put("410863", GOLD_COLOR);
        cardBinColorsMap.put("549167", PLATINUM_COLOR);
        cardBinColorsMap.put("422061", PLATINUM_COLOR);
        cardBinColorsMap.put("515590", PLATINUM_COLOR);
        cardBinColorsMap.put("522840", BLACK_COLOR);

        // MLM - Datadog
        cardBinColorsMap.put("477213", GOLD_COLOR);
        cardBinColorsMap.put("542015", GOLD_COLOR);
        cardBinColorsMap.put("547046", GOLD_COLOR);
        cardBinColorsMap.put("549949", GOLD_COLOR);
        cardBinColorsMap.put("544204", GOLD_COLOR);
        cardBinColorsMap.put("477214", PLATINUM_COLOR);
    }

    func getColor(bin: String) -> UIColor {
        return cardBinColorsMap.getColor(bin)
    }
}

struct BinStorage {

    var gold = [String]()
    var platinum = [String]()
    var black = [String]()

    mutating func put(_ color: String, _ colorType: UIColor) {
        if colorType == GOLD_COLOR {
            gold.append(color)
            return
        }

        if colorType == BLACK_COLOR {
            black.append(color)
            return
        }

        if colorType == PLATINUM_COLOR {
            platinum.append(color)
            return
        }
    }

    func getColor(_ bin: String) -> UIColor {
        if gold.contains(bin) { return GOLD_COLOR }
        if black.contains(bin) { return BLACK_COLOR }
        if platinum.contains(bin) { return PLATINUM_COLOR }
        return UIColor(red:1.00, green:0.72, blue:0.00, alpha: 1)
        // return UIColor.lightGray //TODO: Default color for not found.
    }
}
