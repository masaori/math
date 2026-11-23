# 対象ラベル: inclusion_zz_to_rr_preserves_difference
# a, b ∈ ℤ について ι(a - b) = ι(a) - ι(b) を、証明の 9 行で一行ずつ確かめる
# （ι は定義の再帰、比較は QQ の厳密な等号。inclusion_zz_to_rr_preserves_sum の行は ι の再帰で計算した両辺を比べる）。
load("../../_shared/inclusion_zz_to_rr_by_definition.sage")
io = iota_zz_to_rr
cnt = 0
R = range(-30, 31)
for a in R:
    a = ZZ(a)
    for b in R:
        b = ZZ(b)
        B = io(b)
        L = [io(a - b), io(a - b) + QQ(0), io(a - b) + (B + (-B)), (io(a - b) + B) + (-B),
             io((a - b) + b) + (-B),
             io((a + (-b)) + b) + (-B),      # def_int_difference（y → a, z → b）
             io(a + ((-b) + b)) + (-B),      # ℤ の和の結合律
             io(a + ZZ(0)) + (-B),           # ℤ の加法逆元 (−x) + x = 0（x → b）
             io(a) + (-B), io(a) - B]        # ℤ の和の単位元、def_real_difference
        for x, y in zip(L, L[1:]):
            assert x == y; cnt += 1
        assert a - b == a + (-b); cnt += 1                    # def_int_difference の式（ZZ の差と比べる）
        assert io(a - b) == io(a) - io(b); cnt += 1          # 主張
        assert io(a - b) == QQ(a - b); cnt += 1               # 組み込みの埋め込み（別の経路）
# 否定コントロール: 定義の符号反転の節を ι''(-n) := ι(n) に取り違えた写像（ι''(n) = |n|）は差を保たない
iota_wrong = lambda n: QQ(abs(n))
assert iota_wrong(ZZ(1) - ZZ(3)) != iota_wrong(1) - iota_wrong(3)
print(f"inclusion_zz_to_rr_preserves_difference: 等号 {cnt} 個 PASS")
