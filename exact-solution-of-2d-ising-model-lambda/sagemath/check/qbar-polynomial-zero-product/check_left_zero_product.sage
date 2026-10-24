# 対象ラベル: claim_qbar_polynomial_zero_product
# 対象行: 0 g_j=0
# 帰属: QQbar[t] / QQbar / ZZ。浮動小数点を使わない。
import os, sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), '_prelude.sage'))
for f, g, m, n, pairs in fixtures:
    for a, b in pairs:
        if a < m:
            assert zero*g[b] == zero
print('RESULT: PASS (left_zero_product)')
