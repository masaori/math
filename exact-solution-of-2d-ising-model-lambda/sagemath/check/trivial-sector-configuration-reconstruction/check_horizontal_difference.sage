# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 式ペア: 横辺の道和差（空和と周期境界を含む）
# 帰属: Z/2Z、NN、ZZ。浮動小数点を使わない。
import os

if '_rc_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

for case in _rc_cases:
    L, t = case['L'], case['t']
    for i, j in vertices(L):
        assert t[(i,(j+1)%L)] + t[(i,j)] == case['bh'][(i,j)]
print("RESULT: PASS (横辺の道和差: %d 頂点、周期境界を含む)" %
      sum(len(case['t']) for case in _rc_cases))
