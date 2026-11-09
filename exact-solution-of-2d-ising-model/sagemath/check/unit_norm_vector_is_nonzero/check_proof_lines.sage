# 対象ラベル: unit_norm_vector_is_nonzero
# x = 0 と仮定して ‖x‖ = 0 に着く 6 行の鎖を、d = 1..16 で本文の字面どおりに組んで厳密に（AA）確かめ、
# ℝ で 0 ≠ 1 なので ‖x‖ = 1 と矛盾することを見る。
# 帰属: 成分は AA（実代数的数）の元、平方根は y ≥ 0 かつ y^2 = x を満たす y を AA で取る。浮動小数点は使わない。


def absR(q):
    """def_real_absolute_value: q ≥ 0 なら q、q < 0 なら −q。"""
    return q if q >= 0 else -q


def sqrt_nonneg(x):
    """definition_of_sqrt_r_positive: y ≥ 0 かつ y^2 = x を満たす y（AA で厳密）。"""
    y = AA(x).sqrt()
    assert y >= 0 and y**2 == x
    return y


def norm(x):
    """def_matrix_norm（K = ℝ）: √(Σ_j |x_j|^2)。和は左から順に足す（def_finite_sum_of_real_numbers）。"""
    acc = AA(0)
    for xj in x:
        acc = acc + absR(xj)**2
    return sqrt_nonneg(acc)


count = 0
neg = 0
for d in range(1, 17):
    S = range(d)
    x = [AA(0)] * d                                                  # x = 0（すべての j で x_j = 0）
    l1 = norm(x)                                                     # def_matrix_norm
    l2 = sqrt_nonneg(sum((absR(AA(0))**2 for j in S), AA(0)))        # x_j = 0 を各項へ
    l3 = sqrt_nonneg(sum((AA(0)**2 for j in S), AA(0)))              # |0| = 0 を各項へ
    l4 = sqrt_nonneg(sum((AA(0) for j in S), AA(0)))                 # 0^2 = 0 を各項へ
    acc = AA(0)
    for j in S:                                                      # 和を左から順に足し、0 + 0 = 0
        acc = acc + AA(0)
        assert acc == 0
    l5 = sqrt_nonneg(acc)
    l6 = AA(0)                                                       # sqrt_of_real_zero_is_zero
    assert l1 == l2 == l3 == l4 == l5 == l6
    assert l6 != 1                                                   # ℝ で 0 ≠ 1 なので ‖x‖ = 1 と矛盾
    count += 6
    # 否定の対照: ノルム 1 の具体的なベクトル（標準基底 e_k と、成分 ±1/√d）は零でなく、ノルムは 0 でない
    for k in S:
        e = [AA(1) if i == k else AA(0) for i in S]
        assert norm(e) == 1 and any(v != 0 for v in e)
        neg += 1
    u = [AA(1) / sqrt_nonneg(d) * (1 if i % 2 == 0 else -1) for i in S]
    assert norm(u) == 1 and any(v != 0 for v in u)
    neg += 1
print(f"等号 {count} 個（d = 1..16 の 6 行の鎖）、否定の対照 {neg} 件")
print("RESULT: PASS")
