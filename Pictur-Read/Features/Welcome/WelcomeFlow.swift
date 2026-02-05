//
//  WelcomeFlow.swift
//  Pictur-Read
//
//  Created by Antoine Edwards on 2/5/26.
//


import SwiftUI

struct WelcomeFlow: View {
    @AppStorage("hasSeenWelcome") private var hasSeenWelcome = false
    @State private var currentPage = 0
    
    var body: some View {
        if hasSeenWelcome {
            LibraryScreen() // Send them to the library if they've seen this
        } else {
            TabView(selection: $currentPage) {
                // Page 1: The Vision
                OnboardingPageView(
                    title: "Welcome to Pictur-Read",
                    description: "Bringing stories to life for every reader in Montgomery and beyond.",
                    imageName: "book.closed.fill",
                    color: .blue
                ).tag(0)
                
                // Page 2: The AI Magic
                OnboardingPageView(
                    title: "AI Imagination",
                    description: "Our on-device AI creates illustrations as you read, featuring YOU as the hero.",
                    imageName: "wand.and.stars",
                    color: .purple
                ).tag(1)
                
                // Page 3: Getting Started
                VStack(spacing: 20) {
                    Image(systemName: "person.crop.circle.badge.plus")
                        .font(.system(size: 80))
                        .foregroundColor(.green)
                    
                    Text("Ready to Read?")
                        .font(.largeTitle).bold()
                    
                    Text("Import your favorite books and let the AI do the rest.")
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Button("Get Started") {
                        withAnimation {
                            hasSeenWelcome = true
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                }.tag(2)
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
        }
    }
}

// A reusable "Component" for onboarding pages
struct OnboardingPageView: View {
    let title: String
    let description: String
    let imageName: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: imageName)
                .font(.system(size: 100))
                .foregroundColor(color)
            
            Text(title)
                .font(.largeTitle).bold()
            
            Text(description)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
    }
}