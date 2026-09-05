# 対象ラベル: def_binary_ca_logarithmic_free_count
# 式ペア・判定: 正総数の自由エントロピーと零総数の拒否
# 帰属: 有限集合・ZZ・QQ・素数上の有限台整数ベクトル。実数複素数への脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
checked = 0
for size, mapping, n in ca_count_rows():
    Z = count_fixed(mapping,n)
    if Z > 0:
        assert reconstruct(free_count(mapping,n)) == QQ(Z)/QQ(1)
    else:
        try:
            free_count(mapping,n)
        except ValueError:
            pass  # 零総数に対数を適用しない。
        else:
            raise AssertionError('zero total accepted')
    checked += 1
assert checked > 0
print("cases checked:", checked)
print("RESULT: PASS")
