extends TextureProgressBar

func initBar(percentage):
	value = percentage

func setBar(percentage):
	if percentage < 0: return
	var tween = get_tree().create_tween()
	tween.tween_property(self, "value", percentage, 1.0).set_trans(Tween.TRANS_CUBIC)
	await tween.finished
