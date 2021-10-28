//
// Created by Mengyu Li on 2020/8/10.
//

import Foundation
import Logging

public struct Handler: LogHandler {
    public let name: String
    public let sink: Sink
    public let formatter: Formable

    private var prettyMetadata: String?
    public var metadata = Logger.Metadata() {
        didSet { prettyMetadata = prettify(metadata) }
    }

    public var logLevel: Logger.Level

    public subscript(metadataKey metadataKey: String) -> Logger.Metadata.Value? {
        get { metadata[metadataKey] }
        set { metadata[metadataKey] = newValue }
    }

    public init(name: String, sink: Sink, formatter: Formable, logLevel: Logger.Level) {
        self.name = name
        self.sink = sink
        self.formatter = formatter
        self.logLevel = logLevel
    }

    public func log(level: Logger.Level, message: Logger.Message, metadata: Logger.Metadata?, source: String, file: String, function: String, line: UInt) {
        let prettyMetadata = metadata.map { metadata -> String? in
            prettify(self.metadata.merging(metadata, uniquingKeysWith: { $1 }))
        }
            ??
            prettyMetadata

        let formattedMessage = formatter.format(name: name, level: level, message: message, prettyMetadata: prettyMetadata, file: file, function: function, line: line)
        sink.process(formattedMessage, level)
    }
}

extension Handler {
    private func prettify(_ metadata: Logger.Metadata) -> String? {
        !metadata.isEmpty ? metadata.map { "\($0)=\($1)" }.joined(separator: " ") : nil
    }
}