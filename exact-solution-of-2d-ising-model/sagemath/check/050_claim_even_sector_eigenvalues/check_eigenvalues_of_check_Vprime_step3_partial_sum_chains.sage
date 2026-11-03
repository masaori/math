# 対象ラベル: eigenvalues_of_check_Vprime
# eigenvalues_of_check_Vprime の Step 3（E_KQ̌_ε）と Step 3'（Q̌_εE_K）の部分和の鎖（各 8 行）を、各行に書かれた式どおりに
# 本文の定義（mat_mult・def_matrix_scalar_multiple・def_matrix_sum・def_finite_sum_of_matrices・
# def_finite_sum_of_matrices_from_index_zero・def_finite_sum_of_complex_numbers・def_finite_sum_of_complex_numbers_from_index_zero・
# def_exp (1) の冪 A^0 := I、A^{m+1} := A^m A）で成分から組み、隣り合う項が等しいことを一行ずつ確かめる。
# 添字 0 からの和は、定義どおり項 X_{j-1}（j = 1..K+1）を左から足す和として組む。
# 模型: Jordan–Wigner のフェルミ演算子 c_μ から n_μ := c_μ^T c_μ、Q̌_ε := Π_μ R_μ^{(ε_μ)}（R^{(1)} := n、R^{(0)} := I − n）、
# X̌ := Σ_μ γ_μ(n_μ − ½I)、有理数 γ_μ（M = 2, 3、ε を全列挙、K = 0..4）。
# 鎖が使う仮定は Step 2 の X̌^kQ̌_ε = ǧ(ε)^kQ̌_ε（右からの形は Step 3' の帰納法の Q̌_εX̌^k = ǧ(ε)^kQ̌_ε）だけである。
# 否定コントロール: 不定元の成分の 2×2 行列 X、Q と不定元 g（K = 2）では、その仮定を引く行だけが等号を外れ、
# ほかの 7 行は等号のまま残ることを確かめる。
# 帰属: 成分は QQ と、QQ 上の多項式環（厳密計算）。
load("../../_shared/matrix_operations_by_definition.sage")
load("../../_shared/matrix_negation_and_difference_by_definition.sage")


def kron(factors):
    out = matrix(factors[0].base_ring(), 1, 1, [1])
    for A in factors:
        out = out.tensor_product(A)
    return out


def mpow(A, k, Id):
    """def_exp (1) の冪: A^0 := I、A^{m+1} := A^m A。"""
    out = Id
    for _ in range(k):
        out = body_product(out, A)
    return out


def cpow(z, k):
    out = z.parent()(1)
    for _ in range(k):
        out = out * z
    return out


def csum(zs):
    """def_finite_sum_of_complex_numbers: 左から順に足す。"""
    out = zs[0]
    for z in zs[1:]:
        out = out + z
    return out


def chains(X, Q, g, K, Id):
    """左右の鎖の 9 の項（名前, 値, その項へ移る段が Step 2（右は Step 3' の帰納法）を引くか）。"""
    R = Q.base_ring()
    sc = body_scalar
    mul = body_product
    fs = body_finite_sum
    inv = [R(1) / factorial(k) for k in range(K + 1)]
    js = range(1, K + 2)
    E0 = fs([sc(inv[k], mpow(X, k, Id)) for k in range(K + 1)])            # Σ_{k=0}^{K}（項 X_k を並べた和）
    E1 = fs([sc(inv[j - 1], mpow(X, j - 1, Id)) for j in js])              # Σ_{j=1}^{K+1} X_{j-1}
    c1 = csum([inv[j - 1] * cpow(g, j - 1) for j in js])
    c0 = csum([inv[k] * cpow(g, k) for k in range(K + 1)])
    left = [
        ("E_K Q", mul(E0, Q), False),
        ("(Σ_{k=0} (1/k!)X^k) Q", mul(E0, Q), False),
        ("(Σ_{j=1} (1/(j-1)!)X^{j-1}) Q", mul(E1, Q), False),
        ("Σ (((1/(j-1)!)X^{j-1}) Q)", fs([mul(sc(inv[j - 1], mpow(X, j - 1, Id)), Q) for j in js]), False),
        ("Σ (1/(j-1)!)(X^{j-1} Q)", fs([sc(inv[j - 1], mul(mpow(X, j - 1, Id), Q)) for j in js]), False),
        ("Σ (1/(j-1)!)(g^{j-1} Q)", fs([sc(inv[j - 1], sc(cpow(g, j - 1), Q)) for j in js]), True),
        ("Σ ((1/(j-1)!) g^{j-1}) Q", fs([sc(inv[j - 1] * cpow(g, j - 1), Q) for j in js]), False),
        ("(Σ_{j=1} (1/(j-1)!) g^{j-1}) Q", sc(c1, Q), False),
        ("(Σ_{k=0} (1/k!) g^k) Q", sc(c0, Q), False),
    ]
    right = [
        ("Q E_K", mul(Q, E0), False),
        ("Q (Σ_{k=0} (1/k!)X^k)", mul(Q, E0), False),
        ("Q (Σ_{j=1} (1/(j-1)!)X^{j-1})", mul(Q, E1), False),
        ("Σ (Q ((1/(j-1)!)X^{j-1}))", fs([mul(Q, sc(inv[j - 1], mpow(X, j - 1, Id))) for j in js]), False),
        ("Σ (1/(j-1)!)(Q X^{j-1})", fs([sc(inv[j - 1], mul(Q, mpow(X, j - 1, Id))) for j in js]), False),
        ("Σ (1/(j-1)!)(g^{j-1} Q)", fs([sc(inv[j - 1], sc(cpow(g, j - 1), Q)) for j in js]), True),
        ("Σ ((1/(j-1)!) g^{j-1}) Q", fs([sc(inv[j - 1] * cpow(g, j - 1), Q) for j in js]), False),
        ("(Σ_{j=1} (1/(j-1)!) g^{j-1}) Q", sc(c1, Q), False),
        ("(Σ_{k=0} (1/k!) g^k) Q", sc(c0, Q), False),
    ]
    return left, right


def check(lines, label, expect_all):
    global count
    failed = []
    for (a, A, _), (b, B, hyp) in zip(lines, lines[1:]):
        if A == B:
            count += 1
        else:
            failed.append((a, b, hyp))
    if expect_all:
        assert not failed, (label, failed)
    return failed


count = 0
sz = matrix(QQ, [[1, 0], [0, -1]])
lower = matrix(QQ, [[0, 1], [0, 0]])
id2 = identity_matrix(QQ, 2)
gammas = [QQ(3) / 2, QQ(5) / 7, QQ(2)]
for M in range(2, 4):
    Id = body_identity(QQ, 2 ** M)
    c = [kron([sz] * (k - 1) + [lower] + [id2] * (M - k)) for k in range(1, M + 1)]
    n = [c[mu].transpose() * c[mu] for mu in range(M)]
    X = sum(gammas[mu] * (n[mu] - Id / 2) for mu in range(M))
    for eps in cartesian_product([[0, 1]] * M):
        eps = [QQ(e) for e in eps]
        Q = Id
        for mu in range(M):
            Q = Q * (n[mu] if eps[mu] == 1 else Id - n[mu])
        g = sum(gammas[mu] * (eps[mu] - QQ(1) / 2) for mu in range(M))
        for k in range(6):   # 鎖の仮定（Step 2 と Step 3' の帰納法）が模型で成り立つ
            assert X ** k * Q == g ** k * Q and Q * X ** k == g ** k * Q
        for K in range(5):
            left, right = chains(X, Q, g, K, Id)
            check(left, ("left", M, eps, K), True)
            check(right, ("right", M, eps, K), True)
            # 両端を Sage の演算（独立な経路）で組んだ値と比べる
            Es = sum(X ** k / factorial(k) for k in range(K + 1))
            cs = sum(g ** k / factorial(k) for k in range(K + 1))
            assert Es * Q == left[0][1] and left[-1][1] == cs * Q
            assert Q * Es == right[0][1] and right[-1][1] == cs * Q

# 否定コントロール: 不定元の成分の 2×2 行列 X、Q と不定元 g（K = 2）
P = PolynomialRing(QQ, [f"x{j}" for j in range(4)] + [f"q{j}" for j in range(4)] + ["g"])
G = P.gens()
Xg = matrix(P, 2, 2, G[0:4])
Qg = matrix(P, 2, 2, G[4:8])
left, right = chains(Xg, Qg, G[8], 2, body_identity(P, 2))
for side in (left, right):
    failed = check(side, "generic", False)
    assert len(failed) == 1 and failed[0][2], failed   # Step 2（右は Step 3' の帰納法）を引く行だけが外れる
print(f"checked {count} steps (model M = 2, 3 with all eps and K = 0..4, and 7 + 7 steps of the generic control); the only failing step in each control chain is the one citing Step 2 (Step 3' induction)")
print("RESULT: PASS")
