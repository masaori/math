# 対象ラベル: cosine_zero
# 証明の鎖: cos 0 = √(1-(sin 0)²) = √(1-0²) = √1 = 1。すべて AA で厳密に確かめる。
load("../../_shared/sine_cosine_by_definition.sage")
s0 = sin_exact(0)
l1 = sqrt_nonneg(1 - s0 ^ 2)            # 1 行目: def_cos
l2 = sqrt_nonneg(1 - AA(0) ^ 2)         # 2 行目: sine_zero
l3 = sqrt_nonneg(AA(1))                 # 3 行目: 四則
assert s0 == 0 and l1 == l2 == l3
assert AA(1) >= 0 and AA(1) ^ 2 == 1    # 4 行目: 1 は 1 の非負平方根の条件を満たす
assert l3 == 1
assert cos_exact(0) == 1                # 主張（e^{i·0} の実部とも一致）
print("鎖の四行と主張 cos 0 = 1 が AA で成り立つ")
print("RESULT: PASS")
