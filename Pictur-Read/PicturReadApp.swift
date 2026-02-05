import SwiftUI
import SwiftData

@main
struct PicturReadApp: App {
    // This tells SwiftData which models to include in the database
    let container: ModelContainer

    init() {
        do {
            let schema = Schema([Book.self, CachedIllustration.self])
            let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
            container = try ModelContainer(for: schema, configurations: [config])
        } catch {
            fatalError("Could not configure SwiftData: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            // We start at the Welcome flow
            WelcomeFlow()
        }
        // Inject the database into the whole app
        .modelContainer(container)
    }
}
