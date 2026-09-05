# 対象ラベル: claim_binary_ca_logarithmic_gap_division_obstruction
# 式ペア・判定: (Fx)(z)=f_z(x の制限)
# 帰属: 有限集合・ZZ・QQ・素数上の有限台整数ベクトル。実数複素数への脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
checked = 0
for x, z in product(GAP_CONFIGS,range(2)):
    expr1 = gap_global(x)[z]
    expr2 = gap_local(gap_restrict(x,z),z)
    assert expr1 == expr2
    checked += 1
assert checked > 0
print("cases checked:", checked)
print("RESULT: PASS")
