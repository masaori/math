# 対象ラベル: claim_homomorphism_to_odd_clifford_algebra_after_homomorphism_to_pair_of_matrices_is_identity,
#   claim_existence_and_uniqueness_of_homomorphism_from_odd_clifford_algebra_to_pair_of_matrix_algebras,
#   claim_homomorphism_from_pair_of_matrix_algebras_to_odd_clifford_algebra_is_algebra_homomorphism
# V'=V⊕ℂ^vec、q'((v,t))=q(v)+t·t のクリフォード代数 Cl(V',q') を SageMath の CliffordAlgebra で作り、
# Ψ'(Φ'(a))=a と Ψ'(X·Y)=Ψ'(X)·Ψ'(Y) を Cl(V',q') の中で直接比べる（行列への像での確認ではない）。
# Φ' の存在は、生成元の像から単調な積で決めた写像が Cl(V',q') の基底どうしの積を保つことで確かめる。
# B×B の元 (X,Y) は、計算の便宜として区分対角の行列 diag(X,Y) で持つ（積と和は成分ごとの積と和に一致する）。
# 係数は QQ の厳密計算。M=1,2,3。
from itertools import combinations
import random
random.seed(int(20261115))

def power_set(M):
    base = list(range(1, M + 1))
    return [frozenset(cc) for r in range(M + 1) for cc in combinations(base, r)]

def N(i, T):                       # def_count_of_subset_elements_below_index
    if i == 1:
        return 0
    return N(i - 1, T) + 1 if (i - 1) in T else N(i - 1, T)

def sign(n):                       # def_sign_of_nonnegative_integer
    return QQ(1) if n == 0 else QQ(-1) * sign(n - 1)

def oprod(factors, one):           # def_ordered_product_in_algebra（左から右へ掛ける）
    r = one
    for f in factors:
        r = r * f
    return r

passed = 0
negs = 0
def ok(b):
    global passed
    assert b
    passed += 1
def neg(b):
    global negs
    assert b
    negs += 1

for M in range(1, 4):
    P = power_set(M)
    n = len(P)
    I = identity_matrix(QQ, n)
    Z0 = zero_matrix(QQ, n)
    pair = lambda X, Y: block_diagonal_matrix(X, Y, subdivide=False)               # (X,Y) ∈ B×B
    I2 = pair(I, I)
    Z2 = pair(Z0, Z0)
    c = {i: matrix(QQ, n, n, lambda s, t: sign(N(i, P[t])) if (i not in P[t] and P[s] == P[t] | {i}) else 0)
         for i in range(1, M + 1)}                                                 # def_creation_operator_matrix
    ct = {i: matrix(QQ, n, n, lambda s, t: c[i][t, s]) for i in c}                # def_annihilation_operator_matrix
    PhiEps = oprod([ct[i] * c[i] - c[i] * ct[i] for i in range(1, M + 1)], I)      # Φ(ε)=∏_i Φ(χ_i)
    # V' の基底 d'_k=in'_1(d_k)（k ≤ 2M）、d'_{2M+1}=in'_2(1)=u の座標 y で q'(y)=Σ_k y_k y_{M+k} + y_{2M+1}^2
    H = matrix(QQ, 2 * M + 1, 2 * M + 1, lambda r, s: 1 if (r < 2 * M and s < 2 * M and abs(r - s) == M) else (2 if r == s == 2 * M else 0))
    Qform = QuadraticForm(QQ, H)
    ys = identity_matrix(QQ, 2 * M + 1).rows() + [vector(QQ, [QQ.random_element(num_bound=6, den_bound=3) for _ in range(2 * M + 1)]) for _ in range(3)]
    ok(all(Qform(y) == sum(y[k] * y[M + k] for k in range(M)) + y[2 * M] ** 2 for y in ys))
    Cl = CliffordAlgebra(Qform)
    xg = Cl.gens()
    jad = {i: xg[i - 1] for i in range(1, M + 1)}                                 # j(a†_i)=γ'(in'_1(d_i))
    jan = {i: xg[M + i - 1] for i in range(1, M + 1)}                             # j(a_i)=γ'(in'_1(d_{M+i}))
    g = xg[2 * M]                                                                 # g=γ'(u)
    # Φ'(γ'(in'_1(d_k)))=(Φγ(d_k),Φγ(d_k))、Φ'(g)=(Φ(ε),−Φ(ε))（def_map_from_odd_extension_to_pair_of_matrices の値）
    gen_img = [pair(c[i], c[i]) for i in range(1, M + 1)] + [pair(ct[i], ct[i]) for i in range(1, M + 1)] + [pair(PhiEps, -PhiEps)]
    def make_Phi(imgs):
        return lambda a: sum((coeff * oprod([imgs[j] for j in sorted(mon)], I2) for mon, coeff in a.monomial_coefficients().items()), Z2)
    Phi_p = make_Phi(gen_img)
    basis = list(Cl.basis())
    ok(len(basis) == 2 * 4 ** M)
    # claim_existence_and_uniqueness_of_homomorphism_from_odd_clifford_algebra_to_pair_of_matrix_algebras：
    # 単調な積で決めた写像が単位元と Cl(V',q') の基底どうしの積を保つ
    ok(Phi_p(Cl.one()) == I2)
    for b1 in basis:
        for b2 in basis:
            ok(Phi_p(b1 * b2) == Phi_p(b1) * Phi_p(b2))
    # 否定の対照: Φ'(g) を (I,−I) にすると、g と生成元の像の反交換が崩れて基底どうしの積を保たない
    bad_img = gen_img[:-1] + [pair(I, -I)]
    Phib = make_Phi(bad_img)
    neg(any(Phib(b1 * b2) != Phib(b1) * Phib(b2) for b1 in basis for b2 in basis))
    # Ψ'(F,G)=j(Ψ(F))e_+ + j(Ψ(G))e_-（def_homomorphism_from_pair_of_matrix_algebras_to_odd_clifford_algebra）
    h = QQ(1) / 2
    jEps = oprod([jan[i] * jad[i] - jad[i] * jan[i] for i in range(1, M + 1)], Cl.one())   # j(ε)
    z = jEps * g
    ep = h * (Cl.one() + z)
    em = h * (Cl.one() - z)
    Pv = oprod([jan[i] * jad[i] for i in range(1, M + 1)], Cl.one())             # j(P)
    EC = {(a, b): oprod([jad[t] for t in sorted(S)], Cl.one()) * Pv * oprod([jan[t] for t in sorted(T, reverse=True)], Cl.one())
          for a, S in enumerate(P) for b, T in enumerate(P)}                     # j(ℰ_{S,T})
    jPsi = lambda F: sum((F[a, b] * EC[(a, b)] for a in range(n) for b in range(n) if F[a, b] != 0), Cl.zero())
    def Psi_p(X):
        F = X.submatrix(0, 0, n, n)
        G = X.submatrix(n, n, n, n)
        return jPsi(F) * ep + jPsi(G) * em
    # claim_homomorphism_from_pair_of_matrix_algebras_to_odd_clifford_algebra_is_algebra_homomorphism：
    # 行列単位の組 (E_{S,T},0)・(0,E_{S,T}) どうしの積と単位元を保つ（M=3 は無作為に選んだ 400 組）
    Eu = lambda a, b: matrix(QQ, n, n, lambda s, t: 1 if (s, t) == (a, b) else 0)
    units = [pair(Eu(a, b), Z0) for a in range(n) for b in range(n)] + [pair(Z0, Eu(a, b)) for a in range(n) for b in range(n)]
    PU = {k: Psi_p(X) for k, X in enumerate(units)}
    ok(Psi_p(I2) == Cl.one())
    prs = [(k, l) for k in range(len(units)) for l in range(len(units))]
    if M == 3:
        prs = random.sample(prs, 400)
    for k, l in prs:
        ok(Psi_p(units[k] * units[l]) == PU[k] * PU[l])
    # claim_homomorphism_to_odd_clifford_algebra_after_homomorphism_to_pair_of_matrices_is_identity：Cl(V',q') の中で Ψ'(Φ'(a))=a。
    gamma = lambda y: sum((y[k] * xg[k] for k in range(2 * M + 1)), Cl.zero())
    tests = basis + [gamma(y) for y in ys] + [gamma(y1) * gamma(y2) for y1 in ys for y2 in ys]
    tests += [sum((QQ.random_element(num_bound=5, den_bound=3) * bm for bm in basis), Cl.zero()) for _ in range(3)]
    for a in tests:
        ok(Psi_p(Phi_p(a)) == a)
    # 否定の対照: e_± の h を落とすと Ψ'(Φ'(1))=1 が崩れ、e_+ と e_- を入れ替えると Ψ'(Φ'(g))=g が崩れる
    Psi_noh = lambda X: jPsi(X.submatrix(0, 0, n, n)) * (Cl.one() + z) + jPsi(X.submatrix(n, n, n, n)) * (Cl.one() - z)
    neg(Psi_noh(Phi_p(Cl.one())) != Cl.one())
    Psi_sw = lambda X: jPsi(X.submatrix(0, 0, n, n)) * em + jPsi(X.submatrix(n, n, n, n)) * ep
    neg(Psi_sw(Phi_p(g)) != g)
    print("M =", M, "通過", flush=True)
print("PASS", passed, "negative controls", negs)
