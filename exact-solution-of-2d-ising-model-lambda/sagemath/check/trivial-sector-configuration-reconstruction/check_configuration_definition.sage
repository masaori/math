# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 式ペア: σ_A=(-1)^{s₂(t)} と二値スピンの対応
# 帰属: Z/2Z、NN、ZZ。浮動小数点を使わない。
import os

if '_rc_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

for q in _rc_ring:
    assert ZZ(-1) ** _rc_s2(q) == (ZZ(1) if q == 0 else ZZ(-1))
for case in _rc_cases:
    for vertex, q in case['t'].items():
        assert case['sigma'][vertex] == (ZZ(1) if q == 0 else ZZ(-1))
print("RESULT: PASS (代表元による整数の冪と復元配位)")
