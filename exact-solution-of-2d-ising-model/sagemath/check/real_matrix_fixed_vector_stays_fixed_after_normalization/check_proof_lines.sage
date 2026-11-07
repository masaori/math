# 対象ラベル: real_matrix_fixed_vector_stays_fixed_after_normalization
# 準備の 2 行の鎖  v̂_k = v_k/‖v‖ = (1/‖v‖)v_k
# 主張の 4 行の鎖  (Pv̂)_i = (1/‖v‖)(Pv)_i = (1/‖v‖)v_i = v_i/‖v‖ = v̂_i
# を、n = 1, …, 5 で (Pv)_i = v_i を満たす有理数の行列 P と零でない有理数のベクトル v について、
# AA（実代数的数）で厳密に確かめる。(Px)_i は def_real_matrix_vector_product のとおり Σ_j P_ij x_j で組む。


def norm(w):
    """def_matrix_norm（K = ℝ）: ‖w‖ := √(Σ_k |w_k|^2)。"""
    return AA(sum(abs(c)^2 for c in w)).sqrt()


def mv(P, x, i):
    """def_real_matrix_vector_product の (Px)_i。"""
    return sum(AA(P[i][j]) * AA(x[j]) for j in range(len(x)))


def fixing_matrix(Q, v):
    """Q の 1 列を直して P v = v となる有理数の行列 P を作る（v_j ≠ 0 の列 j を使う）。"""
    n = len(v)
    j = next(k for k in range(n) if v[k] != 0)
    r = [v[i] - sum(Q[i][l] * v[l] for l in range(n)) for i in range(n)]
    return [[Q[i][l] + (r[i] / v[j] if l == j else 0) for l in range(n)] for i in range(n)]


def check(P, v):
    n = len(v)
    assert any(c != 0 for c in v)                                      # 仮定 v ≠ 0
    assert all(mv(P, v, i) == AA(v[i]) for i in range(n))              # 仮定 (Pv)_i = v_i
    N = norm(v)
    assert N > 0 and N != 0                                            # norm_of_normalized_real_vector_is_one の ‖v‖ > 0
    vh = [AA(c) / N for c in v]                                        # v̂_k := v_k/‖v‖
    steps = 0
    for k in range(n):                                                 # 準備の 2 行
        prep = [vh[k], AA(v[k]) / N, (1 / N) * AA(v[k])]
        assert prep[0] == prep[1] and prep[1] == prep[2]
        steps += 2
    for i in range(n):                                                 # 主張の 4 行
        chain = [
            mv(P, vh, i),                                              # (Pv̂)_i
            (1 / N) * mv(P, v, i),                                     # real_matrix_vector_product_commutes_with_real_scalar_multiple
            (1 / N) * AA(v[i]),                                        # 仮定 (Pv)_i = v_i
            AA(v[i]) / N,                                              # (1/b)a = a/b
            vh[i],                                                     # v̂ の定義を右辺から左辺へ
        ]
        for t in range(4):
            assert chain[t] == chain[t + 1], (n, i, t + 1)
            steps += 1
    return steps

set_random_seed(20261107)
total = 0
cases = 0
for n in range(1, 6):
    # 置換行列（ε_ℝ の型の例）: 隣り合う成分を入れ替える行列と、その入れ替えで動かない v
    perm = [[1 if (l == (i ^^ 1) if (i ^^ 1) < n else l == i) else 0 for l in range(n)] for i in range(n)]
    vp = [QQ(-(i // 2 + 2)) / 3 for i in range(n)]                     # 負の成分を含み、入れ替えで動かない
    total += check(perm, vp)
    cases += 1
    for _ in range(6):
        v = [QQ.random_element(num_bound=9, den_bound=5) for _ in range(n)]
        if all(c == 0 for c in v):
            v[0] = QQ(1)
        Q = [[QQ.random_element(num_bound=7, den_bound=4) for _ in range(n)] for _ in range(n)]
        total += check(fixing_matrix(Q, v), v)
        cases += 1
# 否定コントロール（仮定）: (Pv)_i = v_i を満たさない P（P = 2I、v = (3, 4)）では (Pv̂)_1 ≠ v̂_1
Pbad = [[2, 0], [0, 2]]
vb = [QQ(3), QQ(4)]
vhb = [AA(c) / norm(vb) for c in vb]
assert mv(Pbad, vhb, 0) != vhb[0]
# 否定コントロール（行の書き間違い）: 2 行目の 1/‖v‖ を 1/‖v‖^2 にした誤った行は、v = (3, 4)（‖v‖ = 5）で 1 行目と一致しない
Pid = [[1, 0], [0, 1]]
assert mv(Pid, vhb, 0) != (1 / norm(vb)^2) * mv(Pid, vb, 0)
print(f"{cases} 組の (P, v)（n = 1..5。各 n に置換行列の 1 組を含む）で準備の 2 行と主張の 4 行の鎖の {total} 段が成り立った。否定コントロール 2 件")
print("RESULT: PASS")
