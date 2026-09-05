# 対象ラベル: claim_binary_ca_fiber_count_partition
# 式ペア・判定: union C(u) = Fix_n(F)
# 帰属: 有限集合・ZZ・QQ・素数上の有限台整数ベクトル。実数複素数への脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
checked = 0
for size, rule, mapping, slope, H, n, fixed, fibers, counts, D in calibration_rows():
    expr1 = set().union(*(fibers[u] for u in D))
    expr2 = fixed
    assert expr1 == expr2
    checked += 1
assert checked > 0
print("cases checked:", checked)

print("RESULT: PASS")
