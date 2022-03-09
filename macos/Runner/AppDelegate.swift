import Cocoa
import FlutterMacOS
import GoogleMaps

@NSApplicationMain
class AppDelegate: FlutterAppDelegate {
  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    GMSServices.provideAPIKey("AIzaSyAGHM6BrYlzMWxtNmYhg1aOlVEkzmwIgK4")
    GeneratedPluginRegistrant.register(with: self)
    return true
  }
}
