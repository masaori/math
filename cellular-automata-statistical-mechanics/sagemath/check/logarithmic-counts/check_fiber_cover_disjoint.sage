# 対象ラベル: claim_binary_ca_fiber_count_partition
# 式ペア・判定: 繊維の被覆と相異なる繊維の非交叉
# 帰属: 有限集合・ZZ・QQ・素数上の有限台整数ベクトル。実数複素数への脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
checked = 0
for size, mapping, H, n, fixed, D in fiber_rows():
    for x in fixed:
        assert H[x] in D and x in fiber(mapping,H,n,H[x])
    for u,v in product(D,repeat=2):
        if u != v:
            assert not (fiber(mapping,H,n,u) & fiber(mapping,H,n,v))
    assert set().union(*(fiber(mapping,H,n,u) for u in D)) == fixed
    checked += 1
assert checked > 0
print("cases checked:", checked)
print("RESULT: PASS")
