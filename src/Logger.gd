class_name Logger

var name = ""

func _init(n: String):
	name = n

func info(msg: String):
	print("[%s - %s]: %s" % [_now(), name, msg])

func _now() -> String:
	var dt = OS.get_datetime()
	var year = dt["year"]
	var month = _leading_zero(dt["month"])
	var day = _leading_zero(dt["day"])
	var hour = _leading_zero(dt["hour"])
	var minute = _leading_zero(dt["minute"])
	var second = _leading_zero(dt["second"])
	return "%s-%s-%s %s:%s:%s" % [year, month, day, hour, minute, second]

func _leading_zero(num: int) -> String:
	if num < 10:
		return "0" + str(num)
	return str(num)
