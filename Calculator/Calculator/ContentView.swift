//
//  ContentView.swift
//  Calculator
//
//  Created by Krishna Gunjal on 01/12/21.
//

import SwiftUI

class GlobalEnvironment: ObservableObject {
    @Published var display = "00"
    
    func receiveData(calculatorButton: calcButton) {
        self.display = calculatorButton.title
    }
}

enum CalcButtons: String {
    case zero, one, two, three, four, five, six, seven, eight, nine
    case equals, plus, minus, multiply, divide
    case decimal
    case ac, plusminus, percent
    
    var title: String {
        switch self {
        case .zero: return "0"
        case .one: return "1"
        case .two: return "2"
        case .three: return "3"
        case .four: return "4"
        case .five: return "5"
        case .six: return "6"
        case .seven: return "7"
        case .eight: return "8"
        case .nine: return "9"
        case .plus: return "+"
        case .minus: return "-"
        case .multiply: return "X"
        case .plusminus: return "+/-"
        case .percent: return "%"
        case .equals: return "="
        case .decimal: return "."
        default:
            return "AC"
        }
    }
    
    
    var backgroundColor: Color {
        switch self {
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine:
            return Color(.darkGray)
        case .ac, .plusminus, .percent:
            return Color(.lightGray)
        default:
            return Color(.orange)
        }
    }
    
}

struct ContentView: View {
    @EnvironmentObject var env: GlobalEnvironment
    
    
    
    let buttons: [[CalcButtons]] = [
        [.ac, .plusminus, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .decimal, .equals]
    ]
    
    var body: some View {
        
        ZStack(alignment: .bottom){
            Color.black.edgesIgnoringSafeArea(.all)
            VStack(spacing: 12){
                //Textfield
                HStack{
                    Spacer()
                    Text(env.display)
                        .foregroundColor(.white)
                        .font(.system(size: 64))
                    
                }.padding()
                
                //buttons
                ForEach(buttons, id:\.self){row in
                    HStack(spacing: 12){
                        ForEach(row, id:\.self){button in
                            Button(action: {
                                self.env.receiveData(calculatorButton: button)
                                
                            }){Text(button.title)
                                .font(.system(size: 32))
                                .frame(width: self.buttonWidth(button: button), height: (UIScreen.main.bounds.width - 5 * 12) / 4 )
                                .foregroundColor(.white)
                                .background(button.backgroundColor)
                                .cornerRadius(self.buttonWidth(button: button))
                            }
                        }
                    }
                }
            }.padding(.bottom)
        }
    }
    func buttonWidth(button: CalcButtons) -> CGFloat {
        if (button == .zero) {
            return (UIScreen.main.bounds.width - 4 * 12) / 4 * 2
        }
        //5 Gaps in 12 buttons
        return (UIScreen.main.bounds.width - 5 * 12) / 4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(GlobalEnvironment())
    }
}
