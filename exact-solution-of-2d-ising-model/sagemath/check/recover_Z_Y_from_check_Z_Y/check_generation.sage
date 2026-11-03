# 対象ラベル: recover_Z_Y_from_check_Z_Y
# 主張の「とくに」（Ž_μ・Y̌_μ を含み単位行列を含み和・スカラー倍・積で閉じる部分集合は Mat(2^N, C) 全体）を、
# M = 2, 3 で、I・Ž_μ・Y̌_μ から右へ積を繰り返して張る部分空間の次元が 4^M になることで確かめる。
# 張る部分空間は (ii)〜(iv) を満たし Ž・Y̌ を含む最小の集合であり、その次元が 4^M なら全体である。
# 証明の論法（Ž・Y̌ の C 線型結合として Z_j・Y_j が入るので Z_Y_generate_algebra に帰着する）も、
# 張った部分空間に Z_j・Y_j が入ることで確かめる。厳密: 円分体 QQ(ζ_{4M}) の線型代数。
# 対照: Ž_μ だけ（Y̌_μ を除く）から張ると全体にならない。
load("../../_shared/pauli_sites_exact.sage")


def closure(gens, n, L):
    """I から始めて右から gens を掛け、張る部分空間が増えなくなるまで繰り返す。基底の行列の組を返す。"""
    V = VectorSpace(L, n * n)
    vec = lambda A: V(A.list())
    basis = [identity_matrix(L, n)]
    W = V.subspace([vec(basis[0])])
    frontier = list(basis)
    while frontier:
        new = []
        for B in frontier:
            for g in gens:
                P = B * g
                v = vec(P)
                if v not in W:
                    W = V.subspace(W.basis() + [v])
                    new.append(P)
        frontier = new
    return W, vec


for M in [2, 3]:
    L = CyclotomicField(4 * M, 'z')
    zeta = L.gen()
    iL = zeta**M

    def conv(A):
        return matrix(L, A.nrows(), A.ncols(), lambda r, c: L(KG(A[r, c]).list()[0]) + L(KG(A[r, c]).list()[1]) * iL)

    def ph(q):
        ex = 4 * M * QQ(q)
        assert ex in ZZ
        return zeta**ZZ(ex)

    J = list(range(1, M + 1))
    n = 2**M
    t = lambda lam: (QQ(lam) - QQ(1) / 2) / M
    Z = {m: conv(jw(M, m, 'z')) for m in J}
    Y = {m: conv(jw(M, m, 'y')) for m in J}
    cZ = [sum(ph(-QQ(k) * t(lam)) * Z[k] for k in J) for lam in J]
    cY = [sum(ph(-QQ(k) * t(lam)) * Y[k] for k in J) for lam in J]
    W, vec = closure(cZ + cY, n, L)
    assert W.dimension() == 4**M, (M, W.dimension())
    for m in J:
        assert vec(Z[m]) in W and vec(Y[m]) in W
    Wz, _ = closure(cZ, n, L)
    assert Wz.dimension() < 4**M
    print(f"  M = {M}: span closure of I, check Z, check Y has dimension {W.dimension()} = 4^{M}; check Z alone gives {Wz.dimension()}")
print("RESULT: PASS")
