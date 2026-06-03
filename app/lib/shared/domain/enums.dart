/// Domain enums matching the legacy C# codebase
library;

/// Client status matching legacy ClientStatus enum.
///
/// Kept for legacy data compatibility. New client lifecycle labels are derived
/// automatically from creation date and completed appointment history.
enum ClientStatus {
  /// Active client
  bound,

  /// New client
  freshSoul,

  /// Legacy high-value client
  highValue,

  /// Archived/Inactive client
  void_;

  /// Returns the human-readable display name of the status
  String get displayName {
    switch (this) {
      case ClientStatus.bound:
        return 'Active';
      case ClientStatus.freshSoul:
        return 'New';
      case ClientStatus.highValue:
        return 'Active';
      case ClientStatus.void_:
        return 'Inactive';
    }
  }
}

/// User role for authorization
/// Maps to legacy UserRole enum
enum UserRole {
  /// Full access admin
  admin,

  /// Artist with limited access
  artist,
}

/// Appointment status
/// Derived from legacy usage patterns in AppointmentDto
enum AppointmentStatus {
  /// Scheduled but not yet started
  scheduled,

  /// Currently in progress
  inProgress,

  /// Successfully completed
  completed,

  /// Client cancelled
  cancelled,

  /// Client did not show up
  noShow,

  /// In "Purgatory" (waitlist)
  waitlist,
}

/// Service type for appointments
enum ServiceType {
  /// Tattoo session
  tattoo,

  /// Piercing service
  piercing,

  /// Touch-up/correction
  touchUp,

  /// Consultation only
  consultation,

  /// Other service
  other,
}

/// Price type for appointments
enum PriceType {
  /// Charged by the hour
  hourly,

  /// Fixed flat rate
  flat,

  /// Session-based pricing
  session,

  /// Quoted price
  quoted,
}

/// Deposit type for shop settings
enum DepositType {
  /// Percentage of quoted price
  percentage,

  /// Fixed amount
  fixed,
}
