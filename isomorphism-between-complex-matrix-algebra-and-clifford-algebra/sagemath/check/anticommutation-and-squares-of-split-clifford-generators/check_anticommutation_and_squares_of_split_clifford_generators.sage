# 対象ラベル: claim_annihilation_and_creation_generators_anticommute, claim_creation_generators_anticommute,
#   claim_annihilation_generators_anticommute, claim_square_of_creation_generator_is_zero, claim_square_of_annihilation_generator_is_zero
# 分裂した二次空間 V=W⊕W^*、q_W((w,f))=f(w) のクリフォード代数 Cl(V,q) を SageMath の CliffordAlgebra で作り、
# 生成元 a†_i=γ(in_1(w_i))・a_i=γ(in_2(f_i)) の反交換関係と平方が 0 であることを、各主張の証明の式変形の各行の値を
# Cl(V,q) の中で計算して隣どうしを比べる形で確かめる（行列への像での確認ではない）。
# V の元は組 (x,ξ) で持つ。x は基底 w の座標、ξ は双対基底 f の座標で、f(w) にあたる値は Σ_k ξ_k x_k である。
# 偏極 B_q と q_W の値は、Cl(V,q) とは別に、この組の上の関数として定義どおりに計算する。係数は QQ の厳密計算。M=1,2,3。

counts = {'pass': 0, 'neg': 0}
def ok(b):
    assert b
    counts['pass'] += 1

def compare_rows(rows):
    for r in range(len(rows) - 1):
        ok(rows[r] == rows[r + 1])

set_random_seed(20261116)
for M in range(1, 4):
    zeroW = vector(QQ, [0] * M)                                   # 0_W の座標
    zeroWs = vector(QQ, [0] * M)                                  # 0_{W^*} の座標
    e = lambda i: vector(QQ, [1 if k == i - 1 else 0 for k in range(M)])
    in1 = lambda x: (x, zeroWs)                                   # def_embedding_into_first_component_of_direct_sum
    in2 = lambda xi: (zeroW, xi)                                  # def_embedding_into_second_component_of_direct_sum
    ev = lambda xi, x: sum(xi[k] * x[k] for k in range(M))        # f(w)：f の座標 ξ と w の座標 x の対
    zW = lambda x: QQ(0)                                          # 零写像 z_W:W→ℂ（claim_zero_map_is_linear_form）
    vadd = lambda u, v: (u[0] + v[0], u[1] + v[1])
    qW = lambda u: ev(u[1], u[0])                                 # def_split_quadratic_form
    Bq = lambda u, v: (qW(vadd(u, v)) + (-qW(u))) + (-qW(v))      # def_polarization_of_map_to_complex_numbers
    delta = lambda i, j: QQ(1) if i == j else QQ(0)               # def_kronecker_delta
    # Cl(V,q)：基底 c=(in_1(w_1),…,in_1(w_M),in_2(f_1),…,in_2(f_M)) の座標 y で q(y)=Σ_k y_k y_{M+k}
    H = matrix(QQ, 2 * M, 2 * M, lambda r, s: 1 if abs(r - s) == M else 0)
    Qform = QuadraticForm(QQ, H)
    samples = [(vector(QQ, [QQ.random_element(num_bound=7, den_bound=3) for _ in range(M)]),
                vector(QQ, [QQ.random_element(num_bound=7, den_bound=3) for _ in range(M)])) for _ in range(4)]
    for u in samples + [in1(e(i)) for i in range(1, M + 1)] + [in2(e(i)) for i in range(1, M + 1)]:
        ok(Qform(vector(QQ, list(u[0]) + list(u[1]))) == qW(u))  # SageMath の二次形式が q_W と一致する
    Cl = CliffordAlgebra(Qform)
    xg = Cl.gens()
    one = Cl.one()
    gam = lambda u: sum((u[0][k] * xg[k] for k in range(M)), Cl.zero()) + sum((u[1][k] * xg[M + k] for k in range(M)), Cl.zero())   # γ
    ad = {i: gam(in1(e(i))) for i in range(1, M + 1)}             # def_creation_generator_of_split_clifford_algebra
    an = {i: gam(in2(e(i))) for i in range(1, M + 1)}             # def_annihilation_generator_of_split_clifford_algebra
    ok(all(ad[i] == xg[i - 1] and an[i] == xg[M + i - 1] for i in range(1, M + 1)))
    for i in range(1, M + 1):
        for j in range(1, M + 1):
            # claim_annihilation_and_creation_generators_anticommute
            compare_rows([an[i] * ad[j] + ad[j] * an[i],
                          gam(in2(e(i))) * gam(in1(e(j))) + gam(in1(e(j))) * gam(in2(e(i))),
                          Bq(in2(e(i)), in1(e(j))) * one,
                          Bq((zeroW, e(i)), (e(j), zeroWs)) * one,
                          (ev(e(i), e(j)) + ev(zeroWs, zeroW)) * one,
                          (delta(i, j) + ev(zeroWs, zeroW)) * one,
                          (delta(i, j) + zW(zeroW)) * one,
                          (delta(i, j) + QQ(0)) * one,
                          delta(i, j) * one])
            # claim_creation_generators_anticommute
            compare_rows([ad[i] * ad[j] + ad[j] * ad[i],
                          gam(in1(e(i))) * gam(in1(e(j))) + gam(in1(e(j))) * gam(in1(e(i))),
                          Bq(in1(e(i)), in1(e(j))) * one,
                          Bq((e(i), zeroWs), (e(j), zeroWs)) * one,
                          (ev(zeroWs, e(j)) + ev(zeroWs, e(i))) * one,
                          (zW(e(j)) + zW(e(i))) * one,
                          (QQ(0) + QQ(0)) * one,
                          QQ(0) * one,
                          Cl.zero()])
            # claim_annihilation_generators_anticommute
            compare_rows([an[i] * an[j] + an[j] * an[i],
                          gam(in2(e(i))) * gam(in2(e(j))) + gam(in2(e(j))) * gam(in2(e(i))),
                          Bq(in2(e(i)), in2(e(j))) * one,
                          Bq((zeroW, e(i)), (zeroW, e(j))) * one,
                          (ev(e(i), zeroW) + ev(e(j), zeroW)) * one,
                          (QQ(0) + QQ(0)) * one,
                          QQ(0) * one,
                          Cl.zero()])
        # claim_square_of_creation_generator_is_zero
        compare_rows([ad[i] * ad[i],
                      gam(in1(e(i))) * gam(in1(e(i))),
                      qW(in1(e(i))) * one,
                      QQ(0) * one,
                      Cl.zero()])
        # claim_square_of_annihilation_generator_is_zero
        compare_rows([an[i] * an[i],
                      gam(in2(e(i))) * gam(in2(e(i))),
                      qW(in2(e(i))) * one,
                      QQ(0) * one,
                      Cl.zero()])
    # 否定の対照: a_i a†_i + a†_i a_i は 0 ではなく、a_i a†_j + a†_j a_i の右辺を δ_{i,j} の代わりに 0 にすると i=j で一致しない
    assert all(an[i] * ad[i] + ad[i] * an[i] != Cl.zero() for i in range(1, M + 1)); counts['neg'] += 1
    # 否定の対照: a†_i a_i は 0 でも 1 でもない（反交換子だけが単位元の倍になる）
    assert all(ad[i] * an[i] != Cl.zero() and ad[i] * an[i] != one for i in range(1, M + 1)); counts['neg'] += 1
    # 否定の対照: 対角に 1 を足した二次形式（q(y)=Σ_k y_k y_{M+k}+Σ_k y_k^2）のクリフォード代数では、a†_i の平方は 0 にならない
    Hb = H + 2 * diagonal_matrix(QQ, [1] * M + [0] * M)
    Clb = CliffordAlgebra(QuadraticForm(QQ, Hb))
    assert all(Clb.gens()[i] * Clb.gens()[i] != Clb.zero() for i in range(M)); counts['neg'] += 1
    # 否定の対照: M ≥ 2 で、番号の違う a_i と a†_j の積は反交換子をとらないと 0 にならない
    if M >= 2:
        assert an[1] * ad[2] != Cl.zero(); counts['neg'] += 1
    print("M =", M, "通過", flush=True)
print("PASS", counts)
