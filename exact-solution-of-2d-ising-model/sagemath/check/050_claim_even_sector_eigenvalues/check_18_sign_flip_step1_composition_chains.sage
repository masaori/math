# 対象ラベル: sign_flip_conjugation
# Step 1 の合成の段を一行ずつ厳密に確かめる（M = 2, 3, 4）。WXW^{-1} は (WX)W^{-1}。
# 合成の鎖（X は 2^M 次の行列。成分を不定元に置いた generic な X と、全ての σ_k^a で確かめる）:
#   UXU^{-1}
#   = ((EF)X)U^{-1}                 （U の定義）
#   = ((EF)X)(FE)                   （Step 0 の U^{-1} = FE）
#   = (E(FX))(FE)                   （mat_mult_associative）
#   = ((E(FX))F)E                   （mat_mult_associative）
#   = (E((FX)F))E                   （mat_mult_associative）
#   = (E((FX)F^{-1}))E              （Step 0 の F^{-1} = F）
#   = (E((FX)F^{-1}))E^{-1}         （Step 0 の E^{-1} = E）
# a ごとの鎖:
#   Uσ_k^xU^{-1} = E(Fσ_k^xF^{-1})E^{-1} = E(-σ_k^x)E^{-1} = (-(Eσ_k^x))E^{-1} = -((Eσ_k^x)E^{-1}) = -σ_k^x
#   Uσ_k^yU^{-1} = E(Fσ_k^yF^{-1})E^{-1} = E(-σ_k^y)E^{-1} = (-(Eσ_k^y))E^{-1} = -((Eσ_k^y)E^{-1})
#                = -(-σ_k^y)（k 奇数）/ -σ_k^y（k 偶数） = σ_k^y（k 奇数、matrix_double_negation）/ -σ_k^y（k 偶数）
#   Uσ_k^zU^{-1} = E(Fσ_k^zF^{-1})E^{-1} = Eσ_k^zE^{-1} = -σ_k^z（k 奇数）/ σ_k^z（k 偶数）
# 帰属: 行列の成分は QQ(i)、generic な X の成分は QQ(i) 上の多項式環の不定元（代入は環準同型なので任意の複素数で成り立つ）。
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


def composition_chain(E, F, Einv, Finv, X):
    U = E * F
    Uinv = F * E
    return [
        (U * X) * U.inverse(),
        ((E * F) * X) * U.inverse(),
        ((E * F) * X) * Uinv,
        (E * (F * X)) * Uinv,
        ((E * (F * X)) * F) * E,
        (E * ((F * X) * F)) * E,
        (E * ((F * X) * Finv)) * E,
        (E * ((F * X) * Finv)) * Einv,
    ]


count = 0
for M in range(2, 5):
    F = kron([sz] * M)
    E = kron([sx if m % 2 == 1 else id2 for m in range(1, M + 1)])
    Finv = F.inverse()
    Einv = E.inverse()
    assert (E * F).inverse() == F * E
    # generic な X（成分を不定元に置く）で合成の鎖
    d = 2 ** M
    P = PolynomialRing(GAUSSIAN, ["x%d" % t for t in range(d * d)])
    Xg = matrix(P, d, d, P.gens())
    chain = composition_chain(E.change_ring(P), F.change_ring(P), Einv.change_ring(P), Finv.change_ring(P), Xg)
    assert all(c == chain[0] for c in chain), M
    count += len(chain) - 1
    for k in range(1, M + 1):
        sig = {a: kron([sa if m == k else id2 for m in range(1, M + 1)]) for a, sa in pauli.items()}
        for a in "xyz":
            chain = composition_chain(E, F, Einv, Finv, sig[a])
            assert all(c == chain[0] for c in chain), (M, k, a)
            count += len(chain) - 1
        U = E * F
        Uinv = U.inverse()
        odd = (k % 2 == 1)
        # a = x
        cx = [
            (U * sig["x"]) * Uinv,
            (E * ((F * sig["x"]) * Finv)) * Einv,
            (E * neg(sig["x"])) * Einv,
            neg(E * sig["x"]) * Einv,
            neg((E * sig["x"]) * Einv),
            neg(sig["x"]),
        ]
        assert all(c == cx[0] for c in cx), (M, k, "x")
        count += len(cx) - 1
        # a = y
        cy = [
            (U * sig["y"]) * Uinv,
            (E * ((F * sig["y"]) * Finv)) * Einv,
            (E * neg(sig["y"])) * Einv,
            neg(E * sig["y"]) * Einv,
            neg((E * sig["y"]) * Einv),
            neg(neg(sig["y"])) if odd else neg(sig["y"]),
            sig["y"] if odd else neg(sig["y"]),
        ]
        assert all(c == cy[0] for c in cy), (M, k, "y")
        count += len(cy) - 1
        # a = z
        cz = [
            (U * sig["z"]) * Uinv,
            (E * ((F * sig["z"]) * Finv)) * Einv,
            (E * sig["z"]) * Einv,
            neg(sig["z"]) if odd else sig["z"],
        ]
        assert all(c == cz[0] for c in cz), (M, k, "z")
        count += len(cz) - 1

# 否定コントロール（M = 2）: U^{-1} を FE ではなく EF と取り違えると、M = 2 では E と F が反可換（EF = -FE）なので
# ((EF)X)(EF) は合成の鎖の 3 行目 ((EF)X)(FE) の符号反転になり、generic な X では一致しない
M = 2
F = kron([sz] * M)
E = kron([sx, id2])
d = 4
P = PolynomialRing(GAUSSIAN, ["x%d" % t for t in range(d * d)])
Xg = matrix(P, d, d, P.gens())
Ep, Fp = E.change_ring(P), F.change_ring(P)
assert ((Ep * Fp) * Xg) * (Ep * Fp) != ((Ep * Fp) * Xg) * (Fp * Ep)
assert ((Ep * Fp) * Xg) * (Ep * Fp) == neg(((Ep * Fp) * Xg) * (Fp * Ep))
print("PASS sign_flip_conjugation Step 1 の合成の鎖と Uσ_k^aU^{-1} の鎖: %d 段" % count)
