# 対象ラベル: claim_binary_ca_logarithmic_gap_division_obstruction
# 式ペア・判定: 非整除の証人と空の隣接定義域
# 帰属: 有限集合・ZZ・QQ・素数上の有限台整数ベクトル。実数複素数への脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
checked = 0
for mapping, H, n in gap_rows():
    delta = sub(entropy(mapping,H,n,2),entropy(mapping,H,n,0))
    assert coefficient(delta,ZZ(2)) == 1
    assert coefficient(delta,ZZ(2)) % 2 != 0
    try:
        divide(2,delta)
    except ValueError:
        pass  # 非整除の証人があり、整数除算を拒否する。
    else:
        raise AssertionError('gap quotient accepted')
    D = levels(mapping,H,n)
    assert {u for u in D if u+1 in D} == set()
    checked += 1
assert checked > 0
print("cases checked:", checked)
print("RESULT: PASS")
