# 対象ラベル: inclusion_zz_to_rr_of_power_of_two
# M ∈ ℤ_{≥0} について、M = 0 の 3 行と帰納法の段の 10 行を一行ずつ確かめる。
# ℤ の冪は def_power_of_integer の再帰で 2_ℤ := 1_ℤ + 1_ℤ（ZZ）について作り、ℝ の冪は def_power_of_real_number の再帰で 2_ℝ := 1_ℝ + 1_ℝ（QQ）について作る。ι は inclusion_zz_to_rr の再帰。
load("../../_shared/inclusion_zz_to_rr_by_definition.sage")
io = iota_zz_to_rr
two = QQ(1) + QQ(1)
pw = lambda m: power_of_real_by_definition(two, m)
cnt = 0
pz = lambda m: power_of_integer_by_definition(ZZ(1) + ZZ(1), m)
L = [io(pz(0)), io(1), QQ(1), pw(0)]
for x, y in zip(L, L[1:]):
    assert x == y; cnt += 1
for M in range(0, 13):
    t = pz(M)
    assert t >= 0; cnt += 1                                    # power_of_two_in_integers_is_at_least_one より 2_ℤ^M ∈ ℤ_{≥0}
    L = [io(pz(M + 1)), io(t * 2), io(t * (ZZ(1) + ZZ(1))), io(t * 1 + t * 1), io(t + t), io(t) + io(t),
         pw(M) + pw(M), pw(M) * 1 + pw(M) * 1,
         pw(M) * (QQ(1) + QQ(1)), pw(M) * two, pw(M + 1)]
    for x, y in zip(L, L[1:]):
        assert x == y; cnt += 1
    assert io(t) == pw(M); cnt += 1                            # 主張
    assert io(t) == QQ(2)**M; cnt += 1                         # 組み込みの冪（別の経路）
    assert t == ZZ(2)**M; cnt += 1                             # ℤ の冪の再帰と組み込みの冪
# 否定コントロール: ℝ の側の底を 3 に取り違えると M = 1 で合わない
assert io(pz(1)) != power_of_real_by_definition(QQ(3), 1)
print(f"inclusion_zz_to_rr_of_power_of_two: 等号 {cnt} 個 PASS")
