# 対象ラベル: power_of_two_in_integers_is_at_least_one
# M ∈ ℤ_{≥0} について、M = 0 の 2 行と帰納法の段の 8 行を一行ずつ確かめる。冪は def_power_of_integer の再帰（ZZ の厳密な比較）。
load("../../_shared/inclusion_zz_to_rr_by_definition.sage")
two = ZZ(1) + ZZ(1)
pz = lambda m: power_of_integer_by_definition(two, m)
cnt = 0
assert pz(0) == 1 and 1 >= 1; cnt += 2
for M in range(0, 40):
    t = pz(M)
    assert t >= 1; cnt += 1                                    # 帰納法の仮定
    L = [pz(M + 1), t * two, t * (ZZ(1) + ZZ(1)), t * 1 + t * 1, t + t]
    for x, y in zip(L, L[1:]):
        assert x == y; cnt += 1
    assert t + t >= 1 + t >= 1 + 1 >= 1 + 0 == 1; cnt += 4
    assert pz(M + 1) >= 1 and pz(M + 1) == ZZ(2)**(M + 1); cnt += 2   # 主張と組み込みの冪
# 否定コントロール: 底を 0_ℤ に取り違えると M = 1 で 1 以上にならない
assert power_of_integer_by_definition(ZZ(0), 1) < 1
print(f"power_of_two_in_integers_is_at_least_one: 比較 {cnt} 個 PASS")
