# 対象ラベル: norm_of_normalized_real_vector_is_one
# 準備（‖v‖ > 0 と ‖x‖^2 = Σ|x_k|^2）と主張の 9 行の鎖
#   ‖v̂‖ = √(Σ|v̂_k|^2) = √(Σ|v_k/‖v‖|^2) = √(Σ(v_k/‖v‖)^2) = √(Σ(1/‖v‖^2)v_k^2)
#       = √((1/‖v‖^2)Σv_k^2) = √((1/‖v‖^2)Σ|v_k|^2) = √((1/‖v‖^2)‖v‖^2) = √1 = 1
# を、n = 1, …, 6 で零でない有理数のベクトル v について、AA（実代数的数）で厳密に確かめる。


def norm(w):
    """def_matrix_norm（K = ℝ）: ‖w‖ := √(Σ_k |w_k|^2)。"""
    return AA(sum(abs(c)^2 for c in w)).sqrt()


def check(v):
    n = len(v)
    assert any(c != 0 for c in v)                                      # 仮定 v ≠ 0
    N = norm(v)
    assert N >= 0 and N != 0 and N > 0                                 # 準備: ‖v‖ ≥ 0、‖v‖ ≠ 0、‖v‖ > 0
    S = AA(sum(abs(c)^2 for c in v))
    prep = [N^2, S.sqrt()^2, S]                                        # 準備: ‖x‖^2 = (√Σ|x_k|^2)^2 = Σ|x_k|^2（x → v）
    assert prep[0] == prep[1] and prep[1] == prep[2]
    assert N^2 > 0 and N^2 != 0                                        # 準備: ‖v‖^2 > 0、‖v‖^2 ≠ 0
    vh = [AA(c) / N for c in v]                                        # v̂_k := v_k/‖v‖
    chain = [
        norm(vh),
        AA(sum(abs(vh[k])^2 for k in range(n))).sqrt(),                # def_matrix_norm（w → v̂）
        AA(sum(abs(AA(v[k]) / N)^2 for k in range(n))).sqrt(),         # v̂ の定義を各項へ
        AA(sum((AA(v[k]) / N)^2 for k in range(n))).sqrt(),            # square_of_real_absolute_value（q → v_k/‖v‖）
        AA(sum((1 / N^2) * AA(v[k])^2 for k in range(n))).sqrt(),      # (a/b)^2 = (1/b^2)a^2
        AA((1 / N^2) * sum(AA(v[k])^2 for k in range(n))).sqrt(),      # finite_sum_of_real_scalar_multiples
        AA((1 / N^2) * sum(abs(AA(v[k]))^2 for k in range(n))).sqrt(), # square_of_real_absolute_value を右辺から左辺へ
        AA((1 / N^2) * N^2).sqrt(),                                    # ‖x‖^2 = Σ|x_k|^2 を右辺から左辺へ
        AA(1).sqrt(),                                                  # (1/b)b = 1
        AA(1),                                                         # definition_of_sqrt_r_positive（1 ≥ 0, 1^2 = 1）
    ]
    for i in range(9):
        assert chain[i] == chain[i + 1], (n, i + 1, chain[i], chain[i + 1])
    for k in range(n):                                                 # 4 行目の各項 (a/b)^2 = (1/b^2)a^2
        assert (AA(v[k]) / N)^2 == (1 / N^2) * AA(v[k])^2
    return 9 + n + 4

set_random_seed(20261107)
total = 0
cases = 0
for n in range(1, 7):
    v0 = [QQ(-(k + 2)) / 3 if k == 0 else QQ(k + 1) / 2 for k in range(n)]   # 負の成分を含む決め打ちの 1 本
    total += check(v0)
    cases += 1
    for _ in range(8):
        v = [QQ.random_element(num_bound=9, den_bound=5) for _ in range(n)]
        if all(c == 0 for c in v):
            v[0] = QQ(1)
        total += check(v)
        cases += 1
# 否定コントロール: ‖v‖ ではなく ‖v‖^2 で割ると、v = (3, 4)（‖v‖ = 5）でノルムは 1/5 になり 1 にならない
vn = [QQ(3), QQ(4)]
assert norm(vn) == 5
assert norm([AA(c) / norm(vn)^2 for c in vn]) != 1
print(f"{cases} 本の零でない v（n = 1..6。各 n に負の成分を含む決め打ちの 1 本を含む）で準備と 9 行の鎖と各項の等式の {total} 段が成り立った。否定コントロール 1 件")
print("RESULT: PASS")
