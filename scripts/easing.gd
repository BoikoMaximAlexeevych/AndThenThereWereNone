class_name Easing extends RefCounted
const BACK_OVERSHOOT := 1.70158

static func ease_out_back(t: float, overshoot: float = BACK_OVERSHOOT) -> float:
	var u := t - 1.0
	return 1.0 + (overshoot + 1.0) * u * u * u + overshoot * u * u

static func ease_out_cubic(t: float) -> float:
	var u := 1.0 - t
	return 1.0 - u * u * u

static func arc(t: float) -> float:
	return sin(t * PI)
