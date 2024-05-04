# balanced_workout

A new Flutter project.

replace these lines in .vscode\launch.json

{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "name": "balanced_workout",
            "request": "launch",
            "type": "dart",
            "program": "${workspaceFolder}/lib/screens/app/app.dart"

        },
        {
            "name": "balanced_workout (profile mode)",
            "request": "launch",
            "type": "dart",
            "flutterMode": "profile",
            "program": "${workspaceFolder}/lib/screens/app/app.dart"
        },
        {
            "name": "balanced_workout (release mode)",
            "request": "launch",
            "type": "dart",
            "flutterMode": "release",
            "program": "${workspaceFolder}/lib/screens/app/app.dart"
        }
    ]
}