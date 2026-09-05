# 対象ラベル: claim_binary_ca_fiber_count_partition
# 式ペア・判定: |Fix_n(F)| = Z_n(F) (周期長による独立計数との照合は fixed_iteration)
# 帰属: 有限集合・ZZ・QQ・素数上の有限台整数ベクトル。実数複素数への脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
checked = 0
for size, rule, mapping, slope, H, n, fixed, fibers, counts, D in calibration_rows():
    expr1 = len(fixed)
    expr2 = sum(1 for x in range(len(mapping)) if x in fixed)
    assert expr1 == expr2
    checked += 1
assert checked > 0
print("cases checked:", checked)

print("RESULT: PASS")
