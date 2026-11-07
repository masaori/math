# 対象ラベル: inclusion_zz_to_rr_of_one
# 鎖 ι(1) = ι(0 + 1) = ι(0) + 1_ℝ = 0_ℝ + 1_ℝ = 1_ℝ を、ι を定義の再帰で作って一行ずつ確かめる（QQ の厳密な比較）。
load("../../_shared/inclusion_zz_to_rr_by_definition.sage")
L = [iota_zz_to_rr(1), iota_zz_to_rr(0 + 1), iota_zz_to_rr(0) + QQ(1), QQ(0) + QQ(1), QQ(1)]
for x, y in zip(L, L[1:]):
    assert x == y
assert iota_zz_to_rr(1) == QQ(ZZ(1))   # Sage の組み込みの埋め込み（別の経路）
# 否定コントロール: 定義の ι(0) := 0 を ι'(0) := 1 に取り違えた写像 ι' では、同じ鎖の値が 1_ℝ にならない
def iota_wrong_start(n):
    v = QQ(1)
    for _ in range(n):
        v = v + QQ(1)
    return v
assert iota_wrong_start(1) != QQ(1)
print("inclusion_zz_to_rr_of_one: 等号 4 個 PASS")
