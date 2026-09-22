# 対象ラベル: claim_finite_top_coefficient_matrix_not_automatically_update
# 判定: 係数 -1 を持つ一セル反例の抽出行列が、二元集合上のどの自己写像の零一指示行列とも一致しない。
# 帰属: 一元の有限添字集合、二元の有限状態集合、ZZ。対数、除算、実数体、複素数体、浮動小数点は使わない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

index_set = ('i',)
states = ('x0', 'x1')
table_family = {
    (source, target): zero_table(index_set)
    for source, target in product(states, repeat=2)
}
table_family[('x0', 'x0')] = scale_table(-1, basis_table(index_set, index_set))
extracted = top_coefficient_matrix(index_set, states, table_family)

assert extracted[('x0', 'x0')] == ZZ(-1)
assert set(extracted.values()) == {ZZ(-1), ZZ(0)}

self_maps_checked = ZZ(0)
for images in product(states, repeat=len(states)):
    self_map = dict(zip(states, images))
    indicator = self_map_indicator_matrix(states, self_map)
    for source in states:
        assert sum(indicator[(source, target)] for target in states) == ZZ(1)
    assert set(indicator.values()).issubset({ZZ(0), ZZ(1)})
    assert extracted != indicator
    self_maps_checked += 1

assert self_maps_checked == len(states) ** len(states)
print('finite self maps checked:', self_maps_checked)
print('counterexample coefficient:', extracted[('x0', 'x0')])
print('RESULT: PASS')
