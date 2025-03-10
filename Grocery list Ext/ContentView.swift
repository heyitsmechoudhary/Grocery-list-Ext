//
//  ContentView.swift
//  Grocery List Ext
//
//  Created by Rahul Choudhary on 30/01/25.
//

import SwiftUI
import SwiftData
import TipKit

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State private var item : String = ""
    @FocusState private var isFocused: Bool
    
    let buttonTip = ButtonTip()
    
    init() {
        try? Tips.configure()
    }
    
    func addEssentialFoods() {
        modelContext.insert(Item(title: "Bread and Butter", isCompleted: Bool.random()))
        modelContext.insert(Item(title: "Peanut Butter", isCompleted: Bool.random()))
        modelContext.insert(Item(title: "Sugar", isCompleted: Bool.random()))
        modelContext.insert(Item(title: "Cheese", isCompleted: Bool.random()))
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(items) { item in
                    Text(item.title)
                        .font(.title.weight(.light))
                        .padding(.vertical, 2)
                        .foregroundStyle(item.isCompleted == false ? Color.primary : Color.accentColor)
                        .strikethrough(item.isCompleted)
                        .italic(item.isCompleted)
                        .swipeActions{
                            Button(role: .destructive){
                                withAnimation{
                                    modelContext.delete(item)
                                }
                            }label:{
                                Label("Delete", systemImage: "trash")
                            }
                        }
                        .swipeActions(edge:.leading){
                            Button("Done", systemImage: item.isCompleted == false ? "checkmark.circle" : "x.circle"){
                                item.isCompleted.toggle()
                            }
                            .tint(item.isCompleted == false ? .green : .accentColor)
                        }
                }
            }
            .navigationBarTitle("Grocery List")
            
            .toolbar {
                if items.isEmpty {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            addEssentialFoods()
                        } label: {
                            Image(systemName: "carrot")
                        }
                        .popoverTip(buttonTip)
                    }
                }
            }
            .overlay {
                if items.isEmpty {
                    ContentUnavailableView("Empty List", systemImage: "cart.circle", description: Text("Add your first item to the list."))
                }
            }
            .safeAreaInset(edge: .bottom){
                VStack(spacing:12){
                    TextField("",text:$item)
                        .textFieldStyle(.plain)
                        .padding(12)
                        .background(.tertiary)
                        .cornerRadius(12)
                        .font(.title.weight(.light))
                        .focused($isFocused)
                    
                    
                    Button{
                        guard !item.isEmpty else{
                            return
                        }
                        let newItem = Item(title: item,isCompleted: false)
                        modelContext.insert(newItem)
                        item = ""
                        isFocused = false
                    }label:{
                        Text("Save")
                            .font(.title2.weight(.medium))
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent).buttonBorderShape(.roundedRectangle).controlSize(.extraLarge)
                }
                .padding()
                .background(.bar)
            }

        }
    }
}

#Preview("Sample List") {
    let sampleData: [Item] = [
        Item(title: "Bread and Butter", isCompleted: Bool.random()),
        Item(title: "Peanut Butter", isCompleted: Bool.random()),
        Item(title: "Sugar", isCompleted: Bool.random()),
        Item(title: "Cheese", isCompleted: Bool.random())
    ]
    let container = try! ModelContainer(for: Item.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    
    for item in sampleData {
        container.mainContext.insert(item)
    }
    
    return ContentView()
        .modelContainer(container)
}

#Preview("Empty List") {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
