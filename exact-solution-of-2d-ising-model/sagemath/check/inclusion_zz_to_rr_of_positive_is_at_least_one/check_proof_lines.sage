# 対象ラベル: inclusion_zz_to_rr_of_positive_is_at_least_one
# n ∈ ℤ_{≥1} について、n = 1 の 2 行と帰納法の段の 4 行を一行ずつ確かめる（ι は定義の再帰、比較は QQ の厳密な比較）。
load("../../_shared/inclusion_zz_to_rr_by_definition.sage")
io = iota_zz_to_rr
cnt = 0
# n = 1: ι(1) = 1 ≥ 1
assert io(1) == QQ(1); cnt += 1
assert QQ(1) >= QQ(1); cnt += 1
for n in range(1, 200):
    assert io(n) >= 1                                    # 帰納法の仮定（前の n で示したもの）
    L = io(n + 1)
    assert L == io(n) + QQ(1); cnt += 1                  # ι(n + 1) = ι(n) + 1（定義）
    assert io(n) + QQ(1) >= QQ(1) + QQ(1); cnt += 1      # 帰納法の仮定の両辺に 1 を足す
    assert QQ(1) + QQ(1) >= QQ(1) + QQ(0); cnt += 1      # 1 ≥ 0 の両辺に 1 を足す
    assert QQ(1) + QQ(0) == QQ(1); cnt += 1              # 0 は和の単位元
    assert L >= 1; cnt += 1                              # 主張の n + 1
    assert io(n) == QQ(n); cnt += 1                      # 組み込みの埋め込み（別の経路）
# 否定コントロール: 範囲を ℤ_{≥0} に広げると n = 0 で ι(0) = 0 < 1 になり主張は成り立たない
assert not (io(0) >= 1)
print(f"inclusion_zz_to_rr_of_positive_is_at_least_one: 比較 {cnt} 個 PASS")
