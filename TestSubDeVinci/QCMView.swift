//
//  QCMView.swift
//  TestSubDeVinci
//
//  Created by COURS on 19/04/2024.
//

import Foundation
import SwiftUI

struct QCMView: View {
    let questions: [Question]
    @State private var currentQuestionIndex = 0
    @State private var selectedAnswerIndex: Int?
    @State private var score = 0
    @State private var hasFinished = false  // State to track if the quiz has finished

    var body: some View {
        VStack {
            if !hasFinished {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Question \(currentQuestionIndex + 1)/\(questions.count)")
                        .font(.headline)
                    Text(questions[currentQuestionIndex].statement)
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    ForEach(0..<questions[currentQuestionIndex].proposal.count, id: \.self) { index in
                        AnswerButton(text: questions[currentQuestionIndex].proposal[index], isSelected: .constant(selectedAnswerIndex == index)) {
                            self.selectedAnswerIndex = index
                        }
                    }
                    
                    HStack {
                        if currentQuestionIndex > 0 {
                            Button("Précédent") {
                                currentQuestionIndex -= 1
                                selectedAnswerIndex = nil
                            }
                        }
                        Spacer()
                        Button(currentQuestionIndex < questions.count - 1 ? "Suivant" : "End") {
                            if currentQuestionIndex < questions.count - 1 {
                                currentQuestionIndex += 1
                                if let answerIndex = selectedAnswerIndex, answerIndex + 1 == questions[currentQuestionIndex].answer.rawValue {
                                    score += 1  // Increment score if the answer is correct
                                }
                                selectedAnswerIndex = nil
                            } else {
                                // Check last question answer before finishing
                                if let answerIndex = selectedAnswerIndex, answerIndex + 1 == questions[currentQuestionIndex].answer.rawValue {
                                    score += 1
                                }
                                hasFinished = true  // Set the finish flag
                            }
                        }
                    }
                }
                .padding()
            } else {
                Text("Vous avez terminé le QCM!")
                    .font(.title)
                Text("Score obtenu : \(score) sur \(questions.count)")
                    .font(.headline)
                Button("Recommencer") {
                    // Reset everything to start over
                    currentQuestionIndex = 0
                    selectedAnswerIndex = nil
                    score = 0
                    hasFinished = false
                }
                .padding()
            }
        }
        .navigationBarTitle("QCM", displayMode: .inline)
        .padding()
    }
}

// Button view for answers
struct AnswerButton: View {
    var text: String
    @Binding var isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: {
            self.action()
            self.isSelected.toggle()
        }) {
            Text(text)
                .foregroundColor(isSelected ? .white : .black)
                .padding()
                .frame(maxWidth: .infinity)
                .background(isSelected ? Color.blue : Color.gray)
                .cornerRadius(10)
        }
    }
}

