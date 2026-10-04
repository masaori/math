# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 式ペア: 自然数代表 s₂ の帰属と π₂(s₂(a))=a
# 帰属: Z/2Z、NN、ZZ。浮動小数点を使わない。
import os

if '_rc_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

for q in _rc_ring:
    assert _rc_s2(q) in NN and _rc_s2(q) in (NN(0), NN(1))
    assert _rc_ring(_rc_s2(q)) == q
print("RESULT: PASS (自然数代表: 二元)")
