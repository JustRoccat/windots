//@ pragma IconTheme Chicago95
import Quickshell

ShellRoot {
    Variants {
        model: Quickshell.screens

        delegate: Bar {
            required property var modelData
            screen: modelData
        }
    }
}
