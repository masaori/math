# 対象ラベル: def_binary_ca_unit_logarithmic_difference
# 式ペア・判定: 両端が正の隣接値だけを受理
# 帰属: 有限集合・ZZ・QQ・素数上の有限台整数ベクトル。実数複素数への脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
checked = 0
for size, mapping, H, n, fixed, D in fiber_rows():
    for u in range(-2,4):
        condition = u in D and u+1 in D
        if condition:
            assert reconstruct(beta(mapping,H,n,u)) == QQ(omega(mapping,H,n,u+1))/omega(mapping,H,n,u)
        else:
            try:
                beta(mapping,H,n,u)
            except ValueError:
                pass  # 少なくとも片端が零の差は定義しない。
            else:
                raise AssertionError('undefined adjacent difference accepted')
    checked += 1
assert checked > 0
print("cases checked:", checked)
print("RESULT: PASS")
