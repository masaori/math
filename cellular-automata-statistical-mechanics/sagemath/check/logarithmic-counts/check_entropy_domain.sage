# 対象ラベル: def_binary_ca_fiber_logarithmic_entropy
# 式ペア・判定: 非空繊維の対数を復元し空繊維を拒否
# 帰属: 有限集合・ZZ・QQ・素数上の有限台整数ベクトル。実数複素数への脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
checked = 0
for size, mapping, H, n, fixed, D in fiber_rows():
    for u in range(-2,4):
        if u in D:
            S = entropy(mapping,H,n,u)
            assert reconstruct(S) == QQ(omega(mapping,H,n,u))/QQ(1)
            assert all(z in ZZ for z in S.values())
        else:
            try:
                entropy(mapping,H,n,u)
            except ValueError:
                pass  # 空繊維には値を与えない。
            else:
                raise AssertionError('zero fiber accepted')
    checked += 1
assert checked > 0
print("cases checked:", checked)
print("RESULT: PASS")
