# 対象ラベル: claim_qbar_polynomial_zero_product
# 対象行: f_m g_n+0=f_m g_n
# 帰属: QQbar[t] / QQbar / ZZ。浮動小数点を使わない。
import os, sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), '_prelude.sage'))
for f, g, m, n, pairs in fixtures:
    assert f[m]*g[n]+zero == f[m]*g[n]
print('RESULT: PASS (remove_additive_zero)')
