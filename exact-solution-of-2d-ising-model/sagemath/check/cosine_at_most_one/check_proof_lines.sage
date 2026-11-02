# 対象ラベル: cosine_at_most_one
# 証明: c := cos v ≥ 0、c² = (√(1-(sin v)²))² = 1-(sin v)² ≤ 1。1 < c なら c² = c·c > 1·c > 1·1 = 1 で矛盾。
# 帰属: v を [-π/2, π/2] の π の有理数倍（-1/2 から 1/2 を 24 等分した q）に取り、sin・cos を AA で厳密に。
# 背理法の鎖は、c を QQ 上の不定元とした差の恒等式と、c > 1 の具体の有理数で確かめる。
load("../../_shared/sine_cosine_by_definition.sage")
qs = [QQ(k) / 24 for k in range(-12, 13)]
for q in qs:
    s = sin_exact(q)
    c = cos_exact(q)
    assert c >= 0                                   # def_cos と非負平方根
    assert c ^ 2 == sqrt_nonneg(1 - s ^ 2) ^ 2      # 1 行目
    assert c ^ 2 == 1 - s ^ 2                       # 2 行目
    assert s ^ 2 >= 0 and 1 - s ^ 2 <= 1            # 3 行目
    assert c <= 1                                   # 主張
print(f"v = qπ（q = -1/2..1/2 の {len(qs)} 点）で c ≥ 0、鎖の三行、主張 cos v ≤ 1 が AA で成り立つ")
R.<c> = QQ[]
assert c^2 - 1*c == c*(c - 1)          # c·c - 1·c = c(c-1) > 0（c > 1 > 0）
assert 1*c - 1*1 == c - 1              # 1·c - 1·1 = c - 1 > 0
for c0 in [QQ(101)/100, QQ(3)/2, QQ(2), QQ(10)]:
    assert c0 * c0 > 1 * c0 > 1 * 1 == 1
print("背理法の鎖（c·c > 1·c > 1·1 = 1）が差の恒等式と c > 1 の具体の値で成り立つ")
print("RESULT: PASS")
