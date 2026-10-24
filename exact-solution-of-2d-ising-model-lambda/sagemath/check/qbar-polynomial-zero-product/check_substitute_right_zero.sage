# 対象ラベル: claim_qbar_polynomial_zero_product
# 対象行: f_i g_j=f_i 0（j<n）
# 帰属: QQbar[t] / QQbar / ZZ。浮動小数点を使わない。
import os, sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), '_prelude.sage'))
for f, g, m, n, pairs in fixtures:
    for a, b in pairs:
        if b < n:
            assert f[a]*g[b] == f[a]*zero
print('RESULT: PASS (substitute_right_zero)')
