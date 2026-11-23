# 対象ラベル: inclusion_zz_to_rr_preserves_product
# a, b ∈ ℤ について ι(ab) = ι(a)ι(b) を、b = 0 の 5 行、b → b + 1 の 7 行、b → b - 1 の 20 行で一行ずつ確かめる
# （ι は定義の再帰、比較は QQ の厳密な等号。inclusion_zz_to_rr_preserves_sum・inclusion_zz_to_rr_of_successor の行は ι の再帰で計算した両辺を比べる）。
load("../../_shared/inclusion_zz_to_rr_by_definition.sage")
io = iota_zz_to_rr
cnt = 0
R = range(-30, 31)
for a in R:
    a = ZZ(a)
    # b = 0
    L = [io(a * 0), io(0 * a), io(0), QQ(0), io(a) * QQ(0), io(a) * io(0)]   # ℤ の乗法の交換律、int_zero_times_is_zero、…
    for x, y in zip(L, L[1:]):
        assert x == y; cnt += 1
    for b in R:
        b = ZZ(b)
        if b >= 0:
            # b ∈ ℤ_{≥0} から b + 1 へ
            L = [io(a * (b + 1)), io(a * b + a * 1), io(a * b + a), io(a * b) + io(a),
                 io(a) * io(b) + io(a), io(a) * io(b) + io(a) * QQ(1), io(a) * (io(b) + QQ(1)), io(a) * io(b + 1)]
            for x, y in zip(L, L[1:]):
                assert x == y; cnt += 1
        if b <= 0:
            # b ∈ ℤ_{≤0} から b - 1 へ
            A = io(a)
            L = [io(a * (b - 1)), io(a * (b - 1)) + QQ(0), io(a * (b - 1)) + (A + (-A)),
                 (io(a * (b - 1)) + A) + (-A), io(a * (b - 1) + a) + (-A),
                 io(a * (b + (-1)) + a) + (-A),            # def_int_difference（y → b, z → 1）
                 io((a * b + a * (-1)) + a) + (-A),        # ℤ の分配律 x(y + t) = xy + xt（t → -1）
                 io((a * b + (-1) * a) + a) + (-A),        # ℤ の乗法の交換律
                 io((a * b + (-(1 * a))) + a) + (-A),      # int_negation_times_is_negation_of_product（x → 1, t → a）
                 io((a * b + (-(a * 1))) + a) + (-A),      # ℤ の乗法の交換律
                 io((a * b - a * 1) + a) + (-A),           # def_int_difference を右辺から左辺へ
                 io((a * b - a) + a) + (-A), io(a * b) + (-A),
                 A * io(b) + (-A), A * io((b - 1) + 1) + (-A), A * (io(b - 1) + QQ(1)) + (-A),
                 (A * io(b - 1) + A * QQ(1)) + (-A), (A * io(b - 1) + A) + (-A),
                 A * io(b - 1) + (A + (-A)), A * io(b - 1) + QQ(0), A * io(b - 1)]
            for x, y in zip(L, L[1:]):
                assert x == y; cnt += 1
        assert io(a * b) == io(a) * io(b); cnt += 1          # 主張
        assert io(a * b) == QQ(a * b); cnt += 1               # 組み込みの埋め込み（別の経路）
# 否定コントロール: 定義の後者の節を ι''(n + 1) := ι''(n) + 2 に取り違えた写像（ι''(n) = 2n）は積を保たない
iota_wrong2 = lambda n: 2 * QQ(n)
assert iota_wrong2(ZZ(3) * ZZ(-2)) != iota_wrong2(3) * iota_wrong2(-2)
print(f"inclusion_zz_to_rr_preserves_product: 等号 {cnt} 個 PASS")
