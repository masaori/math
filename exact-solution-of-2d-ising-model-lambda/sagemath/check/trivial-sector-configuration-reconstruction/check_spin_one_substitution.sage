# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 式ペア: (-1)^{s₂(u)} = (-1)^1 （s₂(u)=1 の場合）
# 帰属: Z/2Z、NN、ZZ。
import os

if '_rc_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

checked = 0
for u in _rc_ring:
    if _rc_s2(u) == 1:
        assert ZZ(-1) ** _rc_s2(u) == ZZ(-1) ** NN(1)
        checked += 1
assert checked == 1
print("RESULT: PASS (一代表の代入: %d 等式)" % checked)
