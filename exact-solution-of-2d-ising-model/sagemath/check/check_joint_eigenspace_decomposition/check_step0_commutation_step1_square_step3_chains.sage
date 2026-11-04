# 対象ラベル: check_joint_eigenspace_decomposition
# Step 0 の異なる添字の因子の可換性の鎖、Step 1 の ε = ε' の Q̌_ε^2 の鎖、Step 3 の左右の鎖を一行ずつ厳密に確かめる。
#   Step 0: YI = Y = IY（Y ∈ {ň_ν, I − ň_ν}）、R_ν^{(e')}R_μ^{(e)} = R_μ^{(e)}R_ν^{(e')}（μ ≠ ν、4 通りの (e', e) の鎖。
#           commuting_with_difference の行と check_number_operators_commute (2) の行）
#   Step 1: Q̌^2 = Q̌^1Q̌ = (Q̌^0Q̌)Q̌ = (IQ̌)Q̌ = Q̌Q̌ = (∏R)(∏R) = ∏(RR) = ∏R = Q̌
#           （冪は def_exp (1) の A^0 := I、A^{m+1} := A^mA どおりに組む。product_of_two_finite_products_of_matrices の前提
#            R_i^{(ε_i)}R_j^{(ε_j)} = R_j^{(ε_j)}R_i^{(ε_i)}（j < i）も確かめる）
#   Step 3: ň_νR_μ^{(ε_μ)} = R_μ^{(ε_μ)}ň_ν（μ ≠ ν の 3 行、μ = ν の ε_ν = 1 の 2 行と ε_ν = 0 の 4 行）、
#           Q̌ň_ν = (∏R)ň_ν = ň_ν∏R = ň_νQ̌ = ε_νQ̌
# 有限積は def_finite_product_of_matrices どおり μ = 1 の因子から左へ掛ける。積・差・和は本文の成分の式で組む。
# ň_μ は _number_operators.sage の number_operator_settings() から取る（既定は Jordan–Wigner の模型 M = 2, 3, 4、check_with_check_psi.sage からは本文の ψ̌）。
# 否定コントロール: 可換でない 2 因子の族（巡回置換の行列 J と対角行列 diag(1,2,3,4)）では (∏R)(∏R) = ∏(RR) の行が外れる。
# 帰属: 成分は QQ か、本文の ψ̌ の数体 F（厳密計算）。
load("../../_shared/matrix_operations_by_definition.sage")
load("../../_shared/matrix_negation_and_difference_by_definition.sage")
load("_number_operators.sage")


def finite_product(mats):
    acc = mats[0]
    for A in mats[1:]:
        acc = body_product(acc, A)
    return acc


def power(A, m, Id):
    acc = Id                                           # def_exp (1) の A^0 := I
    for _ in range(m):
        acc = body_product(acc, A)                     # def_exp (1) の A^{m+1} := A^m A
    return acc


count = 0
for (tag, M, F, ns) in number_operator_settings():
    N = 2 ^ M
    Id = body_identity(F, N)
    O = matrix(F, N, N, 0)
    R1 = ns
    R0 = [body_difference(Id, n) for n in ns]
    Rf = lambda mu, e: R1[mu] if e == 1 else R0[mu]
    # Step 0（異なる添字）
    for nu in range(M):
        for Y in (ns[nu], R0[nu]):
            lines = [body_product(Y, Id), Y, body_product(Id, Y)]
            for A, B in zip(lines, lines[1:]):
                assert A == B
                count += 1
        for mu in range(M):
            if mu == nu:
                continue
            chains = [
                [body_product(R1[nu], R1[mu]), body_product(ns[nu], ns[mu]), body_product(ns[mu], ns[nu]), body_product(R1[mu], R1[nu])],
                [body_product(R1[nu], R0[mu]), body_product(ns[nu], body_difference(Id, ns[mu])),
                 body_product(body_difference(Id, ns[mu]), ns[nu]), body_product(R0[mu], R1[nu])],
                [body_product(R0[nu], R1[mu]), body_product(body_difference(Id, ns[nu]), ns[mu]),
                 body_product(ns[mu], body_difference(Id, ns[nu])), body_product(R1[mu], R0[nu])],
                [body_product(R0[nu], R0[mu]), body_product(body_difference(Id, ns[nu]), body_difference(Id, ns[mu])),
                 body_product(body_difference(Id, ns[mu]), body_difference(Id, ns[nu])), body_product(R0[mu], R0[nu])],
            ]
            for ch in chains:
                for A, B in zip(ch, ch[1:]):
                    assert A == B, ("step0", M, nu, mu)
                    count += 1
    for eps in cartesian_product([[0, 1]] * M):
        eps = tuple(eps)
        R = [Rf(mu, eps[mu]) for mu in range(M)]
        Q = finite_product(R)                                         # Q̌_ε の定義（冒頭）
        # product_of_two_finite_products_of_matrices の前提（j < i）
        for i in range(M):
            for j in range(i):
                assert body_product(R[i], R[j]) == body_product(R[j], R[i])
        # Step 1（ε = ε'）
        lines = [
            power(Q, 2, Id),
            body_product(power(Q, 1, Id), Q),
            body_product(body_product(power(Q, 0, Id), Q), Q),
            body_product(body_product(Id, Q), Q),
            body_product(Q, Q),
            body_product(finite_product(R), finite_product(R)),
            finite_product([body_product(R[mu], R[mu]) for mu in range(M)]),
            finite_product(R),
            Q,
        ]
        for A, B in zip(lines, lines[1:]):
            assert A == B, ("step1", M, eps)
            count += 1
        # Step 3（左右）
        for nu in range(M):
            for mu in range(M):
                if mu != nu:
                    ch = [body_product(ns[nu], R[mu]), body_product(R1[nu], R[mu]), body_product(R[mu], R1[nu]), body_product(R[mu], ns[nu])]
                elif eps[nu] == 1:
                    ch = [body_product(ns[nu], R1[nu]), body_product(ns[nu], ns[nu]), body_product(R1[nu], ns[nu])]
                else:
                    ch = [body_product(ns[nu], R0[nu]), body_product(R1[nu], R0[nu]), O, body_product(R0[nu], R1[nu]), body_product(R0[nu], ns[nu])]
                for A, B in zip(ch, ch[1:]):
                    assert A == B, ("step3-factor", M, eps, nu, mu)
                    count += 1
            lines = [
                body_product(Q, ns[nu]),
                body_product(finite_product(R), ns[nu]),
                body_product(ns[nu], finite_product(R)),
                body_product(ns[nu], Q),
                body_scalar(eps[nu], Q),
            ]
            for A, B in zip(lines, lines[1:]):
                assert A == B, ("step3", M, eps, nu)
                count += 1

# 否定コントロール: 異なる添字の因子が可換でない族では ∏(RR) の行が外れる（M = 2）
neg = 0
N = 4
J = matrix(QQ, N, N, lambda i, j: 1 if j == (i + 1) % N else 0)   # 巡回置換の行列
D = diagonal_matrix(QQ, [1, 2, 3, 4])
assert body_product(J, D) != body_product(D, J)
assert body_product(finite_product([J, D]), finite_product([J, D])) != finite_product([body_product(J, J), body_product(D, D)])
neg += 1

print("PASS check_joint_eigenspace_decomposition Step 0 の可換性・Step 1 の Q̌^2・Step 3 の左右の鎖: %d 段、否定コントロール %d 行" % (count, neg))
print("RESULT: PASS")
