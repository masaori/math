# 対象ラベル: claim_finite_signed_coefficient_extraction_decidable
# 併せて検証: def_finite_top_coefficient_matrix
# 判定: 有限係数表族の最高次成分を読み、指定した整数係数行列が得られることを全成分で検査する。
# 帰属: 有限集合、有限冪集合、ZZ。対数、除算、実数体、複素数体、浮動小数点は使わない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

index_set = (ZZ(0), ZZ(1), ZZ(2))
states = ('x', 'y', 'z')
expected = {
    ('x', 'x'): ZZ(-3), ('x', 'y'): ZZ(0), ('x', 'z'): ZZ(5),
    ('y', 'x'): ZZ(2), ('y', 'y'): ZZ(-1), ('y', 'z'): ZZ(4),
    ('z', 'x'): ZZ(0), ('z', 'y'): ZZ(7), ('z', 'z'): ZZ(-6),
}
table_family = {}
top_support = frozenset(index_set)

for row, (source, target) in enumerate(product(states, repeat=2)):
    table = zero_table(index_set)
    table[top_support] = expected[(source, target)]
    table[frozenset()] = ZZ(row + 1)
    table[frozenset((ZZ(row % 3),))] = ZZ(-(row + 2))
    table_family[(source, target)] = table

extracted = top_coefficient_matrix(index_set, states, table_family)
assert extracted == expected
for source, target in product(states, repeat=2):
    assert extracted[(source, target)] == table_family[(source, target)][top_support]

print('coefficient tables checked:', len(table_family))
print('matrix entries checked:', len(extracted))
print('RESULT: PASS')
