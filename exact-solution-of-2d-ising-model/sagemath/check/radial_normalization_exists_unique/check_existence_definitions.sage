# 対象ラベル: radial_normalization_exists_unique
# 本文の定め方の行と二つの鎖:
#   r := sqrt(x^2+y^2)^{(R≥0)} ∈ R_{≥0}、
#   r^2 = x^2+y^2   (r の定義と正の平方根の平方)
#       > 0         (場合分けの結論)
#   r ≠ 0           (0^2 = 0 ≠ r^2)
#   r > 0           (r ≥ 0 かつ r ≠ 0)
#   x_c := x/r, y_c := y/r。
#   r x_c = r·(x/r)   (x_c の定義)
#         = x         (r > 0 なので約分できる)
#   r y_c についても同じ二行。
# 具体の点（AA）: r ≥ 0、r^2 = x^2+y^2（正の平方根の定義）、x^2+y^2 > 0、0^2 ≠ r^2、r ≠ 0、r > 0 と、鎖の各行。
# 一般の点（環 V = F[rv,t]/(rv*t-1)、t が r^{-1}）: 第二行 rv*(x*t) = x が関係式 rv*t = 1 だけから従い、
#   関係式の無い F[rv,t] では成り立たないこと。第一行は x_c の定め方を代入するだけの行である。
load("_prelude.sage")

for (px, py) in SAMPLE_POINTS:
    pr, pxc, pyc = normalize(px, py)
    assert pr >= 0
    assert pr^2 == px^2 + py^2
    assert px^2 + py^2 > 0
    assert AA(0)^2 == 0 and AA(0)^2 != pr^2
    assert pr != 0
    assert pr > 0
    assert pr * pxc == pr * (px / pr)
    assert pr * (px / pr) == px
    assert pr * pyc == pr * (py / pr)
    assert pr * (py / pr) == py

assert V(rv) * (V(x) * V(t)) == V(x)
assert V(rv) * (V(y) * V(t)) == V(y)
assert rv * (x * t) != x
assert rv * (y * t) != y

print(f"checked {len(SAMPLE_POINTS)} points and the generic point")
print("RESULT: PASS")
