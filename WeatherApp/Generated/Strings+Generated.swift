// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
public enum L {

  public enum cityName {
    /// City name
    public static let title = L.tr("Localizable", "city-name.title")
  }

  public enum common {
    /// Add
    public static let add = L.tr("Localizable", "common.add")
    /// Back
    public static let back = L.tr("Localizable", "common.back")
    /// Error
    public static let error = L.tr("Localizable", "common.error")
    /// Updating
    public static let updating = L.tr("Localizable", "common.updating")
    public enum wind {
      /// N,NNE,NE,ENE,E,ESE,SE,SSE,S,SSW,SW,WSW,W,WNW,NW,NNW,N
      public static let directions = L.tr("Localizable", "common.wind.directions")
    }
  }

  public enum error {
    /// City not found
    public static let cityNotFound = L.tr("Localizable", "error.city-not-found")
  }

  public enum forecast {
    /// Forecast
    public static let title = L.tr("Localizable", "forecast.title")
    public enum humidity {
      /// Humidity: %@%%
      public static func template(_ p1: Any) -> String {
        return L.tr("Localizable", "forecast.humidity.template", String(describing: p1))
      }
    }
    public enum maxTemp {
      /// Max: %@
      public static func template(_ p1: Any) -> String {
        return L.tr("Localizable", "forecast.max-temp.template", String(describing: p1))
      }
    }
    public enum minTemp {
      /// Min: %@
      public static func template(_ p1: Any) -> String {
        return L.tr("Localizable", "forecast.min-temp.template", String(describing: p1))
      }
    }
    public enum pressure {
      /// Pressure: %@ hPa
      public static func template(_ p1: Any) -> String {
        return L.tr("Localizable", "forecast.pressure.template", String(describing: p1))
      }
    }
  }

  public enum main {
    public enum description {
      /// Feels like %@ ℃. %@
      public static func template(_ p1: Any, _ p2: Any) -> String {
        return L.tr("Localizable", "main.description.template", String(describing: p1), String(describing: p2))
      }
    }
    public enum empty {
      /// You havn't added cities
      public static let title = L.tr("Localizable", "main.empty.title")
    }
    public enum humidity {
      /// Humidity %@%%
      public static func template(_ p1: Any) -> String {
        return L.tr("Localizable", "main.humidity.template", String(describing: p1))
      }
    }
    public enum pressure {
      /// Pressure %@ hPa
      public static func template(_ p1: Any) -> String {
        return L.tr("Localizable", "main.pressure.template", String(describing: p1))
      }
    }
    public enum visibility {
      /// Visibility %@ km
      public static func template(_ p1: Any) -> String {
        return L.tr("Localizable", "main.visibility.template", String(describing: p1))
      }
    }
    public enum wind {
      /// Wind %@ m/s (%@)
      public static func template(_ p1: Any, _ p2: Any) -> String {
        return L.tr("Localizable", "main.wind.template", String(describing: p1), String(describing: p2))
      }
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    Bundle(for: BundleToken.self)
  }()
}
// swiftlint:enable convenience_type
