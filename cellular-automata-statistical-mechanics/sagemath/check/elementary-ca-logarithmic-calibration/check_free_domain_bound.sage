# 対象ラベル: claim_binary_ca_logarithmic_free_count_bound
# 式ペア・判定: 正総数の Φ を復元し有理数上界と移送順序を照合、零総数を拒否
# 帰属: 有限集合・ZZ・QQ・素数上の有限台整数ベクトル。実数複素数への脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
positive = zero = 0
for size, rule, configs, mapping, n, fixed in time_rows():
    if fixed:
        q = QQ(len(fixed))/QQ(1)
        assert 1 <= q <= QQ(2**size)/QQ(1)
        phi = row_free(fixed)
        assert reconstruct(phi) == q
        assert less_equal({},phi)
        assert less_equal(phi,logarithm(QQ(2**size)))
        positive += 1
    else:
        try:
            row_free(fixed)
        except ValueError as error:
            assert str(error) == 'positive rational required'
        else:
            raise AssertionError('zero total accepted')
        zero += 1
assert positive > 0 and zero > 0
print('positive:',positive,'zero:',zero)

print("RESULT: PASS")
