# <inverse_of_sqrt_cc>: 証明の第四の √(1_C) の鎖のうち、偏角の ℝ の計算の 3 行と cos 0・sin 0・1·x = x の行を確かめる。
# 偏角: 0/2 − 0·π → 0 − 0·π（ℝ で 0/x = 0、x → 2）→ 0 − 0（ℝ で 0·x = 0、x → π）→ 0（ℝ で a − 0 = a、a → 0）。
# 成分: (1·cos 0, 1·sin 0) → (1·1, 1·sin 0)（cosine_zero）→ (1·1, 1·0)（sine_zero）→ (1, 0)（ℝ で 1·x = x を 2 箇所）。
# 帰属: 0/2・0 − 0・1·x は QQ で厳密。π を含む 0·π は記号計算（SR）で厳密。cos 0・sin 0 は _shared の cos_sin（AA）で厳密。
load("../../_shared/operators.sage")
load("../../_shared/polar_trigonometry_exact.sage")
rep = CheckReport("inverse_of_sqrt_cc: √(1_C) の鎖の偏角の ℝ の計算と cos 0・sin 0")
zero, one, two = QQ(0), QQ(1), QQ(2)
# 偏角の 3 行。各行で置き換える部分式の等号を確かめる（記号計算は 0·π を式を作った時点で 0 に畳むので、行の式どうしの比較はしない）
rep.truth(zero / two == zero, "0/2 = 0（0/x = 0 の x → 2）")
rep.truth(bool(SR(zero) * pi == 0), "0·π = 0（0·x = 0 の x → π）")
rep.truth(zero - zero == zero, "0 − 0 = 0（a − 0 = a の a → 0）")
# 成分の行
cos0, sin0 = cos_sin(Ang(0))
rep.truth(cos0 == 1, "cos 0 = 1（cosine_zero）")
rep.truth(sin0 == 0, "sin 0 = 0（sine_zero）")
rows = [(one * cos0, one * sin0), (one * one, one * sin0), (one * one, one * zero), (one, zero)]
for r, s in zip(rows, rows[1:]):
    rep.truth(r == s, f"{r} = {s}")
rep.truth(one * one == one and one * zero == zero, "1·1 = 1、1·0 = 0（1·x = x の x → 1、x → 0）")
# 否定の対照: 偏角の 0·π を 1·π に取り違えると 0 にならない。cos 0 と sin 0 を取り違えると行が崩れる
rep.truth(bool(SR(zero) / SR(two) - SR(one) * pi != 0), "否定の対照: 0/2 − 1·π ≠ 0（記号計算が不等号を示せたときだけ真）")
rep.truth((one * sin0, one * cos0) != (one, zero), "否定の対照: (1·sin 0, 1·cos 0) ≠ (1, 0)")
rep.finish()
