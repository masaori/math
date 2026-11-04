# 対象ラベル: sign_flip_conjugation
# Step 2 を一行ずつ厳密に確かめる（M = 2, 3, 4, 5）。UXU^{-1} は (UX)U^{-1}、T_U(X) := (UX)U^{-1}。
# P_0 := I、P_{r+1} := P_r σ_{r+1}^x。
# r = 0 の鎖:  UP_0U^{-1} = UIU^{-1} = T_U(I) = I = P_0
# 帰納法の段:  UP_{r+1}U^{-1} = U(P_rσ_{r+1}^x)U^{-1} = T_U(P_rσ_{r+1}^x) = T_U(P_r)T_U(σ_{r+1}^x)
#   = (UP_rU^{-1})(Uσ_{r+1}^xU^{-1}) = (UP_rU^{-1})(-σ_{r+1}^x) = -((UP_rU^{-1})σ_{r+1}^x)
#   = -(P_rσ)（r 偶数）/ -((-P_r)σ)（r 奇数） = … / -(-(P_rσ)) = … / P_rσ = -P_{r+1} / P_{r+1}
# Z_m の鎖: U(P_{m-1}σ_m^z)U^{-1} = T_U(…) = T_U(P_{m-1})T_U(σ_m^z) = (UP_{m-1}U^{-1})(Uσ_m^zU^{-1})
#   = P_{m-1}(Uσ_m^zU^{-1}) / (-P_{m-1})(Uσ_m^zU^{-1}) = P_{m-1}(-σ_m^z) / (-P_{m-1})σ_m^z
#   = -(P_{m-1}σ_m^z) / (-P_{m-1})σ_m^z = -(P_{m-1}σ_m^z) = -Z_m（m 奇数 / m 偶数）
# Y_m の鎖: … = P_{m-1}(Uσ_m^yU^{-1}) / (-P_{m-1})(Uσ_m^yU^{-1}) = P_{m-1}σ_m^y / (-P_{m-1})(-σ_m^y)
#   = … / -(P_{m-1}(-σ_m^y)) = … / -(-(P_{m-1}σ_m^y)) = P_{m-1}σ_m^y = Y_m
# Z_m・Y_m は def_jordan_wigner_Z_matrices・def_jordan_wigner_Y_matrices の積 σ_1^x⋯σ_{m-1}^xσ_m^a を左から掛けて作り、
# P_{m-1}σ_m^a と一致することも確かめる。
# 帰属: 行列の成分は QQ(i)（厳密計算）。
GAUSSIAN = QuadraticField(-1, "i")
I_ = GAUSSIAN.gen()
sx = matrix(GAUSSIAN, [[0, 1], [1, 0]])
sy = matrix(GAUSSIAN, [[0, -I_], [I_, 0]])
sz = matrix(GAUSSIAN, [[1, 0], [0, -1]])
id2 = matrix(GAUSSIAN, 2, 2, lambda k, l: 1 if k == l else 0)   # def_identity_matrix
pauli = {"x": sx, "y": sy, "z": sz}


def kron(factors):
    # def_kronecker: 多重添字 (s_1..s_M), (t_1..t_M) の成分は ∏_k (A_k)_{s_k t_k}
    M = len(factors)
    d = 2 ** M
    R = factors[0].base_ring()
    def entry(r, c):
        val = R(1)
        for k in range(M):
            s = (r >> (M - 1 - k)) & 1
            t = (c >> (M - 1 - k)) & 1
            val *= factors[k][s, t]
        return val
    out = matrix(R, d, d, entry)
    ref = matrix(R, 1, 1, [1])
    for A in factors:
        ref = ref.tensor_product(A)
    assert out == ref
    return out


def neg(A):
    # def_matrix_negation: 成分ごとに -z = (-1)·z（multiply_by_minus_one）
    return matrix(A.base_ring(), A.nrows(), A.ncols(), lambda r, c: (-1) * A[r, c])


count = 0
for M in range(2, 6):
    d = 2 ** M
    Id = kron([id2] * M)
    F = kron([sz] * M)
    E = kron([sx if m % 2 == 1 else id2 for m in range(1, M + 1)])
    U = E * F
    Uinv = F * E                     # Step 0 の U^{-1} = FE
    assert U * Uinv == Id and Uinv * U == Id

    def T(X):
        return (U * X) * Uinv

    sig = {(a, k): kron([pauli[a] if m == k else id2 for m in range(1, M + 1)])
           for a in "xyz" for k in range(1, M + 1)}
    # Step 1 の結論（check_step1_composition_chains.sage が鎖を確かめた値）
    for k in range(1, M + 1):
        odd = (k % 2 == 1)
        assert T(sig[("x", k)]) == neg(sig[("x", k)])
        assert T(sig[("y", k)]) == (sig[("y", k)] if odd else neg(sig[("y", k)]))
        assert T(sig[("z", k)]) == (neg(sig[("z", k)]) if odd else sig[("z", k)])
    # P_r
    P = [Id]
    for r in range(M):
        P.append(P[r] * sig[("x", r + 1)])
    # r = 0 の鎖
    c0 = [T(P[0]), (U * Id) * Uinv, T(Id), Id, P[0]]
    assert all(c == c0[0] for c in c0), (M, 0)
    count += len(c0) - 1
    # 帰納法の段（0 ≤ r < M）
    for r in range(M):
        s = sig[("x", r + 1)]
        even = (r % 2 == 0)
        PrConj = T(P[r])
        assert PrConj == (P[r] if even else neg(P[r]))      # 帰納法の仮定
        chain = [
            T(P[r + 1]),
            (U * (P[r] * s)) * Uinv,
            T(P[r] * s),
            T(P[r]) * T(s),
            ((U * P[r]) * Uinv) * ((U * s) * Uinv),
            PrConj * T(s),
            PrConj * neg(s),
            neg(PrConj * s),
            neg(P[r] * s) if even else neg(neg(P[r]) * s),
            neg(P[r] * s) if even else neg(neg(P[r] * s)),
            neg(P[r] * s) if even else P[r] * s,
            neg(P[r + 1]) if even else P[r + 1],
        ]
        assert all(c == chain[0] for c in chain), (M, r)
        count += len(chain) - 1
    # Z_m・Y_m の鎖
    for m in range(1, M + 1):
        Pm = P[m - 1]
        odd = (m % 2 == 1)
        for a in "zy":
            prod = Id
            for k in range(1, m):
                prod = prod * sig[("x", k)]
            Jm = prod * sig[(a, m)]                          # def_jordan_wigner_*_matrices の積
            assert Jm == Pm * sig[(a, m)]
            sa = sig[(a, m)]
            head = [
                T(Jm),
                (U * (Pm * sa)) * Uinv,
                T(Pm * sa),
                T(Pm) * T(sa),
                ((U * Pm) * Uinv) * ((U * sa) * Uinv),
                (Pm if odd else neg(Pm)) * T(sa),
            ]
            if a == "z":
                tail = [
                    Pm * neg(sa) if odd else neg(Pm) * sa,
                    neg(Pm * sa) if odd else neg(Pm) * sa,
                    neg(Pm * sa),
                    neg(Jm),
                ]
            else:
                tail = [
                    Pm * sa if odd else neg(Pm) * neg(sa),
                    Pm * sa if odd else neg(Pm * neg(sa)),
                    Pm * sa if odd else neg(neg(Pm * sa)),
                    Pm * sa,
                    Jm,
                ]
            chain = head + tail
            assert all(c == chain[0] for c in chain), (M, m, a)
            count += len(chain) - 1

# 否定コントロール（M = 3）: Step 1 の Uσ_k^xU^{-1} の符号を落として +σ_k^x とすると、帰納法の段は P_{r+1} の符号を
# 反転させず、r = 0 → 1 で UP_1U^{-1} = -P_1 と一致しない
M = 3
Id = kron([id2] * M)
F = kron([sz] * M)
E = kron([sx, id2, sx])
U = E * F
Uinv = F * E
s1 = kron([sx, id2, id2])
P1 = Id * s1
assert (U * P1) * Uinv == neg(P1)
assert (U * P1) * Uinv != ((U * Id) * Uinv) * s1
print("PASS sign_flip_conjugation Step 2 の P_r の帰納法と Z_m・Y_m の鎖: %d 段" % count)
