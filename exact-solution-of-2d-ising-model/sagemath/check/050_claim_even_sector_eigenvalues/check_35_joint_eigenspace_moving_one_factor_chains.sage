# 対象ラベル: check_joint_eigenspace_decomposition
# Step 1 の ε ≠ ε' の鎖と Step 3 の ň_νQ̌_ε の鎖を一行ずつ厳密に確かめる（M = 2, 3, 4）。
#   Step 1: μ = ν の可換性 R_ν^{(ε_ν)}R_ν^{(ε'_ν)} = O = R_ν^{(ε'_ν)}R_ν^{(ε_ν)}（ε_ν ≠ ε'_ν）、
#           Q̌_εQ̌_ε' = (∏R^ε)Q̌_ε' = ((∏_{μ≠ν}R^ε)R_ν^ε)Q̌_ε' = (∏_{μ≠ν}R^ε)(R_ν^εQ̌_ε') = (∏_{μ≠ν}R^ε)(R_ν^ε∏R^{ε'})
#             = (∏_{μ≠ν}R^ε)((∏R^{ε'})R_ν^ε) = (∏_{μ≠ν}R^ε)(((∏_{μ≠ν}R^{ε'})R_ν^{ε'})R_ν^ε)
#             = (∏_{μ≠ν}R^ε)((∏_{μ≠ν}R^{ε'})(R_ν^{ε'}R_ν^ε)) = (∏_{μ≠ν}R^ε)((∏_{μ≠ν}R^{ε'})O) = (∏_{μ≠ν}R^ε)O = O
#           （ε_ν ≠ ε'_ν を満たす全ての ν で。moving_one_factor_of_finite_product_to_the_end の前提（ν < j の可換性）と、
#            matrix_commuting_with_each_factor_commutes_with_finite_product の前提（R_ν^ε と R_μ^{ε'} の可換性）も確かめる）
#   Step 3: ň_νQ̌_ε = ň_ν∏R = (∏R)ň_ν = ((∏_{μ≠ν}R)R_ν)ň_ν = (∏_{μ≠ν}R)(R_νň_ν) = (∏_{μ≠ν}R)(ň_νR_ν)
#             = (∏_{μ≠ν}R)(ε_νR_ν) = ε_ν((∏_{μ≠ν}R)R_ν) = ε_ν∏R = ε_νQ̌_ε
# 有限積は def_finite_product_of_matrices どおり μ = 1 の因子から左へ掛け、∏_{μ≠ν} は
# def_finite_product_of_matrices_omitting_one_index どおり s_{M,ν} で添字を並べて組む。積・差・スカラー倍は本文の成分の式で組む。
# ň_μ は check_24・check_30〜check_34 と同じく Jordan–Wigner のフェルミ演算子 c_μ から作る n_μ := c_μ^T c_μ。
# 否定コントロール: ν の因子を末尾へ寄せる行は、ν < j の因子と可換でない族（巡回置換の行列 J と対角行列）では外れる。
# 帰属: 成分は QQ（厳密計算）。
load("../../_shared/matrix_operations_by_definition.sage")
load("../../_shared/matrix_negation_and_difference_by_definition.sage")


def kron(factors):
    out = matrix(factors[0].base_ring(), 1, 1, [1])
    for A in factors:
        out = out.tensor_product(A)
    return out


def finite_product(mats):
    acc = mats[0]                                      # def_finite_product_of_matrices の 1 項
    for A in mats[1:]:
        acc = body_product(acc, A)                     # def_finite_product_of_matrices の帰納
    return acc


def s(r, nu, j):
    # s_{r,ν} : {1,…,r−1} → {1,…,r}（1 始まり）
    return j if j < nu else j + 1


def omitting(R, nu):
    # def_finite_product_of_matrices_omitting_one_index（R[μ-1] が R_μ、ν は 1 始まり）
    r = len(R)
    return finite_product([R[s(r, nu, j) - 1] for j in range(1, r)])


count = 0
sz = matrix(QQ, [[1, 0], [0, -1]])
lower = matrix(QQ, [[0, 1], [0, 0]])
id2 = identity_matrix(QQ, 2)
for M in range(2, 5):
    N = 2 ^ M
    c = [kron([sz] * (k - 1) + [lower] + [id2] * (M - k)) for k in range(1, M + 1)]
    ns = [c[mu].transpose() * c[mu] for mu in range(M)]
    Id = body_identity(QQ, N)
    O = matrix(QQ, N, N, 0)
    R1 = ns
    R0 = [body_difference(Id, n) for n in ns]
    epss = [tuple(e) for e in cartesian_product([[0, 1]] * M)]
    Rof = lambda eps: [R1[mu] if eps[mu] == 1 else R0[mu] for mu in range(M)]
    Q = {eps: finite_product(Rof(eps)) for eps in epss}             # Q̌_ε の定義（冒頭）
    # Step 1（ε ≠ ε'）
    for eps in epss:
        for epsp in epss:
            if eps == epsp:
                continue
            Re, Rp = Rof(eps), Rof(epsp)
            for nu in range(1, M + 1):
                if eps[nu - 1] == epsp[nu - 1]:
                    continue
                a, b = Re[nu - 1], Rp[nu - 1]
                ch = [body_product(a, b), O, body_product(b, a)]          # μ = ν の可換性
                for A, B in zip(ch, ch[1:]):
                    assert A == B, ("step1-mu=nu", M, eps, epsp, nu)
                    count += 1
                for mu in range(1, M + 1):                              # matrix_commuting_with_each_factor の前提
                    assert body_product(a, Rp[mu - 1]) == body_product(Rp[mu - 1], a)
                for j in range(nu + 1, M + 1):                          # moving_one_factor の前提（ν < j）
                    assert body_product(a, Re[j - 1]) == body_product(Re[j - 1], a)
                    assert body_product(b, Rp[j - 1]) == body_product(Rp[j - 1], b)
                Pe, Pp = omitting(Re, nu), omitting(Rp, nu)
                lines = [
                    body_product(Q[eps], Q[epsp]),
                    body_product(finite_product(Re), Q[epsp]),
                    body_product(body_product(Pe, a), Q[epsp]),
                    body_product(Pe, body_product(a, Q[epsp])),
                    body_product(Pe, body_product(a, finite_product(Rp))),
                    body_product(Pe, body_product(finite_product(Rp), a)),
                    body_product(Pe, body_product(body_product(Pp, b), a)),
                    body_product(Pe, body_product(Pp, body_product(b, a))),
                    body_product(Pe, body_product(Pp, O)),
                    body_product(Pe, O),
                    O,
                ]
                for A, B in zip(lines, lines[1:]):
                    assert A == B, ("step1", M, eps, epsp, nu)
                    count += 1
    # Step 3（ň_νQ̌_ε）
    for eps in epss:
        R = Rof(eps)
        for nu in range(1, M + 1):
            n, Rn, e = ns[nu - 1], R[nu - 1], QQ(eps[nu - 1])
            for mu in range(1, M + 1):                                  # 最初の三つの場合（前提）
                assert body_product(n, R[mu - 1]) == body_product(R[mu - 1], n)
            assert body_product(n, Rn) == body_scalar(e, Rn)            # 直前の二つの場合
            Po = omitting(R, nu)
            lines = [
                body_product(n, Q[eps]),
                body_product(n, finite_product(R)),
                body_product(finite_product(R), n),
                body_product(body_product(Po, Rn), n),
                body_product(Po, body_product(Rn, n)),
                body_product(Po, body_product(n, Rn)),
                body_product(Po, body_scalar(e, Rn)),
                body_scalar(e, body_product(Po, Rn)),
                body_scalar(e, finite_product(R)),
                body_scalar(e, Q[eps]),
            ]
            for A, B in zip(lines, lines[1:]):
                assert A == B, ("step3", M, eps, nu)
                count += 1

# 否定コントロール: ν < j の因子と可換でない族では ν の因子を末尾へ寄せる行が外れる（因子 2 個、ν = 1）
neg = 0
J = matrix(QQ, 4, 4, lambda i, j: 1 if j == (i + 1) % 4 else 0)   # 巡回置換の行列
D = diagonal_matrix(QQ, [1, 2, 3, 4])
assert body_product(J, D) != body_product(D, J)
assert finite_product([J, D]) != body_product(omitting([J, D], 1), J)
neg += 1

print("PASS check_joint_eigenspace_decomposition Step 1 の ε ≠ ε' の鎖・Step 3 の ň_νQ̌_ε の鎖: %d 段、否定コントロール %d 行" % (count, neg))
print("RESULT: PASS")
