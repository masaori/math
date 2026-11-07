# 対象ラベル: inclusion_zz_to_rr_of_nonpositive_is_nonpositive
# n ∈ ℤ_{≤0} について、n = 0 の 2 行と n = -m（m ∈ ℤ_{≥1}）の 4 行を一行ずつ確かめる（ι は定義の再帰、比較は QQ の厳密な比較）。
load("../../_shared/inclusion_zz_to_rr_by_definition.sage")
io = iota_zz_to_rr
cnt = 0
# n = 0: ι(0) = 0 ≤ 0
assert io(0) == QQ(0); cnt += 1
assert QQ(0) <= QQ(0); cnt += 1
for m in range(1, 200):
    assert io(-m) == -io(m); cnt += 1                    # ι(-m) := -ι(m)（定義）
    assert io(m) >= 1                                    # inclusion_zz_to_rr_of_positive_is_at_least_one（n → m）
    assert -io(m) <= QQ(-1); cnt += 1                    # 両辺の符号を反転する
    assert QQ(-1) <= -QQ(0); cnt += 1                    # 1 ≥ 0 の両辺の符号を反転する
    assert -QQ(0) == QQ(0); cnt += 1                     # -0 = 0
    assert io(-m) <= 0; cnt += 1                         # 主張
    assert io(-m) == QQ(-m); cnt += 1                    # 組み込みの埋め込み（別の経路）
# 否定コントロール: ι(-n) := -ι(n) の節を ι'(-n) := ι(n) に取り違えた写像では、n = -1 で ι'(-1) = 1 > 0 になる
iota_wrong_neg = lambda n: io(-n) if n < 0 else io(n)
assert not (iota_wrong_neg(-1) <= 0)
print(f"inclusion_zz_to_rr_of_nonpositive_is_nonpositive: 比較 {cnt} 個 PASS")
