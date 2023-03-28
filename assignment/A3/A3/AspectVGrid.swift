//
//  AspectVGrid.swift
//  A3
//
//  Created by Leon Z on 2023-03-27.
//

import SwiftUI

struct AspectVGrid<Item, ItemView>: View where ItemView: View, Item: Identifiable {
    var items: [Item]
    var aspectRatio: CGFloat
    var content: (Item) -> ItemView
    var minWidth: CGFloat
    
    init(
        items: [Item],
        aspectRatio: CGFloat,
        minWidth: CGFloat,
        content: @escaping (Item) -> ItemView
    ){
        self.items = items
        self.aspectRatio = aspectRatio
        self.minWidth = minWidth
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                let width = widthThatFits(
                    itemCount: items.count,
                    in: geometry.size,
                    itemAspectRatio: aspectRatio
                )
                LazyVGrid(columns: [adaptiveGridItem(width: width)], spacing: 0) {
                    ForEach(items) { item in
                        content(item).aspectRatio(aspectRatio, contentMode: .fit)
                    }
                }
                Spacer()
            }
        }
    }
    
    private func adaptiveGridItem(width: CGFloat) -> GridItem {
        var gridItem = GridItem(.adaptive(minimum: max(width, minWidth)))
        gridItem.spacing = 0
        return gridItem
    }
    
    private func widthThatFits(itemCount: Int, in size: CGSize, itemAspectRatio: CGFloat) -> CGFloat {
        var columnCount = 1
        var rowCount = itemCount
        repeat {
            let itemWidth = size.width / CGFloat(columnCount)
            let itemHeight = itemWidth / itemAspectRatio
            if CGFloat(rowCount) * itemHeight < size.height {
                break
            }
            columnCount += 1
            rowCount = (itemCount + (columnCount - 1)) / columnCount
        } while columnCount < itemCount
        if columnCount > itemCount {
            columnCount = itemCount
        }
        print(size)
        return floor(size.width / CGFloat(columnCount))
    }
}
