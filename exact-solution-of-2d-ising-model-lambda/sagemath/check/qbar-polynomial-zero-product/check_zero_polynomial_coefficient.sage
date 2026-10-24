# 対象ラベル: claim_qbar_polynomial_zero_product
# 対象行: (0_{Qbar[t]})_k=0_{Qbar}
# 帰属: QQbar[t] / QQbar / ZZ。浮動小数点を使わない。
import os, sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), '_prelude.sage'))
for k in range(18):
    assert R.zero()[k] == zero
print('RESULT: PASS (zero_polynomial_coefficient)')
