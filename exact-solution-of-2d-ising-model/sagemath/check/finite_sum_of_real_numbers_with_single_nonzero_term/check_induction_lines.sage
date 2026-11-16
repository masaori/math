# 対象ラベル: finite_sum_of_real_numbers_with_single_nonzero_term
# 証明の帰納法の三つの鎖:
#   m = 1:          Σ_{j=1}^{1} r_j = r_1 = r_k
#   k = m+1 のとき: Σ_{j=1}^{m+1} r_j = (Σ_{j=1}^{m} r_j) + r_{m+1} = r_1 + r_{m+1} = 0 + r_{m+1} = r_{m+1} = r_k
#                   （帰納法の仮定を r_1,…,r_m と k → 1 へ当てる）
#   k ≤ m のとき:   Σ_{j=1}^{m+1} r_j = (Σ_{j=1}^{m} r_j) + r_{m+1} = r_k + r_{m+1} = r_k + 0 = r_k
# r_k を QQ 上の多項式環の不定元 r に置き、他の r_j を 0 にする。有限和は def_finite_sum_of_real_numbers の
# 帰納法どおり左から足し、Sage の sum とも比べる。帰属: QQ[r]。m = 1,…,10。
R.<r> = PolynomialRing(QQ)

def left_to_right_sum(rs):
    acc = rs[0]                                       # Σ_{j=1}^{1} r_j := r_1
    for w in rs[1:]:
        acc = acc + w                                 # Σ_{j=1}^{m+1} r_j := (Σ_{j=1}^{m} r_j) + r_{m+1}
    return acc

count = 0
# m = 1（k = 1）
assert left_to_right_sum([r]) == r
count += 1
for m in range(1, 10):                                # 帰納法の段 m → m+1（m+1 = 2,…,10）
    for k in range(1, m + 2):
        rs = [r if j == k else R(0) for j in range(1, m + 2)]
        line1 = left_to_right_sum(rs)
        line2 = left_to_right_sum(rs[:m]) + rs[m]
        assert line1 == line2 == sum(rs)
        if k == m + 1:
            # 帰納法の仮定（r_1,…,r_m と k → 1）: r_1,…,r_m はどれも 0 で、1 以外の項は 0
            assert all(rs[j - 1] == 0 for j in range(2, m + 1))
            assert left_to_right_sum(rs[:m]) == rs[0]
            line3 = rs[0] + rs[m]
            assert rs[0] == 0                         # 1 ≠ m+1 = k なので r_1 = 0
            line4 = R(0) + rs[m]
            line5 = rs[m]
            assert line2 == line3 == line4 == line5 == rs[k - 1]
        else:
            assert left_to_right_sum(rs[:m]) == rs[k - 1]   # 帰納法の仮定（r_1,…,r_m と k）
            line3 = rs[k - 1] + rs[m]
            assert rs[m] == 0                         # m+1 ≠ k なので r_{m+1} = 0
            line4 = rs[k - 1] + R(0)
            assert line2 == line3 == line4 == rs[k - 1]
        count += 1
# 対照: 0 でない項が二つあれば成り立たない
assert left_to_right_sum([r, R(1), R(0)]) != r
print(f"checked {count} (m, k) cases")
print("RESULT: PASS")
