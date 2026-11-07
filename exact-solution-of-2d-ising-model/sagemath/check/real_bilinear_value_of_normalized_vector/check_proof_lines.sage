# 対象ラベル: real_bilinear_value_of_normalized_vector
# 準備の 2 行の鎖  v̂_k = v_k/‖v‖ = (1/‖v‖)v_k
# 主張の 4 行の鎖  v̂^⊤Pv̂ = ((1/‖v‖)(1/‖v‖))(v^⊤Pv) = (1/(‖v‖‖v‖))(v^⊤Pv) = (1/‖v‖^2)(v^⊤Pv) = (v^⊤Pv)/‖v‖^2
# を、n = 1, …, 5 で有理数の行列 P と零でない有理数のベクトル v について、AA（実代数的数）で厳密に確かめる。
# x^⊤Py は def_real_bilinear_value のとおり Σ_kΣ_l (x_kP_kl)y_l で組む。


def norm(w):
    """def_matrix_norm（K = ℝ）: ‖w‖ := √(Σ_k |w_k|^2)。"""
    return AA(sum(abs(c)^2 for c in w)).sqrt()


def bil(x, P, y):
    """def_real_bilinear_value: x^⊤Py := Σ_kΣ_l (x_kP_kl)y_l。"""
    n = len(x)
    return sum((AA(x[k]) * AA(P[k][l])) * AA(y[l]) for k in range(n) for l in range(n))


def check(P, v):
    n = len(v)
    assert any(c != 0 for c in v)                                      # 仮定 v ≠ 0
    N = norm(v)
    assert N > 0 and N != 0                                            # norm_of_normalized_real_vector_is_one の ‖v‖ > 0
    N2 = N * N                                                         # ‖v‖^2 := ‖v‖‖v‖
    assert N2 > 0 and N2 != 0
    vh = [AA(c) / N for c in v]                                        # v̂_k := v_k/‖v‖
    steps = 0
    for k in range(n):                                                 # 準備の 2 行
        prep = [vh[k], AA(v[k]) / N, (1 / N) * AA(v[k])]
        assert prep[0] == prep[1] and prep[1] == prep[2]
        steps += 2
    B = bil(v, P, v)
    chain = [
        bil(vh, P, vh),                                                # v̂^⊤Pv̂
        ((1 / N) * (1 / N)) * B,                                       # real_bilinear_value_of_scalar_multiple_vector（c → 1/‖v‖）
        (1 / (N * N)) * B,                                             # (1/b)(1/b) = 1/(bb)
        (1 / N2) * B,                                                  # ‖v‖^2 := ‖v‖‖v‖
        B / N2,                                                        # (1/c)a = a/c
    ]
    for t in range(4):
        assert chain[t] == chain[t + 1], (n, t + 1)
        steps += 1
    return steps

set_random_seed(20261107)
total = 0
cases = 0
for n in range(1, 6):
    v0 = [QQ(-(k + 2)) / 3 if k == 0 else QQ(k + 1) / 2 for k in range(n)]   # 負の成分を含む決め打ちの 1 本
    P0 = [[QQ(k - l) / 2 + (1 if k == l else 0) for l in range(n)] for k in range(n)]  # 対称でない決め打ちの行列
    total += check(P0, v0)
    cases += 1
    for _ in range(6):
        v = [QQ.random_element(num_bound=9, den_bound=5) for _ in range(n)]
        if all(c == 0 for c in v):
            v[0] = QQ(1)
        P = [[QQ.random_element(num_bound=7, den_bound=4) for _ in range(n)] for _ in range(n)]
        total += check(P, v)
        cases += 1
# 否定コントロール（行の書き間違い）: ‖v‖^2 ではなく ‖v‖ で割った誤った右辺は、P = I、v = (3, 4)（‖v‖ = 5）で左辺と一致しない
Pid = [[1, 0], [0, 1]]
vb = [QQ(3), QQ(4)]
vhb = [AA(c) / norm(vb) for c in vb]
assert bil(vhb, Pid, vhb) == 1                                     # 正しさの確認（否定コントロールではない）
assert bil(vhb, Pid, vhb) != bil(vb, Pid, vb) / norm(vb)
print(f"{cases} 組の (P, v)（n = 1..5。各 n に負の成分を含む決め打ちの 1 組を含む）で準備の 2 行と主張の 4 行の鎖の {total} 段が成り立った。否定コントロール 1 件")
print("RESULT: PASS")
