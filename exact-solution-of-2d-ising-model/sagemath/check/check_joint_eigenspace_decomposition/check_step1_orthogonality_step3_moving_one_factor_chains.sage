# 対象ラベル: check_joint_eigenspace_decomposition
# Step 1 の ε ≠ ε' の鎖と Step 3 の ň_νQ̌_ε の鎖を一行ずつ厳密に確かめる。
#   Step 1: μ = ν の可換性 R_ν^{(ε(ν))}R_ν^{(ε'(ν))} = O = R_ν^{(ε'(ν))}R_ν^{(ε(ν))}（ε(ν) ≠ ε'(ν)）、
#           Q̌_εQ̌_ε' = (∏R^ε)Q̌_ε' = ((∏_{μ≠ν}R^ε)R_ν^ε)Q̌_ε' = (∏_{μ≠ν}R^ε)(R_ν^εQ̌_ε') = (∏_{μ≠ν}R^ε)(R_ν^ε∏R^{ε'})
#             = (∏_{μ≠ν}R^ε)((∏R^{ε'})R_ν^ε) = (∏_{μ≠ν}R^ε)(((∏_{μ≠ν}R^{ε'})R_ν^{ε'})R_ν^ε)
#             = (∏_{μ≠ν}R^ε)((∏_{μ≠ν}R^{ε'})(R_ν^{ε'}R_ν^ε)) = (∏_{μ≠ν}R^ε)((∏_{μ≠ν}R^{ε'})O) = (∏_{μ≠ν}R^ε)O = O
#           （ε(ν) ≠ ε'(ν) を満たす全ての ν で。moving_one_factor_of_finite_product_to_the_end の前提（ν < j の可換性）と、
#            matrix_commuting_with_each_factor_commutes_with_finite_product の前提（R_ν^ε と R_μ^{ε'} の可換性）も確かめる）
#   Step 3: ε(ν) によらない 5 行 ň_νQ̌_ε = ň_ν∏R = (∏R)ň_ν = ((∏_{μ≠ν}R)R_ν)ň_ν = (∏_{μ≠ν}R)(R_νň_ν) = (∏_{μ≠ν}R)(ň_νR_ν)、
#           ε(ν) = 1 の 6 行 ň_νQ̌_ε = (∏_{μ≠ν}R)(ň_νR_ν^{(ε(ν))}) = (∏_{μ≠ν}R)(ň_νR_ν^{(1)}) = (∏_{μ≠ν}R)R_ν^{(1)}
#             = (∏_{μ≠ν}R)R_ν^{(ε(ν))} = ∏R = Q̌_ε、
#           ε(ν) = 0 の 4 行 ň_νQ̌_ε = (∏_{μ≠ν}R)(ň_νR_ν^{(ε(ν))}) = (∏_{μ≠ν}R)(ň_νR_ν^{(0)}) = (∏_{μ≠ν}R)O = O
# 有限積は def_finite_product_of_matrices どおり μ = 1 の因子から左へ掛け、∏_{μ≠ν} は
# def_finite_product_of_matrices_omitting_one_index どおり s_{M,ν} で添字を並べて組む。積・差・スカラー倍は本文の成分の式で組む。
# ň_μ は _number_operators.sage の number_operator_settings() から取る（既定は Jordan–Wigner の模型 M = 2, 3, 4、check_with_check_psi.sage からは本文の ψ̌）。
# 否定コントロール: ν の因子を末尾へ寄せる行は、ν < j の因子と可換でない族（巡回置換の行列 J と対角行列）では外れる。
# 帰属: 成分は QQ か、本文の ψ̌ の数体 F（厳密計算）。
load("../../_shared/matrix_operations_by_definition.sage")
load("../../_shared/matrix_negation_and_difference_by_definition.sage")
load("_number_operators.sage")


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
for (tag, M, F, ns) in number_operator_settings():
    N = 2 ^ M
    Id = body_identity(F, N)
    O = matrix(F, N, N, 0)
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
            n, Rn = ns[nu - 1], R[nu - 1]
            for mu in range(1, M + 1):                                  # 最初の三つの場合（前提）
                assert body_product(n, R[mu - 1]) == body_product(R[mu - 1], n)
            Po = omitting(R, nu)
            common = [
                body_product(n, Q[eps]),
                body_product(n, finite_product(R)),
                body_product(finite_product(R), n),
                body_product(body_product(Po, Rn), n),
                body_product(Po, body_product(Rn, n)),
                body_product(Po, body_product(n, Rn)),
            ]
            if eps[nu - 1] == 1:
                case = [
                    common[-1],                                         # 直前の鎖
                    body_product(Po, body_product(n, R1[nu - 1])),      # 場合の仮定 ε(ν) = 1
                    body_product(Po, R1[nu - 1]),                       # 上の ň_νR_ν^{(1)} = R_ν^{(1)} の鎖
                    body_product(Po, Rn),                               # 場合の仮定を右辺から左辺へ
                    finite_product(R),                                  # moving_one_factor_… を右辺から左辺へ
                    Q[eps],                                             # Q̌_ε の定義（冒頭）
                ]
            else:
                case = [
                    common[-1],                                         # 直前の鎖
                    body_product(Po, body_product(n, R0[nu - 1])),      # 場合の仮定 ε(ν) = 0
                    body_product(Po, O),                                # 上の ň_νR_ν^{(0)} = 0 の鎖
                    O,                                                  # zero_matrix_is_right_zero_of_mat_mult
                ]
            for lines in (common, case):
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

print("PASS check_joint_eigenspace_decomposition Step 1 の ε ≠ ε' の鎖・Step 3 の ň_νQ̌_ε の鎖（ε(ν) によらない部分と二つの場合）: %d 段、否定コントロール %d 行" % (count, neg))
print("RESULT: PASS")
