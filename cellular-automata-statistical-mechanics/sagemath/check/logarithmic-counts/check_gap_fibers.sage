# 対象ラベル: claim_binary_ca_logarithmic_gap_division_obstruction
# 式ペア・判定: 反例の四配位・繊維状態数1,2,1・正値域
# 帰属: 有限集合・ZZ・QQ・素数上の有限台整数ベクトル。実数複素数への脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
checked = 0
for mapping, H, n in gap_rows():
    assert fixed_set(mapping,n) == set(range(4))
    assert fiber(mapping,H,n,0) == {0}
    assert fiber(mapping,H,n,2) == {1,2}
    assert fiber(mapping,H,n,4) == {3}
    assert tuple(omega(mapping,H,n,u) for u in (0,2,4)) == (1,2,1)
    assert levels(mapping,H,n) == {0,2,4}
    for u in (-2,-1,1,3,5,6):
        assert fiber(mapping,H,n,u) == set()
    checked += 1
assert checked > 0
print("cases checked:", checked)
print("RESULT: PASS")
