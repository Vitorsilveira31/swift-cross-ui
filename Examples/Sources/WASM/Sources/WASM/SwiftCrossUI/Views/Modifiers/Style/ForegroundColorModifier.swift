extension View {
    /// Sets the color of the foreground elements displayed by this view.
    public func foregroundColor(_ color: Color) -> some View {
        return EnvironmentModifier(self) { environment in
            return environment.with(\.foregroundColor, color)
        }
    }
}
