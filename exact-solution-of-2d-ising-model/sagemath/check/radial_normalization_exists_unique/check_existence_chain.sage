# 対象ラベル: radial_normalization_exists_unique
# 本文の存在の鎖（四行）:
#   x_c^2+y_c^2 = (x/r)^2+(y/r)^2          (x_c, y_c の定義)
#               = (x^2+y^2)/r^2            (R の四則)
#               = (x^2+y^2)/(x^2+y^2)      (r の定義と正の平方根の平方)
#               = 1                        (x^2+y^2 > 0 なので約分できる)
# 一般の点:
#   第一行は x_c, y_c の定め方を代入するだけの行である。
#   第二行（四則）は、r が可逆であることだけを持つ環 V（t が r^{-1}）で (x t)^2+(y t)^2 = (x^2+y^2) t^2 を確かめる。
#     これは関係式 rv*t = 1 も使わず、関係式の無い F[rv,t] で既に成り立つ（分配則と交換則だけ）。
#   第三行（r^2 = x^2+y^2）は、第二行の値を K へ写して F の元 (x^2+y^2)/(x^2+y^2) と比べる。
#     対照として、V の中（r^2 = x^2+y^2 を持たない）では第二行の値が 1 にならないことを確かめる。
#   第四行は、F でも AA でも割り算が作った時点で 1 に簡約されるので、等号そのものは自動的に成り立つ。
#     この行で確かめているのは約分の前提 x^2+y^2 ≠ 0（具体の点）だけである。
# 具体の点（AA）でも同じ四行を、それぞれ AA の演算で別々に計算して確かめる。
load("_prelude.sage")

# 一般の点
line1_V = V(x * t)^2 + V(y * t)^2
line2_V = V(s * t^2)
assert (x * t)^2 + (y * t)^2 == s * t^2      # 第二行: 関係式なしで成り立つ
assert line1_V == line2_V
line3_F = s / s
assert V_to_K(line2_V) == K(line3_F)          # 第三行: K の関係式 r^2 = x^2+y^2 を使う
assert line2_V != V(1)                        # 対照: V（r^2 = x^2+y^2 なし）では成り立たない
assert line3_F == 1                           # 第四行

# 具体の点
for (px, py) in SAMPLE_POINTS:
    pr, pxc, pyc = normalize(px, py)
    assert px^2 + py^2 != 0
    a0 = pxc^2 + pyc^2
    a1 = (px / pr)^2 + (py / pr)^2
    a2 = (px^2 + py^2) / pr^2
    a3 = (px^2 + py^2) / (px^2 + py^2)
    assert a0 == a1
    assert a1 == a2
    assert a2 == a3
    assert a3 == 1

print(f"checked the generic point and {len(SAMPLE_POINTS)} points")
print("RESULT: PASS")
