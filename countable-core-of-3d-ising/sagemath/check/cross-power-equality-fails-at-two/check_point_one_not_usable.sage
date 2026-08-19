# 対象ラベル: claim_shifted_free_family_cross_power_equality_fails_at_two
# 評価点 1 では破れが出ないことの確認: Z_2(1)=2^8, Z_3(1)=2^27 なので
# Z_2(1)^27 = 2^216 = Z_3(1)^8 と両辺が一致し、評価点 1 は反例に使えない。

value_2_at_one = ZZ(2) ** (ZZ(2) ** 3)
value_3_at_one = ZZ(2) ** (ZZ(3) ** 3)

assert value_2_at_one == ZZ(2) ** 8
assert value_3_at_one == ZZ(2) ** 27
assert value_2_at_one ** 27 == ZZ(2) ** 216
assert value_3_at_one ** 8 == ZZ(2) ** 216
assert value_2_at_one ** 27 == value_3_at_one ** 8

print("RESULT: PASS — 評価点 1 では Z_2(1)^27 = 2^216 = Z_3(1)^8 で破れが出ないことを確認")
