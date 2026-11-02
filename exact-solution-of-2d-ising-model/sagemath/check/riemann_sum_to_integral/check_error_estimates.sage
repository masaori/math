# 対象ラベル: riemann_sum_to_integral
# Step 3（各区間での誤差）・Step 4（総和）・Step 5（主張の評価）の鎖を一行ずつ確かめる。
# 三つの試験関数、δ ∈ {0, 1/4, 1/2, 3/4, 1}、M = 1,…,12 で、すべて厳密に。
#   ∫_{I_μ} g・∫_{I_μ} c dt・∫_{I_μ}(g - c) dt は原始関数 G、c t、G - c t の差で厳密に作る。これらの間の等号
#   （Step 3 の第 1・2 行、Step 4 の第 1〜3 行、Step 5 の等号）は、同じ原始関数から作るので AA[p] の環の恒等式として
#   成り立ち、確かめているのは行の書き写し（係数・符号・和の範囲）の正しさである。積分の値そのものは、
#   各区間で Sage の記号積分（∫ g と ∫ (g - g(t_μ))）をボールで評価した独立な値と照合する。
#   中身のある不等号の行は、|∫(g - c)| ≤ |I_μ| sup、sup ≤ ω(2π/M)、三角不等式の行である。
#   sup_{t ∈ I_μ}|g(t) - g(t_μ)| は端点と単調性の変わる点で取る（check_test_functions で標本と比べた）。
load("riemann_sum_by_definition.sage")

deltas = [QQ(0), QQ(1) / 4, QQ(1) / 2, QQ(3) / 4, QQ(1)]
for g in TEST_FUNCTIONS:
    whole = integral(g, 0, 2)
    for dl in deltas:
        for M in range(1, 13):
            h = pt(QQ(2) / M)
            w = g.omega(QQ(2) / M)
            per = []
            for mu in range(1, M + 1):
                qa, qb, qm = QQ(2 * (mu - 1)) / M, QQ(2 * mu) / M, 2 * (mu - dl) / M
                c = g.value(qm)
                I = integral(g, qa, qb)
                const_int = c * pt(qb) - c * pt(qa)                       # ∫_{I_μ} g(t_μ) dt
                assert pt(qb) - pt(qa) == h and const_int == h * c        # |I_μ| = 2π/M、定数の積分 = (2π/M) g(t_μ)
                dev_int = (g.prim(qb) - c * pt(qb)) - (g.prim(qa) - c * pt(qa))   # ∫_{I_μ}(g - g(t_μ)) dt
                if M <= 6:   # 記号積分は遅いので M ≤ 6 で照合する
                    assert matches_ball(I, sym_integral_ball(g, qa, qb))
                    assert matches_ball(dev_int, sym_integral_ball(g, qa, qb, sym_value(g, qm)))
                sup_dev = sup_dev_on(g, qa, qb, qm)
                assert qa <= qm <= qb and rabs(g.value(qm) - c) == 0 and leq(0, sup_dev)     # t = t_μ の元が 0 なので集合は空でない
                assert leq(sup_dev, w)                                    # 上限 ≤ ω(2π/M)
                s3 = [rabs(I - h * c), rabs(I - const_int), rabs(dev_int), h * sup_dev, h * w]
                assert s3[0] == s3[1] == s3[2] and leq(s3[2], s3[3]) and leq(s3[3], s3[4]), (g.name, dl, M, mu)
                per.append((I, c))
            S = sum(c for _, c in per)
            s4 = [rabs(whole - h * S),
                  rabs(sum(I for I, _ in per) - h * S),
                  rabs(sum(I for I, _ in per) - sum(h * c for _, c in per)),
                  rabs(sum(I - h * c for I, c in per)),
                  sum(rabs(I - h * c) for I, c in per),
                  sum(h * w for _ in per),
                  M * h * w,
                  pt(2) * w]
            assert s4[0] == s4[1] == s4[2] == s4[3] and leq(s4[3], s4[4]) and leq(s4[4], s4[5]) \
                and s4[5] == s4[6] == s4[7], (g.name, dl, M)
            inv2pi = RF(1) / pt(2)
            s5 = [rabs(RF(1) / M * S - inv2pi * whole),
                  rabs(inv2pi * h * S - inv2pi * whole),
                  rabs(inv2pi * (h * S - whole)),
                  inv2pi * rabs(h * S - whole),
                  inv2pi * rabs(whole - h * S),
                  inv2pi * pt(2) * w,
                  RF(w)]
            assert s5[0] == s5[1] == s5[2] == s5[3] == s5[4] and leq(s5[4], s5[5]) and s5[5] == s5[6], (g.name, dl, M)
    print(f"{g.name}: Step 3・4・5 の鎖を δ 5 通り × M = 1,…,12 で確かめた")
print("RESULT: PASS")
