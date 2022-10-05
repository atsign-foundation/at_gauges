const kDefaultAnimationDuration = 2000;
const kNoAnimationDuration = 0;

const double kDefaultRangeGaugeMaxDegree = 300;
const double kDefaultRangeGaugeStartDegree = 180;

/// Highest point on canvas the scale occupies.
/// For scalability this const is divided my the [size.height] of the canvas.
const double kUpperScaleLimitVertical = 7;
const double kUpperScaleLimitHorizontal = 1.6;

/// Lowest point on canvas the scale occupies.
/// For scalability this const is divided my the [size.height] of the canvas.
const double kLowerScaleLimitVertical = 1.2;
const double kLowerScaleLimitHorizontal = 0.65;
