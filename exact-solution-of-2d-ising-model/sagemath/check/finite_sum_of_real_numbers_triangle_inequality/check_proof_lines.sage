# 対象ラベル: finite_sum_of_real_numbers_triangle_inequality
# |Σ_{j=1}^{m} a_j| ≤ Σ_{j=1}^{m} |a_j| の帰納法の各行（m = 1 の 2 行、m → m+1 の 4 行）を、有理数の列で確かめる。
# 帰属: QQ。浮動小数点は使わない。和は def_finite_sum_of_real_numbers どおり左から足す。
def rabs(q):
    """def_real_absolute_value: q >= 0 なら q、q < 0 なら -q。"""
    return q if q >= 0 else -q


PTS = [QQ(-7), QQ(-5)/2, QQ(-1), QQ(-1)/3, QQ(0), QQ(1)/4, QQ(1), QQ(3)/2, QQ(6)] + [AA(2).sqrt(), -AA(3).sqrt()]

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
    if m1 == 1:
        assert rabs(fsum(a)) == rabs(a[0]) and rabs(a[0]) == fsum([rabs(x) for x in a])
    else:
        m = m1 - 1
        S = fsum(a[:m])
        l0 = rabs(fsum(a)); l1 = rabs(S + a[m]); l2 = rabs(S) + rabs(a[m])
        l3 = fsum([rabs(x) for x in a[:m]]) + rabs(a[m]); l4 = fsum([rabs(x) for x in a])
        assert l0 == l1 and l1 <= l2 and l2 <= l3 and l3 == l4
    assert rabs(fsum(a)) <= fsum([rabs(x) for x in a])                # 主張
    n += 1
print(f"{n} 個の列で帰納法の各行と主張を確かめた")
print("RESULT: PASS")
