# Screenshot queue

Take in-game screenshots without visible pauses or frame time spikes. Queues screenshots and writes them to time stamped files in user directory in a separate thread. Made for Godot 3.x.

## Usage

Copy the `screenshotqueue.gd` -file to your project directory and set it as auto-loaded script (singleton) in project settings. Then all you need in code is this (assuming you named the singleton ScreenshotQueue):

    ScreenshotQueue.snap(get_viewport())

## License

MIT license.

This was initially made for use in [Polychoron](https://www.fractilegames.com/polychoron/) game project.
