# 対象ラベル: nonzero_elements_of_images_of_check_Q_form_basis
# Q̌_ε := ∏_{μ=1}^{M_col} R_μ^{(ε(μ))}（R^{(1)} = ň_μ、R^{(0)} = I − ň_μ。左から掛ける）を、
# check_joint_eigenspace_decomposition の検算と同じ ň_μ の模型（Jordan–Wigner の n_μ = c_μ^T c_μ、M_col = 2, 3）で作る。
# 各 ε について q_ε := Q̌_ε x_ε（x_ε は乱数のベクトル。q_ε ≠ O になるまで取り直す）とし、
#   Step 1 の ε ≠ ε' の 4 行の鎖と ε = ε' の 8 行の鎖（Q̌^2 は def_exp (1) の A^{m+1} := A^m A、A^0 := I で組む）、
#   Step 2 の t ≠ t_0 の 3 行の鎖と d_{t_0}q_{ε'} の鎖（乱数の d で成り立つ 5 行）、
#   主張（全単射 π を乱数で取った族の階数が N = 2^{M_col}）を確かめる。帰属: K = QQ(i)（模型の成分は QQ）。
load("../../_shared/linear_algebra_families.sage")
load("../check_joint_eigenspace_decomposition/_number_operators.sage")
import random, itertools
rng = random.Random(int(61))


def mpow(A, m):
    out = identity_matrix(A.base_ring(), A.nrows())
    for _ in range(m):
        out = out * A
    return out


for (tag, M, F0, ns) in number_operator_settings():
    if M > 3:
        continue
    N = 2 ^ M
    I = identity_matrix(K, N)
    nK = [X.change_ring(K) for X in ns]
    eps_list = list(itertools.product([1, 0], repeat=M))
    Qe = {}
    for e in eps_list:
        X = I
        for mu in range(M):
            X = X * (nK[mu] if e[mu] == 1 else I - nK[mu])
        Qe[e] = X
    xs = {}; qs = {}
    for e in eps_list:
        while True:
            x = rand_mat(rng, N, 1)
            if Qe[e] * x != zero(N, 1):
                break
        xs[e] = x; qs[e] = Qe[e] * x
    O = zero(N, 1)
    for e2 in eps_list:
        for e in eps_list:
            if e != e2:
                chain = [Qe[e2] * qs[e], Qe[e2] * (Qe[e] * xs[e]), (Qe[e2] * Qe[e]) * xs[e], zero(N, N) * xs[e], O]
            else:
                Q = Qe[e]
                chain = [Q * qs[e], Q * (Q * xs[e]), (Q * Q) * xs[e], ((I * Q) * Q) * xs[e], ((mpow(Q, 0) * Q) * Q) * xs[e],
                         (mpow(Q, 1) * Q) * xs[e], mpow(Q, 2) * xs[e], Q * xs[e], qs[e]]
            for t in range(len(chain) - 1):
                ok(chain[t] == chain[t + 1], (tag, "Step1", e == e2, t))
    for _ in range(2):
        perm = rng.sample(eps_list, N)
        fam = [qs[perm[t]] for t in range(N)]
        d = rand_vec_list(rng, N)
        for t0 in range(N):
            e2 = perm[t0]
            for t in range(N):
                if t != t0:
                    chain = [Qe[e2] * (d[t] * fam[t]), d[t] * (Qe[e2] * fam[t]), d[t] * O, O]
                    for s in range(len(chain) - 1):
                        ok(chain[s] == chain[s + 1], ("t≠t0", s))
            chain = [d[t0] * qs[e2], d[t0] * (Qe[e2] * qs[e2]), Qe[e2] * (d[t0] * fam[t0]),
                     fsum([Qe[e2] * (d[t] * fam[t]) for t in range(N)]), Qe[e2] * fsum([d[t] * fam[t] for t in range(N)]),
                     Qe[e2] * lincomb(d, fam, N, 1)]
            for s in range(len(chain) - 1):
                ok(chain[s] == chain[s + 1], ("d_t0 q の鎖", s))
            ok(Qe[e2] * O == O, "最後の行")
        ok(is_independent(fam, N, 1) and len(fam) == N, "主張: 基底")
    # 対照: 同じ像から二つ取ると（ε を重複させると）線型独立でない
    e = eps_list[0]
    ok(not is_independent([qs[e], 2 * qs[e]], N, 1), "対照")
print("checked", count(), "items")
print("RESULT: PASS")
