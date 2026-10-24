# 対象ラベル: claim_qbar_polynomial_zero_product
# 対象行: (fg)_{m+n}≠(0_{Qbar[t]})_{m+n}
# 帰属: QQbar[t] / QQbar / ZZ。浮動小数点を使わない。
import os, sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), '_prelude.sage'))
for f, g, m, n, pairs in fixtures:
    assert (f*g)[m+n] != R.zero()[m+n]
print('RESULT: PASS (nonzero_coefficient_contradiction)')
