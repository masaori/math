# 対象ラベル: hermitian_and_transpose_invariant_matrix_is_real_symmetric
# 人手の証明の 3 つの鎖（7 行の鎖、b = 0 の 4 行、A_kl = a_C の 3 行）を、n = 1..3 の一般の A ∈ Mat(n, ℂ)（成分 A_{kl} = (a_{kl}, b_{kl}) は QQ 上の不定元の対）について、
# 仮定 A^* = A と A^⊤ = A の成分の等式が生成するイデアル J を法として、全ての k, l で 1 行ずつ確かめる。
# 恒等的に成り立つ行（定義を書き換えるだけの行）は差が 0、仮定を使う行は差が J に入ることを見る（グレブナー基底による厳密な判定）。
# 複素数は本文 definition_of_cc どおり実数の対で持ち（_shared/complex_as_real_pairs.sage）、Sage の複素数は使わない。
# 共役転置は def_hermitian_positive_definite の (A^*)_{kl} := conj(A_{lk})、転置は def_matrix_transpose の (A^T)_{pq} := A_{qp}。
load("../../_shared/complex_as_real_pairs.sage")


def setup(n, use_star=True, use_transpose=True):
    names = [f"{c}_{k}_{l}" for k in range(n) for l in range(n) for c in "ab"]
    P = PolynomialRing(QQ, names, order="degrevlex")
    A = [[(P(f"a_{k}_{l}"), P(f"b_{k}_{l}")) for l in range(n)] for k in range(n)]
    Astar = [[cc_conj(A[l][k]) for l in range(n)] for k in range(n)]     # def_hermitian_positive_definite の共役転置
    At = [[A[l][k] for l in range(n)] for k in range(n)]                 # def_matrix_transpose
    gens = []
    for k in range(n):
        for l in range(n):
            if use_star:
                gens += [Astar[k][l][0] - A[k][l][0], Astar[k][l][1] - A[k][l][1]]   # 仮定 A^* = A
            if use_transpose:
                gens += [At[k][l][0] - A[k][l][0], At[k][l][1] - A[k][l][1]]         # 仮定 A^⊤ = A
    J = P.ideal(gens) if gens else P.ideal([P(0)])
    return P, A, Astar, At, J


def pair_in(z, w, J):
    return J.reduce(z[0] - w[0]) == 0 and J.reduce(z[1] - w[1]) == 0


count = 0
for n in range(1, 4):
    P, A, Astar, At, J = setup(n)
    for k in range(n):
        for l in range(n):
            a, b = A[k][l]
            # 7 行の鎖: (a, -b) = conj((a, b)) = conj(A_kl) = (A^*)_lk = A_lk = (A^T)_kl = A_kl = (a, b)
            chain = [
                ((a, -b), True),
                (cc_conj((a, b)), True),      # def_complex_conjugate（x → a, y → b）。恒等的
                (cc_conj(A[k][l]), True),     # a, b の取り方。恒等的
                (Astar[l][k], True),          # 共役転置の定義（k → l, l → k）。恒等的
                (A[l][k], False),             # A^* = A。J を法として
                (At[k][l], True),             # def_matrix_transpose。恒等的
                (A[k][l], False),             # A^T = A。J を法として
                ((a, b), True),               # a, b の取り方。恒等的
            ]
            for t_ in range(1, len(chain)):
                x, y = chain[t_ - 1][0], chain[t_][0]
                if chain[t_][1]:
                    assert x == y, (n, k, l, t_)
                else:
                    assert pair_in(x, y, J), (n, k, l, t_)
                count += 1
            # 第 2 成分から -b = b（J を法として）
            assert J.reduce(-b - b) == 0
            count += 1
            # b の鎖: b = 1/2 (b + b) = 1/2 ((-b) + b) = 1/2 · 0 = 0
            chain3 = [(b, True), ((b + b) / 2, True), (((-b) + b) / 2, False), (P(0) / 2, True), (P(0), True)]
            # 2 行目 → 3 行目は -b = b による（J を法として）。3 行目 → 4 行目は ℝ の (-b) + b = 0（恒等的）
            assert chain3[0][0] == chain3[1][0]
            assert J.reduce(chain3[1][0] - chain3[2][0]) == 0
            assert chain3[2][0] == chain3[3][0] and chain3[3][0] == chain3[4][0]
            count += 4
            # 最後の鎖: A_kl = (a, b) = (a, 0) = a_C
            assert A[k][l] == (a, b)
            assert pair_in((a, b), (a, P(0)), J)
            assert (a, P(0)) == iota(a, P)
            count += 3
            # 結論: b_kl は J に入る（成分は実数）
            assert J.reduce(b) == 0
    print(f"n = {n}: 全ての k, l で 3 つの鎖を確かめた（累計 {count} 段）")

# 否定コントロール: 仮定の片方だけでは成分の虚部 b_kl は 0 にならない
neg = 0
for n in range(1, 4):
    for (us, ut, why) in [(True, False, "A^* = A だけ"), (False, True, "A^⊤ = A だけ")]:
        if us and not ut and n == 1:
            continue  # n = 1 では A^* = A だけで A_11 の虚部が 0 になる（1 行 1 列ではエルミートと実対称が一致する）
        P, A, Astar, At, J = setup(n, us, ut)
        bad = [(k, l) for k in range(n) for l in range(n) if J.reduce(A[k][l][1]) != 0]
        assert bad, (n, why)
        neg += 1
        if not ut:
            # A^* = A だけでは、7 行の鎖の 6 行目（A^T = A）が J を法として外れる（n ≥ 2 の非対角）
            assert not pair_in(At[0][1], A[0][1], J)
            neg += 1
print(f"{count} 段（n = 1..3 の全成分、成分は QQ 上の不定元の対、仮定はイデアルで厳密に）")
print(f"否定コントロール {neg} 件: 仮定の片方だけでは虚部が 0 にならない、A^* = A だけでは A^⊤ = A の行が外れる")
print("RESULT: PASS")
