#!/usr/bin/swift

import Cocoa

let kTargetBoard = "B460i-PLUS"
let kAppTitle = "\(kTargetBoard) USB Tool"
let kBundleName = "USBPorts"
let kBundleIdentifier = "org.usbtool.kext"
let kDriverPersonalityKey = "Generated by \(kAppTitle)"
let kDriverIONameMatch = "XHC"
let kDriverIOProviderClass = "AppleUSBXHCISPT"
let kFallbackModelIdentifier = "iMac20,1"
let kDefaultPortMapData: [USBPort] = [
	.init(
		name: "HS01",
		address: 0x1,
		connector: .a3,
		info: "USB 3 header"
	), .init(
		name: "HS02",
		address: 0x2,
		connector: .a3,
		info: "USB 3 header"
	), .init(
		name: "HS03",
		address: 0x3,
		connector: .a3,
		info: "Rear panel USB 3 connector"
	), .init(
		name: "HS04",
		address: 0x4,
		connector: .a3,
		info: "Rear panel USB 3 connector"
	), .init(
		name: "HS05",
		address: 0x5,
		connector: .a3,
		info: "Rear panel USB 3 connector"
	), .init(
		name: "HS06",
		address: 0x6,
		connector: .a3,
		info: "Rear panel USB 3 connector"
	), .init(
		name: "HS07",
		address: 0x7,
		connector: .a2,
		info: "Rear panel USB 2 connector"
	), .init(
		name: "HS08",
		address: 0x8,
		connector: .a2,
		info: "Rear panel USB 2 connector"
	), .init(
		name: "HS09",
		address: 0x9,
		connector: .a2,
		info: "USB 2 header"
	), .init(
		name: "HS10",
		address: 0xA,
		connector: .a2,
		info: "USB 2 header"
	), .init(
		name: "HS12",
		address: 0xC,
		connector: .proprietary,
		info: "m.2 E key"
	), .init(
		name: "SS01",
		address: 0x11,
		connector: .a3,
		info: "USB 3 header"
	), .init(
		name: "SS02",
		address: 0x12,
		connector: .a3,
		info: "USB 3 header"
	), .init(
		name: "SS03",
		address: 0x13,
		connector: .a3,
		info: "Rear panel USB 3 connector"
	), .init(
		name: "SS04",
		address: 0x14,
		connector: .a3,
		info: "Rear panel USB 3 connector"
	), .init(
		name: "SS05",
		address: 0x15,
		connector: .a3,
		info: "Rear panel USB 3 connector"
	), .init(
		name: "SS06",
		address: 0x16,
		connector: .a3,
		info: "Rear panel USB 3 connector"
	)
]
let kInfoPlistSourceData = """
	PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz48IURPQ1RZUEUgcGxpc3QgUFVCTElDICItLy
	9BcHBsZS8vRFREIFBMSVNUIDEuMC8vRU4iICJodHRwOi8vd3d3LmFwcGxlLmNvbS9EVERzL1Byb3BlcnR5TGlz
	dC0xLjAuZHRkIj48cGxpc3QgdmVyc2lvbj0iMS4wIj48ZGljdD48a2V5PkNGQnVuZGxlSW5mb0RpY3Rpb25hcn
	lWZXJzaW9uPC9rZXk+PHN0cmluZz42LjA8L3N0cmluZz48a2V5PkNGQnVuZGxlUGFja2FnZVR5cGU8L2tleT48
	c3RyaW5nPktFWFQ8L3N0cmluZz48a2V5PkNGQnVuZGxlVmVyc2lvbjwva2V5PjxzdHJpbmc+MS4wPC9zdHJpbm
	c+PGtleT5PU0J1bmRsZVJlcXVpcmVkPC9rZXk+PHN0cmluZz5Sb290PC9zdHJpbmc+PC9kaWN0PjwvcGxpc3Q+
"""
let kWindowWidth: CGFloat = 360.0
let kPortListEdgeInsets = NSEdgeInsets(top: 5.0, left: 10.0, bottom: 5.0, right: 10.0)
let kPortListColumnSpacing: CGFloat = 3.0
let kPortListRowSpacing: CGFloat = 9.0
let kContentSpacing: CGFloat = 20.0
let kWriteButtonTitle = "Write Bundle to Desktop"
let kWriteSuccessFormatString = "Wrote bundle to %@"
#if compiler(<5.5)
let kIOMainPortDefault: mach_port_t = kIOMasterPortDefault
#endif

extension DispatchQueue {
	static let work = DispatchQueue(label: "work")
}

extension FileHandle: TextOutputStream {
	public func write(_ string: String) {
		write(string.data(using: .utf8)!)
	}
}

extension FileManager {
	public func directoryExists(atPath path: String) -> Bool {
		var dir = ObjCBool(false)
		return fileExists(atPath: path, isDirectory: &dir) && dir.boolValue
	}
	
	public func desktopDirectoryURL() throws -> URL {
		guard let url = urls(for: .desktopDirectory, in: .userDomainMask).first else {
			throw RuntimeError("failed to obtain desktop directory URL")
		}
		
		return url
	}
}

extension FixedWidthInteger {
	public var data: Data {
		var this = self
		return .init(bytes: &this, count: MemoryLayout<Self>.size)
	}
}

extension NSMenu {
	convenience init(title: String, items: [NSMenuItem]) {
		self.init(title: title)
		self.items = items
	}
}

extension NSMenuItem {
	convenience init(title: String, action: Selector? = nil) {
		self.init(title: title, action: action, keyEquivalent: "")
	}
}

extension NSWindow {
	var closeButton: NSButton? { standardWindowButton(.closeButton) }
	var miniaturizeButton: NSButton? { standardWindowButton(.miniaturizeButton) }
	var zoomButton: NSButton? { standardWindowButton(.zoomButton) }
}

extension PropertyListSerialization {
        class func xmlData(from dictionary: [String: Any]) throws -> Data {
                return try Self.data(fromPropertyList: dictionary, format: .xml, options: 0)
        }
}

struct RuntimeError: LocalizedError {
	let description: String
	let location: String
	
	init(_ description: String, location: String = #function) {
		self.description = description
		self.location = location
	}
	
	var errorDescription: String? {
		return "The operation couldn't be completed (\(String(describing: self))) \(location): \(description)"
	}
}

enum USBConnector: UInt8 {
	case a2 = 0x0 // Type A (USB 2)
	case a3 = 0x3 // Type A (USB 3)
	case c3s = 0x9 // Type C (USB 3, switched)
	case c3 = 0xA // Type C (USB 3)
	case proprietary = 0xFF // e.g. internal bluetooth
}

final class USBPort: NSObject {
	public let name: String
	public let address: UInt32
	public let connector: USBConnector
	public let info: String
	@objc private(set) var isEnabled: Bool
	
	init(name: String, address: UInt32, connector: USBConnector, info: String, isEnabled: Bool = true) {
		self.name = name
		self.address = address
		self.connector = connector
		self.info = info
		self.isEnabled = isEnabled
	}
}

final class PortMap {
	static let `default` = PortMap(data: kDefaultPortMapData)
	public let data: [USBPort]
	
	init(data: [USBPort]) {
		self.data = data
	}
	
	public var lastAddress: UInt32? {
		return data.sorted { $0.address < $1.address }.last?.address
	}
	
	public var enabledCount: Int {
		return data.filter { $0.isEnabled }.count
	}
}

struct Bundle {
	init(destination url: URL) throws {
		guard FileManager.default.directoryExists(atPath: url.path) else {
			throw RuntimeError("directory not found at destination path \(url.path)")
		}
		
		kextURL = url.appendingPathComponent("\(kBundleName).kext")
		contentsURL = kextURL.appendingPathComponent("Contents")
		plistURL = contentsURL.appendingPathComponent("Info.plist")
	}
	
	let kextURL: URL
	let contentsURL: URL
	let plistURL: URL
	
	func createDirectories() throws {
		try FileManager.default.createDirectory(atPath: contentsURL.path, withIntermediateDirectories: true, attributes: nil)
	}
	
	func updateModificationDate() throws {
		try FileManager.default.setAttributes([.modificationDate: NSDate()], ofItemAtPath: kextURL.path)
	}
	
	func writePropertyList(data: Data) throws {
		try data.write(to: plistURL, options: .atomic)
	}
}

final class BundleWriter {
	static let shared = BundleWriter()
	private let propertyList: [String: Any]
	private var errorStream = FileHandle.standardError
	
	private init() {
		do {
			propertyList = try Self.decodePropertyListFromBase64()
		}
		
		catch {
			fatalError(error.localizedDescription)
		}
	}
	
	private static func decodePropertyListFromBase64() throws -> [String: Any] {
		guard let data: Data = .init(base64Encoded: kInfoPlistSourceData, options: .ignoreUnknownCharacters) else {
			throw RuntimeError("failed to decode property list data from base64")
		}
		
		let plist: Any = try PropertyListSerialization.propertyList(from: data, options: .mutableContainersAndLeaves, format: nil)
		
		guard let result = plist as? [String: Any] else {
			throw RuntimeError("failed to cast serialized property list to dictionary")
		}
		
		return result
	}
	
	private lazy var modelIdentifier: String = {	
		var identifier: String?
		let entry = IORegistryEntryFromPath(kIOMainPortDefault, "IOService:/")
		
		if let data = IORegistryEntryCreateCFProperty(entry, "model" as CFString, kCFAllocatorDefault, 0)?.takeRetainedValue() as? Data {
			identifier = String(data: data, encoding: .macOSRoman)?.filter { $0 != "\0"}
		}
		
		IOObjectRelease(entry)
		
		guard identifier != nil else {
			print("warning: using fallback model identifier \(kFallbackModelIdentifier)!", to: &errorStream)
			return kFallbackModelIdentifier
		}
		
		return identifier!
	}()
	
	public func write(destination url: URL, userMap: PortMap) throws -> URL {
		let bundleIdentifierKey = kCFBundleIdentifierKey as String
		let bundleNameKey = kCFBundleNameKey as String
		let driverBundleIdentifier = "com.apple.driver.AppleUSBHostMergeProperties"
		let driverClass = "AppleUSBHostMergeProperties"
		let personalitiesKey = "IOKitPersonalities"
		let providerMergePropertiesKey = "IOProviderMergeProperties"
		let modelIdentifierKey = "model"
		let portCountKey = "port-count"
		let portsKey = "ports"
		let portAddressKey = "port"
		let portConnectorKey = "UsbConnector"
		
		guard let portCount = userMap.lastAddress else {
			throw RuntimeError("userMap is empty")
		}
		
		let bundle = try Bundle(destination: url)
		var propertyList = propertyList
		var ports = [String: Any]()
		
		for port in userMap.data {
			ports[port.name] = [
				portAddressKey: port.address.data,
				portConnectorKey: port.connector.rawValue
			]
		}
		
		let driverPersonality: [String: Any] = [
			bundleIdentifierKey: driverBundleIdentifier,
			kIOClassKey: driverClass,
			kIONameMatchKey: kDriverIONameMatch,
			kIOProviderClassKey: kDriverIOProviderClass,
			modelIdentifierKey: modelIdentifier,
			providerMergePropertiesKey: [
				portCountKey: portCount.data,
				portsKey: ports
			]
		]
		
		propertyList[bundleNameKey] = kBundleName
		propertyList[bundleIdentifierKey] = kBundleIdentifier
		propertyList[personalitiesKey] = [
			kDriverPersonalityKey: driverPersonality
		]

		let data = try PropertyListSerialization.xmlData(from: propertyList)
		try bundle.createDirectories()
		try bundle.writePropertyList(data: data)
		try? bundle.updateModificationDate()
		return bundle.kextURL
	}
}

final class ViewController: NSViewController {
	static let shared = ViewController()
	private let portLimit = 15
	private var errorStream = FileHandle.standardError
	
	private init() {
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		return nil
	}
	
	private lazy var portListView: NSGridView = {
		let view = NSGridView(numberOfColumns: 2, rows: 0)
		
		for port in PortMap.default.data {
			let button = makePortSwitchButton(title: port.name, enabled: port.isEnabled)
			button.target = self
			button.action = #selector(Self.switchButtonPressed(_:))
			button.bind(.value, to: port,
				    withKeyPath: #keyPath(USBPort.isEnabled),
				    options: [.validatesImmediately: true])
			view.addRow(with: [button, makeLabel(port.info)])
		}
		
		view.rowAlignment = .firstBaseline
		view.columnSpacing = kPortListColumnSpacing
		view.rowSpacing = kPortListRowSpacing
		view.column(at: 0).xPlacement = .fill
		view.column(at: 1).xPlacement = .leading
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	private lazy var writeButton: NSButton = {
		let button = NSButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.bezelStyle = .rounded
		button.title = kWriteButtonTitle
		button.isEnabled = false
		return button
	}()
	
	override func loadView() {
		view = AppDelegate.shared.mainWindow.contentView!
	}
	
	override func viewDidLoad() {
		let portListViewLeading = kContentSpacing + kPortListEdgeInsets.left
		let portListViewTrailing = -(kContentSpacing + kPortListEdgeInsets.right)
		let portListViewTop = kContentSpacing + kPortListEdgeInsets.top
		let portListViewBottom = -(kContentSpacing + kPortListEdgeInsets.bottom)
		view.subviews = [portListView, writeButton]
		writeButton.target = self
		writeButton.action = #selector(Self.writeButtonPressed(_:))
		enableWriteButton()
		NSLayoutConstraint.activate([
			portListView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: portListViewLeading),
			portListView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: portListViewTrailing),
			portListView.topAnchor.constraint(equalTo: view.topAnchor, constant: portListViewTop),
			portListView.bottomAnchor.constraint(equalTo: writeButton.topAnchor, constant: portListViewBottom),
			writeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -kContentSpacing),
			writeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -kContentSpacing)
		])
	}
	
	private func enableWriteButton() {
		writeButton.isEnabled = PortMap.default.enabledCount <= portLimit
	}
	
	@objc func switchButtonPressed(_ sender: NSButton) {
		enableWriteButton()
	}
	
	@objc func writeButtonPressed(_ sender: NSButton) {
		let userMap = PortMap(data: PortMap.default.data.filter { $0.isEnabled })
		
		DispatchQueue.work.async { [userMap] in
			do {
				let desktop = try FileManager.default.desktopDirectoryURL()
				let successURL = try BundleWriter.shared.write(destination: desktop, userMap: userMap)
				print(String(format: kWriteSuccessFormatString, successURL.path))
			}
			
			catch {
				print(error.localizedDescription, to: &self.errorStream)
			}
		}
	}
	
	private func makePortSwitchButton(title: String, enabled: Bool) -> NSButton {
		let button = NSButton()
		button.title = title
		button.setButtonType(.switch)
		button.state = enabled ? .on : .off
		button.invalidateIntrinsicContentSize()
		return button
	}
	
	private func makeLabel(_ stringValue: String) -> NSTextField {
		let textField = NSTextField()
		textField.drawsBackground = false
		textField.isBezeled = false
		textField.isEditable = false
		textField.isSelectable = true
		textField.textColor = NSColor.secondaryLabelColor
		textField.stringValue = stringValue
		textField.invalidateIntrinsicContentSize()
		return textField
	}
}

final class AppDelegate: NSObject, NSApplicationDelegate {
	static let shared = AppDelegate()
	
	private override init() {
		super.init()
	}
	
	public lazy var mainWindow: NSWindow = {
		let window = NSWindow()
		window.title = kAppTitle
		window.styleMask = [.titled, .closable]
		window.miniaturizeButton?.isHidden = true
		window.zoomButton?.isHidden = true
		window.contentView?.widthAnchor.constraint(greaterThanOrEqualToConstant: kWindowWidth).isActive = true
		return window
	}()
	
	private lazy var mainMenu: NSMenu = {
		let processName = ProcessInfo.processInfo.processName
		let appMenu = NSMenuItem(title: processName)
		let editMenu = NSMenuItem(title: "Edit")
		appMenu.submenu = NSMenu(title: processName, items: [
			NSMenuItem(title: "About \(processName)",
				   action: #selector(NSApplication.orderFrontStandardAboutPanel(_:))),
			NSMenuItem.separator(),
			NSMenuItem(title: "Quit \(processName)",
				   action: #selector(NSApplication.terminate(_:)),
				   keyEquivalent: "q")
		])
		editMenu.submenu = NSMenu(title: "Edit", items: [
			NSMenuItem(title: "Copy",
				   action: #selector(NSText.copy(_:)),
				   keyEquivalent: "c")
		])
		return NSMenu(title: "Main Menu", items: [appMenu, editMenu])
	}()
	
	@objc func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
		return true
	}
	
	@objc func applicationDidFinishLaunching(_ notification: Notification) {
		NSApp.activate(ignoringOtherApps: true)
	}
	
	public func runApp() {
		NSApp = NSApplication.shared
		NSApp.delegate = Self.shared
		NSApp.mainMenu = mainMenu
		NSApp.setActivationPolicy(.regular)
		mainWindow.contentViewController = ViewController.shared
		mainWindow.makeKeyAndOrderFront(self)
		mainWindow.center()
		NSApp.run()
	}
}

AppDelegate.shared.runApp()
