# 対象ラベル: claim_qbar_polynomial_zero_product
# 対象行: i↦(i,m+n-i) と (i,j)↦i は互いに逆
# 帰属: QQbar[t] / QQbar / ZZ。浮動小数点を使わない。
import os, sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), '_prelude.sage'))
for f, g, m, n, pairs in fixtures:
    bound = m+n
    enumerated_pairs = [(a,b) for a in range(bound+1) for b in range(bound+1) if a+b == bound]
    assert set(enumerated_pairs) == set(pairs)
    for a in range(bound+1):
        assert (a, bound-a)[0] == a
    for a,b in enumerated_pairs:
        assert (a, bound-a) == (a,b)
print('RESULT: PASS (antidiagonal_bijection)')
