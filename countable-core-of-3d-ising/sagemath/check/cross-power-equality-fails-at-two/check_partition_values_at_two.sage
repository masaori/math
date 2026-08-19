# 対象ラベル: claim_shifted_free_family_cross_power_equality_fails_at_two
# 証明の第一段: Z_2(2)=36450 と Z_3(2)=942223653336523266 を ZZ 上の有限計算で決定する。
# 層転送（_shared/defs.sage の free_partition_value_by_fast_layer_transfer）で厳密に評価し、
# L=2 は全列挙による定義どおりの有限和とも突き合わせる。

import os

_dir = os.path.dirname(__file__)
load(os.path.join(_dir, "..", "..", "_shared", "defs.sage"))

value_2 = free_partition_value_by_fast_layer_transfer(2, ZZ(2))
value_3 = free_partition_value_by_fast_layer_transfer(3, ZZ(2))

assert value_2 == ZZ(36450)
assert value_3 == ZZ(942223653336523266)

# L=2 は定義どおりの全列挙（2^8 配位の有限和）でも同じ値になることを確認する。
polynomial_2 = partition_polynomial_by_enumeration(2, free_box_edges(2))
assert polynomial_2(ZZ(2)) == ZZ(36450)

print("RESULT: PASS — Z_2(2)=36450, Z_3(2)=942223653336523266 を ZZ 上で確認")
