# 対象ラベル: norm_of_vector_of_absolute_values_equals_norm
# 主張の 4 行の鎖 ‖u‖ = √(Σ|u_k|^2) = √(Σ||x_k||^2) = √(Σ|x_k|^2) = ‖x‖（u_k := |x_k|）を、
# n = 1, …, 6 で有理数のベクトル x について、AA（実代数的数）で厳密に確かめる。


def norm(w):
    """def_matrix_norm（K = ℝ）: ‖w‖ := √(Σ_k |w_k|^2)。"""
    return AA(sum(abs(c)^2 for c in w)).sqrt()


def check(x):
    n = len(x)
    u = [abs(x[k]) for k in range(n)]                                  # u_k := |x_k|
    chain = [
        norm(u),
        AA(sum(abs(u[k])^2 for k in range(n))).sqrt(),                 # def_matrix_norm（w → u）
        AA(sum(abs(abs(x[k]))^2 for k in range(n))).sqrt(),            # u_k := |x_k| を各項へ
        AA(sum(abs(x[k])^2 for k in range(n))).sqrt(),                 # square_of_real_absolute_value（q → |x_k|）を各項へ
        norm(x),                                                       # def_matrix_norm（w → x）を右辺から左辺へ
    ]
    for i in range(4):
        assert chain[i] == chain[i + 1], (n, i + 1, chain[i], chain[i + 1])
    for k in range(n):                                                 # 3 行目の各項 ||x_k||^2 = |x_k|^2
        assert abs(abs(x[k]))^2 == abs(x[k])^2
    return 4 + n

set_random_seed(20261107)
total = 0
cases = 0
for n in range(1, 7):
    x0 = [QQ(-(k + 2)) / 3 if k == 0 else QQ(k + 1) / 2 for k in range(n)]   # 負の成分を必ず含む決め打ちの 1 本
    assert any(c < 0 for c in x0)
    total += check(x0)
    cases += 1
    for _ in range(8):
        x = [QQ.random_element(num_bound=9, den_bound=5) for _ in range(n)]
        total += check(x)
        cases += 1
# 否定コントロール: 絶対値の二乗を取らずに成分を足すと等号が崩れる（x = (1, -1) で Σu_k = 2 ≠ 0 = Σx_k）
xn = [QQ(1), QQ(-1)]
assert sum(abs(c) for c in xn) != sum(xn)
print(f"{cases} 本の x（n = 1..6。各 n に負の成分を含む決め打ちの 1 本を含む）で 4 行の鎖と各項の等式の {total} 段が成り立った。否定コントロール 1 件")
print("RESULT: PASS")
