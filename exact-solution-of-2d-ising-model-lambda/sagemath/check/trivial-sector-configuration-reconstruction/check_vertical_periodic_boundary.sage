# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 式ペア: 末尾の行で列和零から同じ縦辺差を確認
# 帰属: Z/2Z、NN、ZZ。浮動小数点を使わない。
import os

if '_rc_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

checked = 0
for case in _rc_cases:
    L = case['L']
    for j in range(L):
        assert sum((case['bv'][(i,j)] for i in range(L)), _rc_ring(0)) == 0
    for row in case['vertical']:
        if row['i'] == L - 1:
            assert row['difference'] == row['expanded']
            assert row['difference'] == row['target']
            checked += 1
print("RESULT: PASS (縦辺差の周期境界: %d 頂点、L=1 を含む)" % checked)
