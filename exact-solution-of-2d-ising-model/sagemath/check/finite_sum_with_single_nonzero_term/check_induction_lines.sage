# 対象ラベル: finite_sum_with_single_nonzero_term
# 証明の帰納法の三つの鎖:
#   m = 1:          Σ_{j=1}^{1} z_j = z_1 = z_n
#   n = m+1 のとき: Σ_{j=1}^{m+1} z_j = (Σ_{j=1}^{m} z_j) + z_{m+1} = (Σ_{j=1}^{m} 0) + z_{m+1} = 0 + z_{m+1} = z_{m+1} = z_n
#   n ≤ m のとき:   Σ_{j=1}^{m+1} z_j = (Σ_{j=1}^{m} z_j) + z_{m+1} = z_n + z_{m+1} = z_n + 0 = z_n
# z_n を QQ 上の多項式環の不定元に置き、他の z_j を 0 にする。有限和は def_finite_sum_of_complex_numbers の
# 帰納法どおり左から足し、Sage の sum とも比べる。帰属: QQ[z]。m = 1,…,10。
R.<z> = PolynomialRing(QQ)

def left_to_right_sum(zs):
    acc = zs[0]
    for w in zs[1:]:
        acc = acc + w
    return acc

count = 0
assert left_to_right_sum([z]) == z
count += 1
for m in range(1, 10):
    for n in range(1, m + 2):
        zs = [z if j == n else R(0) for j in range(1, m + 2)]
        line1 = left_to_right_sum(zs)
        line2 = left_to_right_sum(zs[:m]) + zs[m]
        assert line1 == line2 == sum(zs)
        if n == m + 1:
            line3 = left_to_right_sum([R(0)] * m) + zs[m]
            line4 = R(0) + zs[m]
            line5 = zs[m]
            assert line2 == line3 == line4 == line5 == zs[n - 1]
        else:
            assert left_to_right_sum(zs[:m]) == zs[n - 1]       # 帰納法の仮定
            line3 = zs[n - 1] + zs[m]
            assert zs[m] == 0
            line4 = zs[n - 1] + 0
            assert line2 == line3 == line4 == zs[n - 1]
        count += 1
# 対照: 0 でない項が二つあれば成り立たない
assert left_to_right_sum([z, R(1), R(0)]) != z
print(f"checked {count} (m, n) cases")
print("RESULT: PASS")
