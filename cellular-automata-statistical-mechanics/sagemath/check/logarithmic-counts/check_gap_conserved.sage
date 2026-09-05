# 対象ラベル: claim_binary_ca_logarithmic_gap_division_obstruction
# 式ペア・判定: 反例の保存写像と帰納基底
# 帰属: 有限集合・ZZ・QQ・素数上の有限台整数ベクトル。実数複素数への脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
checked = 0
for x in range(4):
    assert GAP_H[GAP_MAP[x]] == GAP_H[x]
    assert image_at(GAP_MAP,x,0) == x
    checked += 1
assert checked > 0
print("cases checked:", checked)
print("RESULT: PASS")
