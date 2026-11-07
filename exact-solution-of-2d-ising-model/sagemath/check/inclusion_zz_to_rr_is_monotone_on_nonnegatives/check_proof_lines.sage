# 対象ラベル: inclusion_zz_to_rr_is_monotone_on_nonnegatives
# a ≤ b（a, b ∈ ℤ_{≥0}）について、k := b − a の ι(k) ≥ 0 の二つの場合（各 2 行）と、ι(b) ≥ ι(a) の 4 行を一行ずつ確かめる
# （ι は定義の再帰、比較は QQ の厳密な比較）。
load("../../_shared/inclusion_zz_to_rr_by_definition.sage")
io = iota_zz_to_rr
cnt = 0
for a in range(0, 40):
    for b in range(a, 40):
        k = b - a
        assert k >= 0 and b == a + k; cnt += 2           # k ∈ ℤ_{≥0}、b = a + k
        if k == 0:
            assert io(0) == QQ(0) and QQ(0) >= QQ(0); cnt += 2
        else:
            assert io(k) >= QQ(1) and QQ(1) >= QQ(0); cnt += 2
        assert io(b) == io(a + k); cnt += 1              # b = a + k
        assert io(a + k) == io(a) + io(k); cnt += 1      # inclusion_zz_to_rr_preserves_sum_of_nonnegatives（b → k）
        assert io(a) + io(k) >= io(a) + QQ(0); cnt += 1  # ι(k) ≥ 0 の両辺に ι(a) を足す
        assert io(a) + QQ(0) == io(a); cnt += 1          # 0 は和の単位元
        assert io(a) <= io(b); cnt += 1                  # 主張
# 否定コントロール: 仮定 a ≤ b を外すと a = 1, b = 0 で ι(1) = 1 > 0 = ι(0) になる
assert not (io(1) <= io(0))
print(f"inclusion_zz_to_rr_is_monotone_on_nonnegatives: 比較 {cnt} 個 PASS")
