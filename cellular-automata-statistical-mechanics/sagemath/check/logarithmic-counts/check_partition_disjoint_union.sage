# 対象ラベル: claim_binary_ca_fiber_count_partition
# 式ペア・判定: 互いに素な有限合併の元数
# 帰属: 有限集合・ZZ・QQ・素数上の有限台整数ベクトル。実数複素数への脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
checked = 0
for size, mapping, H, n, fixed, D in fiber_rows():
    expr1 = sum((len(fiber(mapping,H,n,u)) for u in D),ZZ(0))
    expr2 = len(set().union(*(fiber(mapping,H,n,u) for u in D)))
    assert expr1 == expr2
    checked += 1
assert checked > 0
print("cases checked:", checked)
print("RESULT: PASS")
