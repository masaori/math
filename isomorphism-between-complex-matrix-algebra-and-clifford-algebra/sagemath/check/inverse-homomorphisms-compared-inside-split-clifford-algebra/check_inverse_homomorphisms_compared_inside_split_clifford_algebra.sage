# 対象ラベル: claim_homomorphism_to_clifford_algebra_after_homomorphism_to_matrix_algebra_is_identity,
#   claim_existence_and_uniqueness_of_homomorphism_from_clifford_algebra_to_matrix_algebra,
#   claim_homomorphism_from_matrix_algebra_to_clifford_algebra_preserves_product_of_matrix_units
# 分裂した二次空間 V=W⊕W^*、q((x,ξ))=ξ(x) のクリフォード代数 Cl(V,q) を SageMath の CliffordAlgebra で作り、
# Ψ(Φ(a))=a と Ψ(E_{S,T})Ψ(E_{U,R})=δ_{T,U}Ψ(E_{S,R}) を Cl(V,q) の中で直接比べる（行列への像での確認ではない）。
# Φ の存在は、生成元の像 c_i・c_i^T から単調な積で決めた写像が Cl(V,q) の基底どうしの積を保つことで確かめる。
# 係数は QQ の厳密計算。M=1,2,3。
from itertools import combinations

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
    c = {i: matrix(QQ, n, n, lambda s, t: sign(N(i, P[t])) if (i not in P[t] and P[s] == P[t] | {i}) else 0)
         for i in range(1, M + 1)}                                                 # def_creation_operator_matrix
    ct = {i: matrix(QQ, n, n, lambda s, t: c[i][t, s]) for i in c}                # def_annihilation_operator_matrix
    # V の基底 d_k=in_1(w_k)、d_{M+k}=in_2(f_k) の座標 y で q(y)=Σ_k y_k y_{M+k}。SageMath の QuadraticForm(R, H) は q(y)=y^T H y/2。
    H = matrix(QQ, 2 * M, 2 * M, lambda r, s: 1 if abs(r - s) == M else 0)
    Qform = QuadraticForm(QQ, H)
    ys = identity_matrix(QQ, 2 * M).rows() + [vector(QQ, [QQ.random_element(num_bound=6, den_bound=3) for _ in range(2 * M)]) for _ in range(3)]
    ok(all(Qform(y) == sum(y[k] * y[M + k] for k in range(M)) for y in ys))      # SageMath の二次形式が q であること
    Cl = CliffordAlgebra(Qform)
    xg = Cl.gens()
    ad = {i: xg[i - 1] for i in range(1, M + 1)}                                  # a†_i=γ(d_i)（def_creation_and_annihilation_generators）
    an = {i: xg[M + i - 1] for i in range(1, M + 1)}                              # a_i=γ(d_{M+i})
    gen_img = [c[i] for i in range(1, M + 1)] + [ct[i] for i in range(1, M + 1)]  # Φ(γ(d_k))（Φ(a†_i)=c_i、Φ(a_i)=c_i^T）
    def Phi(a):                                                                   # 生成元の像から単調な積で決めた Φ
        tot = Z0
        for mon, coeff in a.monomial_coefficients().items():
            tot = tot + coeff * oprod([gen_img[j] for j in sorted(mon)], I)
        return tot
    basis = list(Cl.basis())
    ok(len(basis) == 4 ** M)
    # claim_existence_and_uniqueness_of_homomorphism_from_clifford_algebra_to_matrix_algebra：
    # 単調な積で決めた写像が Cl(V,q) の基底どうしの積と単位元を保つ（生成元の関係から準同型が存在することの裏取り）
    ok(Phi(Cl.one()) == I)
    for b1 in basis:
        for b2 in basis:
            ok(Phi(b1 * b2) == Phi(b1) * Phi(b2))
    # 否定の対照: 生成元の像を c_i と c_i^T で取り違えずに符号だけ落とした行列（成分 1）では、積を保たない（M ≥ 2）
    if M >= 2:
        cb = {i: matrix(QQ, n, n, lambda s, t: 1 if (i not in P[t] and P[s] == P[t] | {i}) else 0) for i in range(1, M + 1)}
        bad_img = [cb[i] for i in range(1, M + 1)] + [cb[i].transpose() for i in range(1, M + 1)]
        Phib = lambda a: sum((coeff * oprod([bad_img[j] for j in sorted(mon)], I) for mon, coeff in a.monomial_coefficients().items()), Z0)
        neg(any(Phib(b1 * b2) != Phib(b1) * Phib(b2) for b1 in basis for b2 in basis))
    # Ψ(F)=Σ_{S,T} F_{S,T} a†_S P a_T（def_homomorphism_from_matrix_algebra_to_clifford_algebra）
    def make_Psi(adg, ann):
        Pv = oprod([ann[i] * adg[i] for i in range(1, M + 1)], Cl.one())          # P=a_1a†_1⋯a_Ma†_M
        EC = {(a, b): oprod([adg[t] for t in sorted(S)], Cl.one()) * Pv * oprod([ann[t] for t in sorted(T, reverse=True)], Cl.one())
              for a, S in enumerate(P) for b, T in enumerate(P)}                 # ℰ_{S,T}=a†_S P a_T
        return EC, (lambda F: sum((F[a, b] * EC[(a, b)] for a in range(n) for b in range(n) if F[a, b] != 0), Cl.zero()))
    EC, Psi = make_Psi(ad, an)
    # claim_homomorphism_from_matrix_algebra_to_clifford_algebra_preserves_product_of_matrix_units：Cl(V,q) の中で
    # Ψ(E_{S,T})Ψ(E_{U,R}) = δ_{T,U} Ψ(E_{S,R})
    for a in range(n):
        for b in range(n):
            for u in range(n):
                for r in range(n):
                    ok(EC[(a, b)] * EC[(u, r)] == (EC[(a, r)] if b == u else Cl.zero()))
    # claim_homomorphism_to_clifford_algebra_after_homomorphism_to_matrix_algebra_is_identity：Cl(V,q) の中で Ψ(Φ(a))=a。
    # 基底 4^M 個、生成元 γ(y)（y は基底の座標と乱数の座標）、その二つの積、乱数の元で比べる
    gamma = lambda y: sum((y[k] * xg[k] for k in range(2 * M)), Cl.zero())
    tests = basis + [gamma(y) for y in ys] + [gamma(y1) * gamma(y2) for y1 in ys for y2 in ys]
    tests += [sum((QQ.random_element(num_bound=5, den_bound=3) * bm for bm in basis), Cl.zero()) for _ in range(3)]
    for a in tests:
        ok(Psi(Phi(a)) == a)
    # 否定の対照: Ψ の式で P を 1 に替えると Ψ(Φ(1))=1 が崩れ（Σ_S a†_S a_S ≠ 1）、
    # a と a† を取り違えると Ψ(Φ(γ(d_1)))=γ(d_1) が崩れる
    EC1 = {(a, b): oprod([ad[t] for t in sorted(S)], Cl.one()) * oprod([an[t] for t in sorted(T, reverse=True)], Cl.one())
           for a, S in enumerate(P) for b, T in enumerate(P)}
    Psi1 = lambda F: sum((F[a, b] * EC1[(a, b)] for a in range(n) for b in range(n) if F[a, b] != 0), Cl.zero())
    neg(Psi1(Phi(Cl.one())) != Cl.one())
    _, PsiSwap = make_Psi(an, ad)
    neg(PsiSwap(Phi(xg[0])) != xg[0])
    print("M =", M, "通過", flush=True)
print("PASS", passed, "negative controls", negs)
