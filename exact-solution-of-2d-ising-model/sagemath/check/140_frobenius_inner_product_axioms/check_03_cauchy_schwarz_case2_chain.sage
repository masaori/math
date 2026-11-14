# frobenius_inner_product_axioms の Step 5 場合 2（‖B‖ > 0）の鎖を 1 行ずつ、ガウス有理数体 QQ[i] の厳密計算で確かめる。
# 前置き（β := ‖B‖²、β_C ∈ C^×、(β^{-1})_C = (β_C)^{-1}、t := ū/β_C = ū(β_C)^{-1}、q := |u|²/‖B‖²）、
# 準備 t̄ = u(β_C)^{-1}（6 項）、準備 (ūu)(β_C)^{-1} = q_C（7 項）、
# 三つの積の項 t⟨A,B⟩（7 項）・t̄⟨B,A⟩（9 項）・t̄t⟨B,B⟩（14 項）、合わせる鎖（13 項）。
# QQ[i] の元 x + y i は definition_of_cc の (x, y)。β・|u|²・q は QQ に入る（成分がガウス有理数なので）。浮動小数点は使わない。
K.<i> = QuadraticField(-1)
def conj(z):                           # def_complex_conjugate: (x, y) ↦ (x, -y)
    x, y = z.vector()
    return K(x) - K(y)*i
def incl(r):                           # inclusion_rr_to_cc: r ↦ (r, 0)
    return K(QQ(r))
def absq(z):                           # |z|^2 = x^2 + y^2（def_abs_arg の二乗。ℝ の値）
    x, y = z.vector()
    return QQ(x)**2 + QQ(y)**2
def inner(A, B):                       # def_frobenius_inner_product: ⟨A,B⟩ = tr(A^* B)
    return (A.conjugate_transpose()*B).trace()
def normsq(A):                         # def_matrix_norm の二乗: Σ|a_ij|^2
    return sum(absq(A[r, c]) for r in range(A.nrows()) for c in range(A.ncols()))
def cinv(w):                           # multiplicative_group_of_cc の逆元: w w' = 1_C を解いて作る（値を先に置かない）
    a, b = w.vector()
    x, y = var('x y')
    pr = (SR(a)*x - SR(b)*y, SR(a)*y + SR(b)*x)        # definition_of_cc の積 (a,b)(x,y)
    sol = solve([pr[0] == 1, pr[1] == 0], x, y, solution_dict=True)
    assert len(sol) == 1
    return K(QQ(sol[0][x])) + K(QQ(sol[0][y]))*i

set_random_seed(1403)
def rnd():
    return K(QQ.random_element(num_bound=9, den_bound=5)) + K(QQ.random_element(num_bound=9, den_bound=5))*i
count = 0
neg = 0
for n in [1, 2, 3]:
    for trial in range(4):
        A = matrix(K, n, n, lambda r, c: rnd())
        B = matrix(K, n, n, lambda r, c: rnd())
        if B == 0:
            continue
        u = inner(A, B)
        beta = normsq(B)
        assert beta > 0
        bC = incl(beta)
        assert bC != 0                                  # β_C ∈ C^×
        binv = cinv(bC)
        assert bC*binv == 1
        # real_inclusion_preserves_inverse（r → β）
        assert incl(beta**-1) == binv
        count += 1
        # def_complex_quotient: t := ū/β_C = ū (β_C)^{-1}
        t = conj(u)*binv
        assert t == conj(u)/bC
        count += 1
        q = absq(u) / normsq(B)
        # 準備 t̄ = u (β_C)^{-1}
        ch = [conj(t), conj(conj(u)*binv), conj(conj(u))*conj(binv), u*conj(binv), u*cinv(conj(bC)), u*binv]
        for k in range(1, len(ch)):
            assert ch[k] == ch[k-1], ("tbar", n, k); count += 1
        tb = conj(t)
        # 準備 (ū u)(β_C)^{-1} = q_C
        ch = [(conj(u)*u)*binv, incl(absq(u))*binv, incl(absq(u))*incl(beta**-1),
              incl(absq(u)*beta**-1), incl(absq(u)*normsq(B)**-1), incl(absq(u)/normsq(B)), incl(q)]
        for k in range(1, len(ch)):
            assert ch[k] == ch[k-1], ("prep_q", n, k); count += 1
        # t⟨A,B⟩
        ch = [t*inner(A, B), t*u, (conj(u)*binv)*u, conj(u)*(binv*u), conj(u)*(u*binv), (conj(u)*u)*binv, incl(q)]
        for k in range(1, len(ch)):
            assert ch[k] == ch[k-1], ("t<A,B>", n, k); count += 1
        # t̄⟨B,A⟩
        ch = [tb*inner(B, A), tb*conj(inner(A, B)), tb*conj(u), (u*binv)*conj(u), u*(binv*conj(u)),
              u*(conj(u)*binv), (u*conj(u))*binv, (conj(u)*u)*binv, incl(q)]
        for k in range(1, len(ch)):
            assert ch[k] == ch[k-1], ("tbar<B,A>", n, k); count += 1
        # t̄ t ⟨B,B⟩
        assert inner(B, B) == incl(normsq(B))           # (3)（A → B）
        ch = [(tb*t)*inner(B, B), (tb*t)*incl(normsq(B)), (tb*t)*bC, (tb*(conj(u)*binv))*bC, ((u*binv)*(conj(u)*binv))*bC,
              (u*binv)*((conj(u)*binv)*bC), (u*binv)*(conj(u)*(binv*bC)), (u*binv)*(conj(u)*1),
              (u*binv)*conj(u), u*(binv*conj(u)), u*(conj(u)*binv), (u*conj(u))*binv, (conj(u)*u)*binv, incl(q)]
        for k in range(1, len(ch)):
            assert ch[k] == ch[k-1], ("tbar t<B,B>", n, k); count += 1
        # 展開式と合わせる鎖
        AtB = A - t*B
        lhs = incl(normsq(AtB))
        exp_ = inner(A, A) - t*inner(A, B) - tb*inner(B, A) + tb*t*inner(B, B)
        assert lhs == inner(AtB, AtB) == exp_
        count += 2
        a, qC = incl(normsq(A)), incl(q)
        tAB, tbBA, tbtBB = t*inner(A, B), tb*inner(B, A), tb*t*inner(B, B)
        ch = [lhs,
              inner(A, A) - tAB - tbBA + tbtBB,                 # 展開式
              a - tAB - tbBA + tbtBB,                            # (3)
              a - qC - tbBA + tbtBB,
              a - qC - qC + tbtBB,
              a - qC - qC + qC,
              ((a + (-qC)) + (-qC)) + qC,                        # def_complex_difference
              (a + (-qC)) + ((-qC) + qC),                        # 加法の結合律
              (a + (-qC)) + K(0),                                # negation_plus_self_is_zero_in_cc (x → q_C)
              a + (-qC),                                         # 加法の単位元
              a - qC,                                            # def_complex_difference
              incl(normsq(A) - q),                               # real_inclusion_preserves_difference
              incl(normsq(A) - absq(u)/normsq(B))]               # q の定義
        for k in range(1, len(ch)):
            assert ch[k] == ch[k-1], ("combine", n, k); count += 1
        # 否定コントロール: t を ū でなく u から作ると（u が実数でない限り）t⟨A,B⟩ は q_C にならない
        if u != conj(u):
            assert (u*binv)*inner(A, B) != incl(q)
            neg += 1
assert neg > 0
print("判定した等号の数:", count, "否定コントロールの数:", neg)
print("ALL PASS")
