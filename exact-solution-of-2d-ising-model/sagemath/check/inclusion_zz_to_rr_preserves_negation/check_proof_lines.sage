# 対象ラベル: inclusion_zz_to_rr_preserves_negation
# a ∈ ℤ について ι(-a) = -ι(a) を、証明の 5 行で一行ずつ確かめる
# （ι は定義の再帰、比較は QQ の厳密な等号。inclusion_zz_to_rr_preserves_difference の行は ι の再帰で計算した両辺を比べる）。
load("../../_shared/inclusion_zz_to_rr_by_definition.sage")
io = iota_zz_to_rr
cnt = 0
for a in range(-200, 201):
    a = ZZ(a)
    A = io(a)
    L = [io(-a), io(ZZ(0) - a), io(ZZ(0)) - A, QQ(0) - A, QQ(0) + (-A), -A]
    for x, y in zip(L, L[1:]):
        assert x == y; cnt += 1
    assert io(-a) == -io(a); cnt += 1                        # 主張
    assert io(-a) == QQ(-a); cnt += 1                        # 組み込みの埋め込み（別の経路）
# 否定コントロール: 定義の符号反転の節を ι''(-n) := ι(n) に取り違えた写像（ι''(n) = |n|）は符号反転を保たない
iota_wrong = lambda n: QQ(abs(n))
assert iota_wrong(-ZZ(3)) != -iota_wrong(ZZ(3))
print(f"inclusion_zz_to_rr_preserves_negation: 等号 {cnt} 個 PASS")
