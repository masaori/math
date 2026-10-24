# 対象ラベル: claim_qbar_polynomial_zero_product
# 対象行: fg=0 ⇒ (fg)_k=(0_{Qbar[t]})_k
# 帰属: QQbar[t] / QQbar / ZZ。浮動小数点を使わない。
import os, sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), '_prelude.sage'))
for f, g in zero_product_fixtures:
    assert f*g == R.zero()
    for k in range(18):
        assert (f*g)[k] == R.zero()[k]
print('RESULT: PASS (zero_polynomial_coefficient_substitution)')
