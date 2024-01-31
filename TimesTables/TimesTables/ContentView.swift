//
//  ContentView.swift
//  TimesTables
//
//  Created by Anh Nguyen on 31/1/2024.
//

import SwiftUI

struct ContentView: View {
    let questionNumbers = [5, 10, 20]
    
    @State private var multiplicationTables: Set<Int> = Set([])
    @State private var numberOfQuestions: Int = 0
    @State private var started: Bool = false
    @State private var questions: [String] = [""]
    @State private var answers: [Int] = []
    @State private var answer: Int = 0
    @State private var currentQuestionNumber = 0
    @State private var score = 0
    @State private var over = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Text("Select multiplication tables to practice")
                    
                    HStack {
                        ForEach(2..<8) { table in
                            if multiplicationTables.contains(table) {
                                Button("\(table)") {
                                    multiplicationTables.remove(table)
                                }
                                .buttonStyle(.borderedProminent)
                            } else {
                                Button("\(table)") {
                                    multiplicationTables.insert(table)
                                }
                                .buttonStyle(.bordered)
                            }
                        }
                    }
                    
                    HStack {
                        ForEach(8..<13) { table in
                            if multiplicationTables.contains(table) {
                                Button("\(table)") {
                                    multiplicationTables.remove(table)
                                }
                                .buttonStyle(.borderedProminent)
                            } else {
                                Button("\(table)") {
                                    multiplicationTables.insert(table)
                                }
                                .buttonStyle(.bordered)
                            }
                        }
                    }
                    Text("Select number of questions")
                    HStack {
                        ForEach(questionNumbers, id: \.self) { number in
                            if number == numberOfQuestions {
                                Button("\(number)") {
                                    numberOfQuestions = 0
                                }
                                .buttonStyle(.borderedProminent)
                            } else {
                                Button("\(number)") {
                                    numberOfQuestions = number
                                }
                                .buttonStyle(.bordered)
                            }
                        }
                    }
                    Button("Start") {
                        started = true
                        generateQuestions()
                    }
                    .disabled(multiplicationTables.isEmpty || numberOfQuestions == 0)
                }
                .navigationTitle("TimesTables")
                .opacity(started ? 0 : 1)
                .animation(.linear, value: started)
                Form {
                    Section {
                        Text(questions[currentQuestionNumber])
                    }
                    Section("Enter answer:") {
                        TextField("", value: $answer, format: .number)
                            .keyboardType(.numberPad)
                    }
                }
                .opacity(started ? 1 : 0)
                .animation(.linear, value: started)
                .onSubmit {
                    
                    if answer == answers[currentQuestionNumber] {
                        score += 1
                    }
                    currentQuestionNumber += 1
                    if currentQuestionNumber == numberOfQuestions {
                        over = true
                        currentQuestionNumber = 0
                        score = 0
                    }
                    answer = 0
                }
            }
            .alert("Finished all questions", isPresented: $over) {
                Button("Restart") {
                    started = false
                    multiplicationTables.removeAll()
                    numberOfQuestions = 0
                }
            } message: {
                Text("Your final score was \(score)")
            }
        }
    }
    
    func generateQuestions() {
        questions.removeAll()
        answers.removeAll()
        for _ in 1...numberOfQuestions {
            let num1 = multiplicationTables.randomElement() ?? 1
            let num2 = Int.random(in: 1...12)
            questions.append("What is \(num1) x \(num2)?")
            answers.append(num1 * num2)
        }
    }
}

#Preview {
    ContentView()
}
