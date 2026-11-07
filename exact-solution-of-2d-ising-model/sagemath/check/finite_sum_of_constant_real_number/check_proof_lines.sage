# 対象ラベル: finite_sum_of_constant_real_number
# m ∈ ℤ_{≥1}、r ∈ ℝ について、m = 1 の 3 行と帰納法の段の 5 行を一行ずつ確かめる。
# 有限和は def_finite_sum_of_real_numbers の再帰、ι は inclusion_zz_to_rr の再帰。r は QQ と AA の元（厳密な比較）。
load("../../_shared/inclusion_zz_to_rr_by_definition.sage")
io = iota_zz_to_rr
cnt = 0
for r in [QQ(0), QQ(1), QQ(-3)/7, QQ(5), AA(2).sqrt(), AA(3).sqrt() - 1]:
    S = lambda m: finite_sum_by_definition([r] * m)
    L = [S(1), r, 1 * r, io(1) * r]
    for x, y in zip(L, L[1:]):
        assert x == y; cnt += 1
    for m in range(1, 40):
        L = [S(m + 1), S(m) + r, io(m) * r + r, io(m) * r + 1 * r, (io(m) + 1) * r, io(m + 1) * r]
        for x, y in zip(L, L[1:]):
            assert x == y; cnt += 1
        assert S(m) == io(m) * r; cnt += 1                     # 主張
        assert S(m) == m * r; cnt += 1                         # 組み込みの整数倍（別の経路）
# 否定コントロール: 項の数を一つ取り違えた ι(m+1) r は、r ≠ 0 なら合わない
assert finite_sum_by_definition([QQ(5)] * 3) != io(4) * QQ(5)
print(f"finite_sum_of_constant_real_number: 等号 {cnt} 個 PASS")
