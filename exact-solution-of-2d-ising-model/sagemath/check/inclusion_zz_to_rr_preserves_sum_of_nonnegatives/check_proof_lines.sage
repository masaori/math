# 対象ラベル: inclusion_zz_to_rr_preserves_sum_of_nonnegatives
# a, b ∈ ℤ_{≥0} について、b = 0 の 3 行と帰納法の段の 5 行を一行ずつ確かめる（ι は定義の再帰、比較は QQ の厳密な等号）。
load("../../_shared/inclusion_zz_to_rr_by_definition.sage")
io = iota_zz_to_rr
cnt = 0
for a in range(0, 30):
    L = [io(a + 0), io(a), io(a) + QQ(0), io(a) + io(0)]
    for x, y in zip(L, L[1:]):
        assert x == y; cnt += 1
    for b in range(0, 30):
        L = [io(a + (b + 1)), io((a + b) + 1), io(a + b) + QQ(1), (io(a) + io(b)) + QQ(1),
             io(a) + (io(b) + QQ(1)), io(a) + io(b + 1)]
        for x, y in zip(L, L[1:]):
            assert x == y; cnt += 1
        assert io(a + b) == io(a) + io(b); cnt += 1          # 主張
        assert io(a + b) == QQ(a + b); cnt += 1               # 組み込みの埋め込み（別の経路）
# 否定コントロール: 定義の ι(n + 1) := ι(n) + 1 を ι'(n + 1) := ι'(n) + 2 に、ι'(0) := 1 に取り違えた写像 ι' は、
# 範囲 a, b ≥ 0 の中で和を保たない（ι'(1 + 1) = 5、ι'(1) + ι'(1) = 6）
def iota_wrong(n):
    v = QQ(1)
    for _ in range(n):
        v = v + QQ(2)
    return v
assert iota_wrong(1 + 1) != iota_wrong(1) + iota_wrong(1)
print(f"inclusion_zz_to_rr_preserves_sum_of_nonnegatives: 等号 {cnt} 個 PASS")
