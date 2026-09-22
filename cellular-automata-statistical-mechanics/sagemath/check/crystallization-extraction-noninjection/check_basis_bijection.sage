# 対象ラベル: claim_crystallization_extraction_not_injective
# 判定: q=0 評価後の各基底列が一つの基底行へ移り、抽出された対応が BxC から CxB への全単射であることを検査する。
# 帰属: 二つの有限集合と QQ[z,z^-1] 上の有限行列。複素数体、浮動小数点、解析的極限は使わない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

evaluated = evaluate_matrix_at_zero(R0)
extracted = {}
for column, source in enumerate(BC):
    nonzero_rows = [row for row in range(len(CB)) if evaluated[row, column] != 0]
    assert len(nonzero_rows) == 1
    target = CB[nonzero_rows[0]]
    assert target == swapped_basis(source)
    extracted[source] = target

assert len(extracted) == len(BC)
assert set(extracted.values()) == set(CB)
assert len(set(extracted.values())) == len(BC)
print('basis inputs checked:', len(extracted))
print('extracted basis table is bijective')
print('RESULT: PASS')
