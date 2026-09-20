# 対象ラベル: claim_finite_internal_scattering_compatibilities_decidable
# 判定: 固定した非自明な有限表について、部分作用表と内部散乱表の可換性を全入力で検査する。
# 帰属: 有限集合と有限写像表。実数体・複素数体・浮動小数点は使わない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

checked = ZZ(0)
for index, pair in product(I, product(B, C)):
    left = extend_r(apply_partial(index, pair))
    right = apply_partial(index, internal_r(pair))
    assert left == right
    checked += 1

assert checked == len(I) * len(B) * len(C)
print('operator compatibility inputs checked:', checked)
print('RESULT: PASS')

