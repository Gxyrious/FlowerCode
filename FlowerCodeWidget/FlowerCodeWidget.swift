//
//  FlowerCodeWidget.swift
//  FlowerCodeWidget
//
//  Created by 刘畅 on 2022/9/2.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct FlowerCodeWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        GeometryReader { _ in
            HStack {
                Image("usdz")
                    .resizable()
                    .frame(width: 105.513699, height: 158)
                    .offset(x: 30)
            }
        }
        .background(Color("grass"))
    }
}

@main
struct FlowerCodeWidget: Widget {
    let kind: String = "FlowerCodeWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            FlowerCodeWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("FlowerCodeWidget")
        .description("This is an example widget.")
    }
}

struct FlowerCodeWidget_Previews: PreviewProvider {
    static var previews: some View {
        FlowerCodeWidgetEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}