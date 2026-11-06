# 対象ラベル: finite_sum_of_real_numbers_is_monotone
# すべての j で a_j ≤ b_j なら Σ a_j ≤ Σ b_j の帰納法の各行（m = 1 の 3 行、m → m+1 の 4 行）を、有理数の列で確かめる。
# 帰属: QQ。浮動小数点は使わない。
def fsum(rs):
    s = rs[0]
    for r in rs[1:]:
        s = s + r
    return s


set_random_seed(20261106)
n = 0
for trial in range(200):
    m1 = randint(1, 9)
    a = [QQ(randint(-20, 20)) / randint(1, 6) for _ in range(m1)]
    b = [x + QQ(randint(0, 10)) / randint(1, 4) for x in a]           # a_j ≤ b_j
    if m1 == 1:
        assert fsum(a) == a[0] and a[0] <= b[0] and b[0] == fsum(b)
    else:
        m = m1 - 1
        l0 = fsum(a); l1 = fsum(a[:m]) + a[m]; l2 = fsum(b[:m]) + a[m]; l3 = fsum(b[:m]) + b[m]; l4 = fsum(b)
        assert l0 == l1 and l1 <= l2 and l2 <= l3 and l3 == l4
    assert fsum(a) <= fsum(b)                                         # 主張
    n += 1
assert not (fsum([QQ(2), QQ(0)]) <= fsum([QQ(1), QQ(0)]))             # 対照: 項ごとの大小が無いと成り立たない
print(f"{n} 組の列で帰納法の各行と主張を確かめた")
print("RESULT: PASS")
