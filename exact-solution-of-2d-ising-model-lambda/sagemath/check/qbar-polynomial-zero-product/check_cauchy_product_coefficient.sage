# 対象ラベル: claim_qbar_polynomial_zero_product
# 対象行: (fg)_{m+n}=Σ_{i=0}^{m+n} f_i g_{m+n-i}
# 帰属: QQbar[t] / QQbar / ZZ。浮動小数点を使わない。
import os, sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), '_prelude.sage'))
for f, g, m, n, pairs in fixtures:
    lhs = (f*g)[m+n]
    rhs = sum((f[a]*g[m+n-a] for a in range(m+n+1)), zero)
    assert lhs == rhs
print('RESULT: PASS (cauchy_product_coefficient)')
