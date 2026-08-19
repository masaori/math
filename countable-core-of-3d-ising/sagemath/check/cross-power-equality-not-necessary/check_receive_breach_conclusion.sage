# 対象ラベル: claim_shifted_free_family_cross_power_equality_is_not_necessary_for_limit_quantity
# 証明の第二段の可算側: 破れの主張 claim_shifted_free_family_cross_power_equality_fails_at_two の
# 結論 Z_2(2)^{27} ≠ Z_3(2)^{8} を独立に再計算して受け取り、
# 十分性の主張 claim_cross_power_equality_is_sufficient_for_limit_quantity の仮定
# 「すべての箱・すべての評価点での交差べき等式」が (q,L)=(2,2) で満たされないことを確認する。
# すべて ZZ 上の厳密計算。

import os

_dir = os.path.dirname(__file__)
load(os.path.join(_dir, "..", "..", "_shared", "defs.sage"))

value_2 = free_partition_value_by_fast_layer_transfer(2, ZZ(2))
value_3 = free_partition_value_by_fast_layer_transfer(3, ZZ(2))

assert value_2 == ZZ(36450)
assert value_3 == ZZ(942223653336523266)

# 交差べき等式 Z_2(2)^{N_3} = Z_3(2)^{N_2}（N_2=8, N_3=27）が破れること。
assert value_2 ** 27 != value_3 ** 8

print("RESULT: PASS — Z_2(2)^27 ≠ Z_3(2)^8 を ZZ 上で再計算して確認（交差べき等式の仮定は (q,L)=(2,2) で破れる）")
