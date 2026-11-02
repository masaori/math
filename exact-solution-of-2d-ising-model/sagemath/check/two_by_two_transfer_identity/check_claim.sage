# 対象ラベル: two_by_two_transfer_identity
# 主張そのもの: A = (2s_2)^{1/2} exp(K_2^* σ^x)。証明の経路（閉じた形）を通らずに確かめる。
# 併せて、証明の「τ = K_2^* として」の鎖の最後の行列 [[q cosh K_2^*, q sinh K_2^*], …] と「結論」の鎖の中間の行列が、
#   両辺の行列のボールと重なることを確かめる。
#   左辺の A は成分 exp(K_2 ς_i ς_j) を本文の exp のボールで、右辺の exp(K_2^*σ^x) は本文 def_exp (1) の
#   行列の部分和に尾の評価を足した行列のボールで作り、(2s_2)^{1/2} は本文の √ のボールで掛ける。
#   否定コントロール: K_2^* の代わりに K_2 を入れた右辺、前因子を (2s_2) にした右辺は一致しない。
# 帰属: K_2^* = -(1/2) log(tanh K_2) と exp の値は QQ に収まらないので、全体を RealBallField(512) へ脱出して
#   重なりで判定する（理由: 実対数と指数評価）。許容誤差は置かず、重なりと半径の小ささで判定する。
load("_prelude.sage")

def sides(eK, emK, e2K, em2K):
    cK = cosh_by_definition(eK, emK); sK = sinh_by_definition(eK, emK)
    t = tanh_by_definition(sK, cK)
    Ks = dual_coupling_by_definition(real_log_enclosure_of_ball(t))     # log の値は有理数の端点の区間（幅 2^-130 程度）
    two_s2 = 2 * sinh_by_definition(e2K, em2K)
    A = matrix(RBF512, [[eK, emK], [emK, eK]])                       # A_ij = exp(K_2 ς_i ς_j)
    Xs = exp_matrix_ball(matrix(RBF512, [[0, Ks], [Ks, 0]]))          # exp(K_2^* σ^x)
    rhs = sqrt_ball(two_s2) * Xs
    # 証明の中間の行列 [[q cosh K_2^*, q sinh K_2^*], [q sinh K_2^*, q cosh K_2^*]]（cosh・sinh は K_2^* のボールから本文の定義で）
    eKs = exp_ball_of_ball(Ks); emKs = exp_ball_of_ball(-Ks)
    qb = sqrt_ball(two_s2)
    mid = matrix(RBF512, [[qb * cosh_by_definition(eKs, emKs), qb * sinh_by_definition(eKs, emKs)],
                          [qb * sinh_by_definition(eKs, emKs), qb * cosh_by_definition(eKs, emKs)]])
    for i in range(2):
        for j in range(2):
            assert rhs[i, j].overlaps(mid[i, j]) and A[i, j].overlaps(mid[i, j]), (i, j)
    return A, rhs, two_s2, Xs

def check(A, rhs, two_s2, eK):
    for i in range(2):
        for j in range(2):
            assert A[i, j].overlaps(rhs[i, j]), (i, j)
            assert rhs[i, j].rad() < 2^-100                       # 実対数の区間の幅が支配的
    # 否定コントロール（K_2 のボールは Arb の log で作る。否定の判定にしか使わない）
    Kb = RBF512(eK).log()
    bad1 = sqrt_ball(two_s2) * exp_matrix_ball(matrix(RBF512, [[0, Kb], [Kb, 0]]))
    bad2 = two_s2 * (rhs / sqrt_ball(two_s2))
    assert not all(A[i, j].overlaps(bad1[i, j]) for i in range(2) for j in range(2))
    assert not all(A[i, j].overlaps(bad2[i, j]) for i in range(2) for j in range(2))

for x in X_LOG_POINTS:                                                # K_2 = log x、exp(K_2) = x（QQ）
    eK = RBF512(x); emK = RBF512(1 / x)
    A, rhs, two_s2, Xs = sides(eK, emK, RBF512(x^2), RBF512(1 / x^2))
    check(A, rhs, two_s2, eK)
for K0 in K2_RATIONAL_POINTS:
    eK = exp_ball(K0); emK = exp_ball(-K0)
    A, rhs, two_s2, Xs = sides(eK, emK, exp_ball(2 * K0), exp_ball(-2 * K0))
    check(A, rhs, two_s2, eK)
print(f"{len(X_LOG_POINTS)} 点の K_2 = log x と {len(K2_RATIONAL_POINTS)} 点の K_2 ∈ QQ で、A と (2s_2)^(1/2) exp(K_2^*σ^x) のボールが重なり、否定コントロール 2 種は重ならない")
print("RESULT: PASS")
