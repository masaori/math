# 対象ラベル: claim_qbar_polynomial_zero_product
# 対象行: f_m g_n+Σ 0=f_m g_n+0
# 帰属: QQbar[t] / QQbar / ZZ。浮動小数点を使わない。
import os, sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), '_prelude.sage'))
for f, g, m, n, pairs in fixtures:
    off_diagonal = [(a,b) for a,b in pairs if (a,b) != (m,n)]
    assert f[m]*g[n]+sum((zero for a,b in off_diagonal), zero) == f[m]*g[n]+zero
print('RESULT: PASS (sum_of_zeros)')
