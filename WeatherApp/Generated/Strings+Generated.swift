// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
public enum L {

  public enum cityName {
    /// Название города
    public static let title = L.tr("Localizable", "city-name.title")
  }

  public enum common {
    /// Добавить
    public static let add = L.tr("Localizable", "common.add")
    /// Назад
    public static let back = L.tr("Localizable", "common.back")
    /// Ошибка
    public static let error = L.tr("Localizable", "common.error")
    /// Обновление
    public static let updating = L.tr("Localizable", "common.updating")
    public enum wind {
      /// С,ССВ,СВ,ВСВ,В,ВЮВ,ЮВ,ЮЮВ,Ю,ЮЮЗ,ЮЗ,ЗЮЗ,З,ЗСЗ,СЗ,ССЗ,С
      public static let directions = L.tr("Localizable", "common.wind.directions")
    }
  }

  public enum error {
    /// Город не найден
    public static let cityNotFound = L.tr("Localizable", "error.city-not-found")
  }

  public enum forecast {
    /// Прогноз
    public static let title = L.tr("Localizable", "forecast.title")
    public enum humidity {
      /// Влажность: %@%%
      public static func template(_ p1: Any) -> String {
        return L.tr("Localizable", "forecast.humidity.template", String(describing: p1))
      }
    }
    public enum maxTemp {
      /// Макс: %@
      public static func template(_ p1: Any) -> String {
        return L.tr("Localizable", "forecast.max-temp.template", String(describing: p1))
      }
    }
    public enum minTemp {
      /// Мин: %@
      public static func template(_ p1: Any) -> String {
        return L.tr("Localizable", "forecast.min-temp.template", String(describing: p1))
      }
    }
    public enum pressure {
      /// Давление: %@ кПа
      public static func template(_ p1: Any) -> String {
        return L.tr("Localizable", "forecast.pressure.template", String(describing: p1))
      }
    }
  }

  public enum main {
    public enum description {
      /// Ощущается как %@ ℃. %@
      public static func template(_ p1: Any, _ p2: Any) -> String {
        return L.tr("Localizable", "main.description.template", String(describing: p1), String(describing: p2))
      }
    }
    public enum empty {
      /// У Вас не добавлено городов
      public static let title = L.tr("Localizable", "main.empty.title")
    }
    public enum humidity {
      /// Влажность %@%%
      public static func template(_ p1: Any) -> String {
        return L.tr("Localizable", "main.humidity.template", String(describing: p1))
      }
    }
    public enum pressure {
      /// Давление %@ кПа
      public static func template(_ p1: Any) -> String {
        return L.tr("Localizable", "main.pressure.template", String(describing: p1))
      }
    }
    public enum visibility {
      /// Видимость %@ км
      public static func template(_ p1: Any) -> String {
        return L.tr("Localizable", "main.visibility.template", String(describing: p1))
      }
    }
    public enum wind {
      /// Ветер %@ м/с (%@)
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
