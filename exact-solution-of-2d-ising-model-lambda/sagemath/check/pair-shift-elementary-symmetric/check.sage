# 節「根の対の整数倍のずらしの基本対称式」の三つのブロックの式鎖を一行ずつ確かめる。
# 対象ラベル: def_pair_shift_values, claim_pair_shift_elementary_symmetric_is_symmetric,
#             claim_pair_shift_elementary_symmetric_subfield_coefficient
# 帰属: 係数は円分体 Q(ζ_8)（代数的数の部分体）の元。部分体 F は Q と Q(√2) = Q(ζ_8 + ζ_8^{-1})。
# 浮動小数点は使わない。
import itertools

failures = []
passes = 0
def check(cond, msg):
    global passes
    if not cond:
        failures.append(msg)
    else:
        passes += 1

K.<z> = CyclotomicField(8)
sqrt2 = z + z^(-1)
assert sqrt2^2 == 2
conj = K.hom([z^(-1)])          # Q(√2) はこの自己同型の固定体
def in_Q(a): return a in QQ
def in_Q_sqrt2(a): return conj(a) == a

def ring(m):
    # m 変数の多項式環。m = 0 のときは変数 1 個の環の定数だけを使う。
    if m == 0:
        return PolynomialRing(K, 'W', 1), []
    R = PolynomialRing(K, ['X%d' % k for k in range(m)])
    return R, list(R.gens())

def subsets(m, i):
    return [frozenset(S) for S in itertools.combinations(range(m), i)]

def es(m, i):
    R, X = ring(m)
    return sum((prod((X[k] for k in S), R(1)) for S in subsets(m, i)), R(0)), R

def ms(P, m, values, Rt):
    # 定義どおりの代入: Σ_a mk(mco_a(P)) ∏_k y(k)^{a(k)}
    if m == 0:
        return Rt(P.constant_coefficient())
    total = Rt(0)
    for a, cf in P.dict().items():
        a = tuple(a) if m > 1 else ((a,) if not isinstance(a, tuple) else tuple(a))
        total += Rt(cf) * prod((values[k] ** a[k] for k in range(m)), Rt(1))
    return total

def coeffs(P):
    return list(P.dict().values())

def pairs(d):
    return [(i, j) for i in range(d) for j in range(d) if i < j]

def pp(rho, p):
    i, j = p
    return (min(rho[i], rho[j]), max(rho[i], rho[j]))

cs = [K(0), K(1), K(-2), K(1)/3, sqrt2, z]
for d in range(0, 5):
    Rd, Xd = ring(d)
    Pr = pairs(d)
    N = len(Pr)
    # 全単射 ν: 辞書式順と、逆順の二つ
    nus = [list(Pr), list(reversed(Pr))]
    for nu in nus:
        check(sorted(nu) == sorted(Pr) and len(set(nu)) == N, "nu is bijection")
        nu_inv = {p: r for r, p in enumerate(nu)}
        for c in cs:
            # 定義: ps_{c,ν}(r) = X_i + X_j + mk_d(c) X_i X_j
            ps = [Xd[nu[r][0]] + Xd[nu[r][1]] + Rd(c) * Xd[nu[r][0]] * Xd[nu[r][1]] for r in range(N)]
            RN, XN = ring(N)
            for k in range(0, N + 2):
                E, _ = es(N, k)
                M = ms(E, N, ps, Rd)
                # Sage の代入と定義どおりの代入の一致
                if N > 0:
                    check(M == E(*ps), "ms matches Sage substitution")
                for rho in Permutations(d) if d > 0 else [[]]:
                    rho = [int(x) - 1 for x in rho]
                    rho_inv = [rho.index(i) for i in range(d)]
                    # 第一の準備: pp_ϱ ∈ Pr_d、pp_{ϱ^{-1}} ∘ pp_ϱ = id、pp_ϱ ∘ pp_{ϱ^{-1}} = id
                    for p in Pr:
                        check(pp(rho, p) in Pr, "pp in Pr")
                        check(pp(rho_inv, pp(rho, p)) == p, "pp left inverse")
                        check(pp(rho, pp(rho_inv, p)) == p, "pp right inverse")
                    # 第二の準備: ip_ϱ = ν^{-1} ∘ pp_ϱ ∘ ν は全単射、ν(ip(r)) = pp(ν(r))
                    ip = [nu_inv[pp(rho, nu[r])] for r in range(N)]
                    check(sorted(ip) == list(range(N)), "ip is permutation")
                    for r in range(N):
                        check(nu[ip[r]] == pp(rho, nu[r]), "nu(ip(r)) = pp(nu(r))")
                    xv_d = [Xd[rho[kk]] for kk in range(d)]
                    def vs(P):
                        return ms(P, d, xv_d, Rd)
                    # 第三の準備の式鎖
                    for r in range(N):
                        i, j = nu[r]
                        ip_, jp_ = pp(rho, (i, j))
                        l1 = vs(ps[r])
                        l2 = vs(Xd[i]) + vs(Xd[j]) + vs(Rd(c)) * vs(Xd[i]) * vs(Xd[j])
                        l3 = Xd[rho[i]] + Xd[rho[j]] + Rd(c) * Xd[rho[i]] * Xd[rho[j]]
                        l4 = Xd[ip_] + Xd[jp_] + Rd(c) * Xd[ip_] * Xd[jp_]
                        l5 = ps[ip[r]]
                        check(l1 == l2 == l3 == l4 == l5, "prep3 chain")
                    # 第四の準備: ms_ps(X^{(N)}_{ip(r)}) = ps(ip(r))
                    for r in range(N):
                        check(ms(XN[ip[r]], N, ps, Rd) == ps[ip[r]], "prep4")
                    # 本体の式鎖
                    vs_ps = [vs(ps[r]) for r in range(N)]
                    ps_ip = [ps[ip[r]] for r in range(N)]
                    xv_N = [XN[ip[r]] for r in range(N)]
                    ms_xv = [ms(xv_N[r], N, ps, Rd) for r in range(N)]
                    v1 = vs(M)
                    v2 = ms(E, N, vs_ps, Rd)
                    v3 = ms(E, N, ps_ip, Rd)
                    v4 = ms(E, N, ms_xv, Rd)
                    vsE = ms(E, N, xv_N, RN) if N > 0 else E
                    v5 = ms(vsE, N, ps, Rd)
                    check(vsE == E, "es symmetric under ip")
                    v6 = ms(E, N, ps, Rd)
                    check(v1 == v2 == v3 == v4 == v5 == v6, "main chain")
                    check(v1 == M, "symmetric")
                # 部分体係数: c ∈ Q なら係数は Q、c ∈ Q(√2) なら係数は Q(√2)
                Tsum = Rd(0)
                for a, cf in (E.dict().items() if N > 0 else [((), E.constant_coefficient())]):
                    a = tuple(a) if N > 1 else ((a,) if not isinstance(a, tuple) else tuple(a))
                    T = Rd(cf) * prod((ps[r] ** a[r] for r in range(N)), Rd(1))
                    if c in QQ:
                        check(all(in_Q(t) for t in coeffs(T)), "T_a in Q[X]")
                    if in_Q_sqrt2(c):
                        check(all(in_Q_sqrt2(t) for t in coeffs(T)), "T_a in Q(sqrt2)[X]")
                    Tsum += T
                check(Tsum == M, "ms = sum T_a")
                if c in QQ:
                    check(all(in_Q(t) for t in coeffs(M)), "subfield coeff Q")
                if in_Q_sqrt2(c):
                    check(all(in_Q_sqrt2(t) for t in coeffs(M)), "subfield coeff Q(sqrt2)")

# 対照 1: c = ζ_8 ∉ Q(√2) なら、d = 2, k = 1 で係数 ζ_8 が Q(√2) に入らない
R2, X2 = ring(2)
M_ctrl = X2[0] + X2[1] + R2(z) * X2[0] * X2[1]
check(not all(in_Q_sqrt2(t) for t in coeffs(M_ctrl)), "control: subfield fails for c not in F")
# 対照 2: 対で対称でない値 X_i + 2 X_j を使うと、d = 3, k = 1 で対称でない
R3, X3 = ring(3)
bad = [X3[i] + 2 * X3[j] for (i, j) in pairs(3)]
E3, _ = es(3, 1)
Mb = ms(E3, 3, bad, R3)
check(Mb(X3[1], X3[0], X3[2]) != Mb, "control: asymmetric values break symmetry")

print("passes:", passes)
if failures:
    print("FAIL", len(failures), failures[:10])
else:
    print("PASS", passes)
