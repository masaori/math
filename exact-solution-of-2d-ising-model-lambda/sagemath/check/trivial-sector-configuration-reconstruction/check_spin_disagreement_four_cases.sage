# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 式ペア: 二元の四通りによる符号不一致と和が一の同値
# 帰属: Z/2Z、NN、ZZ。浮動小数点を使わない。
import os

if '_rc_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

for a in _rc_ring:
    for b in _rc_ring:
        assert (ZZ(-1) ** _rc_s2(a) != ZZ(-1) ** _rc_s2(b)) == (a + b == _rc_ring(1))
print("RESULT: PASS (符号不一致: 四通り)")
