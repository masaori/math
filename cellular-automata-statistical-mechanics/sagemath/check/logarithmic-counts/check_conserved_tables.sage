# 対象ラベル: def_binary_ca_integer_conserved_observable
# 式ペア・判定: 全配位の保存条件と反復中の保存
# 帰属: 有限集合・ZZ・QQ・素数上の有限台整数ベクトル。実数複素数への脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
checked = 0
for size, mapping, H, n, fixed, D in fiber_rows():
    assert all(H[mapping[x]] == H[x] for x in range(len(mapping)))
    assert all(H[image_at(mapping,x,n)] == H[x] for x in range(len(mapping)))
    checked += 1
assert checked > 0
print("cases checked:", checked)
print("RESULT: PASS")
