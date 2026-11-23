# 対象ラベル: inclusion_zz_to_rr_of_successor
# n ∈ ℤ について ι(n + 1) = ι(n) + 1 を、n ∈ ℤ_{≥0} の 1 行、n = -1 の 5 行、n = -(p + 1)（p ∈ ℤ_{≥1}）の 11 行の場合分けで一行ずつ確かめる
# （ι は定義の再帰、比較は QQ の厳密な等号）。
load("../../_shared/inclusion_zz_to_rr_by_definition.sage")
io = iota_zz_to_rr
cnt = 0
# n ∈ ℤ_{≥0}: ι(n + 1) = ι(n) + 1（定義）
for n in range(0, 200):
    assert io(n + 1) == io(n) + QQ(1); cnt += 1
# n = -1: ι((-1) + 1) = ι(0) = 0 = (-1) + 1 = (-ι(1)) + 1 = ι(-1) + 1
L = [io(ZZ(-1) + 1), io(0), QQ(0), QQ(-1) + QQ(1), (-io(1)) + QQ(1), io(-1) + QQ(1)]
for x, y in zip(L, L[1:]):
    assert x == y; cnt += 1
# n = -(p + 1)（p ∈ ℤ_{≥1}）:
for p in range(1, 200):
    L = [io(-(p + 1) + 1), io(((-p) + (-1)) + 1), io((-p) + ((-1) + 1)), io((-p) + 0), io(-p), -io(p), (-io(p)) + QQ(0), (-io(p)) + (QQ(-1) + QQ(1)),
         ((-io(p)) + QQ(-1)) + QQ(1), -(io(p) + QQ(1)) + QQ(1), -io(p + 1) + QQ(1), io(-(p + 1)) + QQ(1)]
    for x, y in zip(L, L[1:]):
        assert x == y; cnt += 1
# 主張と、組み込みの埋め込み QQ(n)（別の経路）との一致
for n in range(-200, 200):
    assert io(n + 1) == io(n) + QQ(1); cnt += 1
    assert io(n) == QQ(n); cnt += 1
# 否定コントロール: 定義の負の元の節 ι(-n) := -ι(n) を ι'(-n) := -ι(n) - 1 に取り違えた写像 ι' では、n = -1 で ι'(0) = 0 ≠ -1 = ι'(-1) + 1
def iota_wrong(n):
    n = ZZ(n)
    return -io(-n) - QQ(1) if n < 0 else io(n)
assert iota_wrong(ZZ(-1) + 1) != iota_wrong(-1) + QQ(1)
print(f"inclusion_zz_to_rr_of_successor: 等号 {cnt} 個 PASS")
