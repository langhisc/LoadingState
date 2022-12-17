# LoadingState

This small package provides just one entity: a rich enum called `LoadingState`.  This enum can model the status of an asynchronous process, and is a great fit for networking code.  `LoadingState` is much like Swift's `Result` type, but contains two additional cases: `.notStarted` and `.loading`.  In a SwiftUI app, try using `LoadingState` to model an `@Published` property in an `ObservableObject` adopter that talks to the network.
