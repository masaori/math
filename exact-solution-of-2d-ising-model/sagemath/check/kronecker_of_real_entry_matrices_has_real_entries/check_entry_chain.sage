# 対象ラベル: kronecker_of_real_entry_matrices_has_real_entries
# 証明の成分の鎖: (A_1⊠⋯⊠A_M)_{ν(I),ν(J)} = ∏_k (A_k)_{i_k j_k} = r_C。
# A_k の成分を QQ 上の不定元（実数）に置き、ℂ は QQ(i) 上の多項式環の元として持つ。クロネッカー積は def_kronecker の
# 成分の式で組み、Sage の tensor_product と一致することを見てから使う。M = 1..4 の全成分で、成分の虚部が 0 であること
# （r_C の形）と、r が因子の成分の積であることを確かめる。帰属: QQ(i)[a_{k,p,q}]。
K.<I> = QuadraticField(-1)
import itertools

def kron_by_definition(As):
    M = len(As)
    idx = list(itertools.product(range(2), repeat=M))
    nu = {J: sum(J[k] * 2^(M - 1 - k) for k in range(M)) for J in idx}   # def_kronecker の ν（0 始まり）
    B = matrix(As[0].base_ring(), 2^M, 2^M)
    for Iv in idx:
        for Jv in idx:
            B[nu[Iv], nu[Jv]] = prod(As[k][Iv[k], Jv[k]] for k in range(M))
    return B, idx, nu

total = 0
for M in range(1, 5):
    names = ['a_%d_%d_%d' % (k, p, q) for k in range(M) for p in range(2) for q in range(2)]
    Rr = PolynomialRing(QQ, names)          # 実数の不定元
    S = PolynomialRing(K, names)
    g = S.gens()
    As = [matrix(S, 2, 2, [g[4 * k + 2 * p + q] for p in range(2) for q in range(2)]) for k in range(M)]
    B, idx, nu = kron_by_definition(As)
    T = As[0]
    for A in As[1:]:
        T = T.tensor_product(A)
    assert B == T
    for Iv in idx:
        for Jv in idx:
            e = B[nu[Iv], nu[Jv]]
            rr = prod(Rr.gens()[4 * k + 2 * Iv[k] + Jv[k]] for k in range(M))   # r := ∏ r_k
            assert e == S(rr)                                                   # 虚部 0（r_C の形）
            assert all(c.imag() == 0 for c in e.coefficients())
            total += 1
# 対照: 純虚数の成分を持つ因子が 1 個あると、実数でない成分が出る
SY = matrix(K, [[0, -I], [I, 0]])
SX = matrix(K, [[0, 1], [1, 0]])
B, idx, nu = kron_by_definition([SY, SX])
assert any(B[a, b].imag() != 0 for a in range(4) for b in range(4))
print(f"checked {total} entries for M = 1..4")
print("RESULT: PASS")
