# 対象ラベル: claim_binary_ca_logarithmic_free_count_fibers
# 式ペア・判定: Φ = log(q_F(n))
# 帰属: 有限集合・ZZ・QQ・素数上の有限台整数ベクトル。実数複素数への脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
checked = 0
for size, rule, mapping, slope, H, n, fixed, fibers, counts, D in calibration_rows():
    if not fixed:
        continue
    expr1 = row_free(fixed)
    expr2 = logarithm(row_rational_count(fixed))
    assert expr1 == expr2
    checked += 1
assert checked > 0
print("cases checked:", checked)

print("RESULT: PASS")
