//
//  WidgetExBundle.swift
//  WidgetEx
//
//  Created by ios-m2 on 01/06/23.
//

import WidgetKit
import SwiftUI

@main
struct WidgetExBundle: WidgetBundle {
    var body: some Widget {
        PizzaDeliveryActivityWidget()
        PizzaAdActivityWidget()
    }
}

struct PizzaDeliveryActivityWidget: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: PendingDeliveryAttributes.self) { context in
            // For devices that don't support the Dynamic Island.
            VStack(alignment: .leading) {
                HStack {
                    NetworkImage(url: URL(string: "https://argylewinery.com/wp-content/uploads/2017/07/female-placeholder.png"))
                    Divider()
                    Image("ic_cc")
                        .frame(width: 50, height: 50)
                    Spacer()
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 50, height: 50)
                }
                HStack {
                    Group{
                        Text(timerInterval: context.state.estimatedDeliveryTime, countsDown: true)
                            .foregroundColor(Color("#3F8A7E"))
                            .fontWeight(.bold) +
                        Text(" min").foregroundColor(Color("#3F8A7E"))
                            .fontWeight(.bold) +
                        Text(" until arrival").foregroundColor(Color.black)
                            .fontWeight(.bold)
                    }
                    Spacer()
                    Text("DH Patel")
                        .font(.system(size: 13))
                }
                HStack {
                    Text("Get Ready, DH is on his way!")
                        .font(.system(size: 14))
                    Spacer()
                    Text("Physical therapist")
                        .font(.system(size: 13))
                }
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.secondary)
                    HStack {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(.blue)
                            .frame(width: 50)
                        Image(systemName: "shippingbox.circle.fill")
                            .foregroundColor(.white)
                            .padding(.leading, -25)
                        Image(systemName: "arrow.forward")
                            .foregroundColor(.white.opacity(0.5))
                        Image(systemName: "ellipsis")
                            .foregroundColor(.white.opacity(0.5))
                        Spacer()
                        Image(systemName: "ellipsis")
                            .foregroundColor(.white.opacity(0.5))
                        Image(systemName: "arrow.forward")
                            .foregroundColor(.white.opacity(0.5))
                        Image(systemName: "house.circle.fill")
                            .foregroundColor(.green)
                            .background(.white)
                            .clipShape(Circle())
                    }
                }
            }.padding(15)
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    Text("\(context.attributes.numberOfPizzas) Pizzas")
//                    Label("\(context.attributes.numberOfPizzas) Pizzas", systemImage: "bag")
                        .font(.title2)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Label {
                        Text(timerInterval: context.state.estimatedDeliveryTime, countsDown: true)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 40)
                            .monospacedDigit()
                            .font(.caption2)
                    } icon: {
                        Image(systemName: "timer")
                            .resizable()
                            .frame(width: 20, height:20)
                    }
                    .font(.title2)
                }
                DynamicIslandExpandedRegion(.center) {
                    Text("\(context.state.driverName) is on the way!")
                        .lineLimit(1)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    // Deep Linking
                    Link(destination: URL(string: "pizza://TIM")!) {
                         Label("Contact doctor", systemImage: "phone.circle.fill").padding()
                     }.background(Color.accentColor)
                     .clipShape(RoundedRectangle(cornerRadius: 15))
                     .padding()
                    /*HStack {
                        Link(destination: URL(string: "pizza://TIM")!) {
                             Label("Contact driver", systemImage: "phone.circle.fill").padding()
                         }.background(Color.accentColor)
                         .clipShape(RoundedRectangle(cornerRadius: 15))
                        Spacer()
                        Link(destination: URL(string: "pizza://cancelOrder")!) {
                             Label("Cancel Order", systemImage: "xmark.circle.fill").padding()
                         }.background(Color.red)
                         .clipShape(RoundedRectangle(cornerRadius: 15))
                    }.padding()*/
                }
            } compactLeading: {
                Label {
                    Text("\(context.attributes.numberOfPizzas) Doctor")
                } icon: {
                    Image(systemName: "bag")
                }
                .font(.caption2)
            } compactTrailing: {
                Text(timerInterval: context.state.estimatedDeliveryTime, countsDown: true)
                    .multilineTextAlignment(.center)
                    .frame(width: 40)
                    .font(.caption2)
            } minimal: {
                VStack(alignment: .center) {
                    Image(systemName: "timer")
                    Text(timerInterval: context.state.estimatedDeliveryTime, countsDown: true)
                        .multilineTextAlignment(.center)
                        .monospacedDigit()
                        .font(.caption2)
                }
            }
            .keylineTint(.accentColor)
        }
    }
}

struct NetworkImage: View {

  public let url: URL?

  var body: some View {

    Group {
     if let url = url, let imageData = try? Data(contentsOf: url),
       let uiImage = UIImage(data: imageData) {

       Image(uiImage: uiImage)
             .resizable()
         .frame(width: 50, height: 50)
      }
      else {
       Image("placeholder-image")
      }
    }
  }

}

struct PizzaAdActivityWidget: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: PizzaAdAttributes.self) { context in
            HStack {
                let logo = UserDefaults(suiteName: "group.io.startway.iOS16-Live-Activities")?.data(forKey: "pizzaLogo")
                if (logo != nil) {
                    Image(uiImage: UIImage(data: logo!)!)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 64, height: 64)
                        .cornerRadius(15)
                }
                VStack(alignment: .leading) {
                    Text(context.state.adName).font(.caption).foregroundColor(.secondary)
                    Text("Get \(Text(context.attributes.discount).fontWeight(.black).foregroundColor(.blue)) OFF").bold().font(.system(size: 25)).foregroundColor(.secondary)
                    Text("when purchase 🍕 every $1,000 TODAY").font(.callout).italic()
                }
            }.padding()
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    Label(context.attributes.discount, systemImage: "dollarsign.arrow.circlepath")
                        .font(.title2)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Label {
                        Text("Ads")
                            .multilineTextAlignment(.trailing)
                            .frame(width: 50)
                            .monospacedDigit()
                            .font(.caption2)
                    } icon: {
                        Image(systemName: "dollarsign.circle.fill")
                    }
                    .font(.title2)
                }
                DynamicIslandExpandedRegion(.center) {
                    Text(context.state.adName)
                        .lineLimit(1)
                        .font(.caption)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Button {
                        // Deep link into the app.
                    } label: {
                        Label("Pay now", systemImage: "creditcard")
                    }
                }
            } compactLeading: {
                Label {
                    Text(context.attributes.discount)
                } icon: {
                    Image(systemName: "dollarsign.circle.fill")
                }
                .font(.caption2)
                .foregroundColor(.red)
            } compactTrailing: {
                Text("Due")
                    .multilineTextAlignment(.center)
                    .frame(width: 40)
                    .font(.caption2)
            } minimal: {
                VStack(alignment: .center) {
                    Image(systemName: "dollarsign.circle.fill")
                    Text(context.attributes.discount)
                        .multilineTextAlignment(.center)
                        .monospacedDigit()
                        .font(.caption2)
                }
            }
            .keylineTint(.accentColor)
        }
    }
}

// Preview available on iOS 16.2 or above
@available(iOSApplicationExtension 16.2, *)
struct PizzaDeliveryActivityWidget_Previews: PreviewProvider {
    static let activityAttributes = PendingDeliveryAttributes(numberOfPizzas: 2, totalAmount: "1000")
    static let activityState = PendingDeliveryAttributes.ContentState(driverName: "Tim", estimatedDeliveryTime: Date()...Date().addingTimeInterval(15 * 60))
    
    static var previews: some View {
        activityAttributes
            .previewContext(activityState, viewKind: .content)
            .previewDisplayName("Notification")
        
        activityAttributes
            .previewContext(activityState, viewKind: .dynamicIsland(.compact))
            .previewDisplayName("Compact")
        
        activityAttributes
            .previewContext(activityState, viewKind: .dynamicIsland(.expanded))
            .previewDisplayName("Expanded")
        
        activityAttributes
            .previewContext(activityState, viewKind: .dynamicIsland(.minimal))
            .previewDisplayName("Minimal")
    }
}

extension Color {
  init?(_ hex: String) {
    var str = hex
    if str.hasPrefix("#") {
      str.removeFirst()
    }
    if str.count == 3 {
      str = String(repeating: str[str.startIndex], count: 2)
        + String(repeating: str[str.index(str.startIndex, offsetBy: 1)], count: 2)
        + String(repeating: str[str.index(str.startIndex, offsetBy: 2)], count: 2)
    } else if !str.count.isMultiple(of: 2) || str.count > 8 {
      return nil
    }
    let scanner = Scanner(string: str)
    var color: UInt64 = 0
    scanner.scanHexInt64(&color)
    if str.count == 2 {
      let gray = Double(Int(color) & 0xFF) / 255
      self.init(.sRGB, red: gray, green: gray, blue: gray, opacity: 1)
    } else if str.count == 4 {
      let gray = Double(Int(color >> 8) & 0x00FF) / 255
      let alpha = Double(Int(color) & 0x00FF) / 255
      self.init(.sRGB, red: gray, green: gray, blue: gray, opacity: alpha)
    } else if str.count == 6 {
      let red = Double(Int(color >> 16) & 0x0000FF) / 255
      let green = Double(Int(color >> 8) & 0x0000FF) / 255
      let blue = Double(Int(color) & 0x0000FF) / 255
      self.init(.sRGB, red: red, green: green, blue: blue, opacity: 1)
    } else if str.count == 8 {
      let red = Double(Int(color >> 24) & 0x000000FF) / 255
      let green = Double(Int(color >> 16) & 0x000000FF) / 255
      let blue = Double(Int(color >> 8) & 0x000000FF) / 255
      let alpha = Double(Int(color) & 0x000000FF) / 255
      self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
    } else {
      return nil
    }
  }
}

