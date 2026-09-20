# 対象ラベル: claim_finite_internal_scattering_compatibilities_decidable
# 判定: 整数値表の差分が +1、-1、0 の三分岐と一致することを定義域の全入力で検査する。
# 帰属: 有限集合、有限写像表、ZZ。除算・対数・実数体・複素数体は使わない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

checked = ZZ(0)
seen = set()
for index, pair in product(I, product(B, C)):
    image = apply_partial(index, pair)
    if image is BOTTOM:
        continue
    difference = H[image] - H[pair]
    expected = expected_energy_difference(index, pair)
    assert difference == expected
    seen.add(expected)
    checked += 1

assert seen == {ZZ(-1), ZZ(0), ZZ(1)}
assert checked == 4
print('integer difference inputs checked:', checked)
print('difference branches checked:', sorted(seen))
print('RESULT: PASS')

