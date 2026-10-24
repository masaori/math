# 対象ラベル: claim_qbar_polynomial_zero_product
# 対象行: f_m≠0、g_n≠0
# 帰属: QQbar[t] / QQbar / ZZ。浮動小数点を使わない。
import os, sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), '_prelude.sage'))
for f, g, m, n, pairs in fixtures:
    assert f[m] != zero and g[n] != zero
print('RESULT: PASS (least_coefficients_nonzero)')
