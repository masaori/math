# 対象ラベル: claim_qbar_polynomial_zero_product
# 対象行: Σ_{i+j=m+n} f_i g_j=f_m g_n+Σ_{(i,j)≠(m,n)} f_i g_j
# 帰属: QQbar[t] / QQbar / ZZ。浮動小数点を使わない。
import os, sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), '_prelude.sage'))
for f, g, m, n, pairs in fixtures:
    lhs = sum((f[a]*g[b] for a, b in pairs), zero)
    rhs = f[m]*g[n] + sum((f[a]*g[b] for a, b in pairs if (a,b) != (m,n)), zero)
    assert lhs == rhs
print('RESULT: PASS (isolate_least_pair)')
