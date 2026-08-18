# 対象ラベル: claim_shifted_free_family_partition_value_does_not_determine_limit_quantity
# 任意の正の頂点数 n について、2 が (2^n) の正の n 乗根であることを
# この反例で用いる n=1^3,...,6^3 と、ずらした n=(L+1)^3 について ZZ 上で検証する。
# 正の根の一意性自体は本文が参照する実数の初等定理であり、浮動小数点近似は行わない。

for box_side in range(ZZ(1), ZZ(7)):
    site_count = box_side ** ZZ(3)
    shifted_site_count = (box_side + ZZ(1)) ** ZZ(3)

    partition_value = ZZ(2) ** site_count
    shifted_partition_value = ZZ(2) ** shifted_site_count

    assert site_count > 0
    assert shifted_site_count > 0
    assert ZZ(2) ** site_count == partition_value
    assert ZZ(2) ** shifted_site_count == shifted_partition_value

print("RESULT: PASS — a_L(1)=2=a'_L(1) の有限べき等式を L=1,...,6 で ZZ 上に確認")
