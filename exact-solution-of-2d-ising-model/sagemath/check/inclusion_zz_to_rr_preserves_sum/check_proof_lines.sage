# 対象ラベル: inclusion_zz_to_rr_preserves_sum
# a, b ∈ ℤ について ι(a + b) = ι(a) + ι(b) を、b = 0 の 3 行、b → b + 1 の 5 行、b → b - 1 の 12 行で一行ずつ確かめる
# （ι は定義の再帰、比較は QQ の厳密な等号。inclusion_zz_to_rr_of_successor の行は ι の再帰で計算した両辺を比べる）。
load("../../_shared/inclusion_zz_to_rr_by_definition.sage")
io = iota_zz_to_rr
cnt = 0
R = range(-30, 31)
for a in R:
    a = ZZ(a)
    # b = 0
    L = [io(a + 0), io(a), io(a) + QQ(0), io(a) + io(0)]
    for x, y in zip(L, L[1:]):
        assert x == y; cnt += 1
    for b in R:
        b = ZZ(b)
        if b >= 0:
            # b ∈ ℤ_{≥0} から b + 1 へ
            L = [io(a + (b + 1)), io((a + b) + 1), io(a + b) + QQ(1), (io(a) + io(b)) + QQ(1),
                 io(a) + (io(b) + QQ(1)), io(a) + io(b + 1)]
            for x, y in zip(L, L[1:]):
                assert x == y; cnt += 1
        if b <= 0:
            # b ∈ ℤ_{≤0} から b - 1 へ
            L = [io(a + (b - 1)), io(a + (b - 1)) + QQ(0), io(a + (b - 1)) + (QQ(1) + QQ(-1)),
                 (io(a + (b - 1)) + QQ(1)) + QQ(-1), io((a + (b - 1)) + 1) + QQ(-1), io(a + ((b - 1) + 1)) + QQ(-1), io(a + b) + QQ(-1),
                 (io(a) + io(b)) + QQ(-1), io(a) + (io(b) + QQ(-1)), io(a) + (io((b - 1) + 1) + QQ(-1)),
                 io(a) + ((io(b - 1) + QQ(1)) + QQ(-1)), io(a) + (io(b - 1) + (QQ(1) + QQ(-1))),
                 io(a) + (io(b - 1) + QQ(0)), io(a) + io(b - 1)]
            for x, y in zip(L, L[1:]):
                assert x == y; cnt += 1
        assert io(a + b) == io(a) + io(b); cnt += 1          # 主張
        assert io(a + b) == QQ(a + b); cnt += 1               # 組み込みの埋め込み（別の経路）
# 否定コントロール: 負の元の節を ι'(-n) := ι(n) に取り違えた写像 ι' は ℤ 全体では和を保たない（ι'(1 + (-1)) = 0、ι'(1) + ι'(-1) = 2）
iota_wrong = lambda n: io(-n) if n < 0 else io(n)
assert iota_wrong(1 + (-1)) != iota_wrong(1) + iota_wrong(-1)
print(f"inclusion_zz_to_rr_preserves_sum: 等号 {cnt} 個 PASS")
