# 対象ラベル: claim_shifted_free_family_partition_value_does_not_determine_limit_quantity
# Z_2(1)=2^8 と Z'_2(1)=Z_3(1)=2^27 の不一致を ZZ 上で検証する。

site_count_2 = ZZ(2) ** ZZ(3)
site_count_3 = ZZ(3) ** ZZ(3)
partition_value_2 = ZZ(2) ** site_count_2
shifted_partition_value_2 = ZZ(2) ** site_count_3

assert site_count_2 == ZZ(8)
assert site_count_3 == ZZ(27)
assert partition_value_2 == ZZ(2) ** ZZ(8)
assert shifted_partition_value_2 == ZZ(2) ** ZZ(27)
assert partition_value_2 != shifted_partition_value_2

print("RESULT: PASS — Z_2(1)=2^8 != 2^27=Z'_2(1) を ZZ 上で確認")
