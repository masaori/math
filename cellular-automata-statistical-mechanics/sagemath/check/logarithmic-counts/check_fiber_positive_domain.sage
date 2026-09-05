# 対象ラベル: def_binary_ca_positive_fiber_levels
# 式ペア・判定: 正状態数の集合は不動点集合の像
# 帰属: 有限集合・ZZ・QQ・素数上の有限台整数ベクトル。実数複素数への脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
checked = 0
for size, mapping, H, n, fixed, D in fiber_rows():
    assert D == {u for u in set(H) if omega(mapping,H,n,u) > 0}
    assert D == {H[x] for x in fixed}
    for u in range(-2,4):
        assert fiber(mapping,H,n,u) <= fixed
        assert omega(mapping,H,n,u) in ZZ and omega(mapping,H,n,u) >= 0
        assert (u in D) == (omega(mapping,H,n,u) > 0)
    checked += 1
assert checked > 0
print("cases checked:", checked)
print("RESULT: PASS")
