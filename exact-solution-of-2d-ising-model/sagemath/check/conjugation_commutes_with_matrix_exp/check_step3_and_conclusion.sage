# 対象ラベル: conjugation_commutes_with_matrix_exp（Step 3 の極限と結論の行、主張）
# (a) 厳密: X := (log y)·N（N は整数の固有値をもつ対角化可能な整数行列、y ∈ {2, 3}）と選ぶと、
#     exp(X) = Σ_λ y^λ P_λ（P_λ は N の固有値 λ の射影）が QQ で作れる。T_B(X) = (log y)·T_B(N) で、
#     T_B(N) の射影から exp(T_B(X)) を別に作り、主張 T_B(exp(X)) = exp(T_B(X)) を KG で厳密に比べる。
#     冪零の X では exp(X) は有限和なので、def_exp の部分和そのものとして両辺を KG で作って比べる。
#     ℝ への脱出は X に log y を入れる選び方の一点だけである。
# (b) ボール: X を KG の具体の行列に取り、exp(X) を body_exp_ball（def_exp の部分和に尾の上界を半径として足した
#     256 ビットのボール。ℝ への脱出: exp の極限）で作る。Step 3 の中身
#     ‖T_B(P_N(X)) − T_B(exp(X))‖ ≤ ‖B‖‖P_N(X) − exp(X)‖‖B^{-1}‖（matrix_norm_submultiplicativity を二回）を N = 5, 10, 20, 40 で、
#     結論 T_B(exp(X)) = exp(T_B(X)) をボールの重なりで確かめる。許容誤差は置かない。
load("_prelude.sage")

n_eq = 0
n_ball = 0
n_neg = 0

# (a) 厳密
Ns = [matrix(QQ, [[1, 1], [0, 2]]),
      matrix(QQ, [[2, 0, 1], [0, 1, 0], [0, 0, -1]]),
      matrix(QQ, [[1, 2, 0, 0], [0, 3, 0, 1], [0, 0, -1, 0], [0, 0, 0, 0]])]
for (B, Binv) in invertible_samples():
    n = B.nrows()
    for N in Ns:
        if N.nrows() != n:
            continue
        assert sum(m for _, m in N.charpoly().roots(ZZ)) == n   # 固有値が全て整数
        TN = T_body(B, N.change_ring(KG), Binv)
        for y in [QQ(2), QQ(3)]:
            E = exp_by_spectral_projectors(N, lambda lam: y**lam, QQ).change_ring(KG)
            lhs = T_body(B, E, Binv)
            # exp(T_B(X)): T_B(N) の成分は KG。射影を KG で作る（固有値は N と同じ整数）
            lams = sorted(set(ZZ(r) for r, _ in N.charpoly().roots(ZZ)))
            Id = identity_matrix(KG, n)
            rhs = matrix(KG, n, n, 0)
            tot = matrix(KG, n, n, 0)
            for lam in lams:
                Pl = Id
                for lp in lams:
                    if lp != lam:
                        Pl = Pl * (TN - lp * Id) / (lam - lp)
                assert TN * Pl == lam * Pl
                tot = tot + Pl
                rhs = rhs + KG(y**lam) * Pl
            assert tot == Id
            assert lhs == rhs, (n, N, y)
            n_eq += 1
            # 否定: B^{-1} を B に取り違えると一致しない
            assert T_body(B, E, B) != rhs; n_neg += 1
    # 冪零の X（上三角で対角が 0）: exp は有限和。両辺を def_exp の部分和として作る
    Xn = matrix(KG, n, n, lambda r, s: (r + 2 * s + 1) * (1 if s > r else 0) + (i_K if s == r + 1 else 0))
    assert power_body(Xn, n) == 0
    TXn = T_body(B, Xn, Binv)
    assert power_body(TXn, n) == 0
    lhs = T_body(B, partial_sum_body(Xn, n), Binv)
    rhs = partial_sum_body(TXn, n)
    assert lhs == rhs and partial_sum_body(Xn, n + 3) == partial_sum_body(Xn, n)
    n_eq += 1
    assert partial_sum_body(TXn, n) != partial_sum_body(Xn, n); n_neg += 1   # 共役しない exp とは違う

# (b) ボール
def frob_upper(A):
    return RB(sum((z.abs())**2 for z in A.list())).sqrt()


for (B, Binv) in invertible_samples():
    n = B.nrows()
    X = matrix(KG, n, n, lambda r, s: QQ(r - s + 1) / 3 + (i_K / 4 if r == s else 0))
    Eb = body_exp_ball(X)
    Bc, Bic = to_CB(B), to_CB(Binv)
    lhs_lim = (Bc * Eb) * Bic                       # T_B(exp(X))
    nB, nBi = frob_upper(Bc), frob_upper(Bic)
    prev = None
    for Nn in [5, 10, 20, 40]:
        PN = to_CB(partial_sum_body(X, Nn))
        diff = frob_upper(((Bc * PN) * Bic) - lhs_lim)
        bound = nB * frob_upper(PN - Eb) * nBi
        assert diff.upper() <= (bound + RB(2)**(-150)).upper(), (n, Nn)   # 半径の分だけの余裕
        n_ball += 1
        if prev is not None:
            assert bound.upper() < prev
        prev = bound.upper()
    assert prev < RR(2)**(-20)
    # 結論: T_B(exp(X)) と exp(T_B(X))
    TX = T_body(B, X, Binv)
    assert balls_overlap(lhs_lim, body_exp_ball(TX)); n_ball += 1
    # 否定: exp(X) そのものとは重ならない
    assert balls_disjoint_somewhere(lhs_lim, Eb); n_neg += 1

print(f"厳密な等号 {n_eq} 個、ボールで確かめた行 {n_ball} 個、否定コントロール {n_neg} 件")
print("RESULT: PASS")
