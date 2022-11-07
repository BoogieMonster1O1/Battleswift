do {
    try ServerProperties.load()
} catch PropertiesError.fileNotFound {
    print("server.properties not found. Created a new one. Please edit it and restart the server.")
} catch PropertiesError.malformedProperties {
    print("server.properties is malformed")
} catch PropertiesError.missingKey {
    print("server.properties is missing a key")
} catch {
    print("Unknown error")
}
