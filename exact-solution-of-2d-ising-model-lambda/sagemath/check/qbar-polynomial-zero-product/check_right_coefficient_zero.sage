# 対象ラベル: claim_qbar_polynomial_zero_product
# 対象行: j<n ⇒ g_j=0
# 帰属: QQbar[t] / QQbar / ZZ。浮動小数点を使わない。
import os, sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), '_prelude.sage'))
count = 0
for f, g, m, n, pairs in fixtures:
    for a, b in pairs:
        if b < n:
            assert g[b] == zero
            count += 1
assert count > 0
print('RESULT: PASS (right_coefficient_zero)')
