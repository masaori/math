# 節「根の対の整数倍のずらしを根とする多項式」の三つの主張の式鎖を一行ずつ確かめる。
# 対象ラベル: claim_qbar_multivariate_point_value_of_substitution,
#             claim_subfield_coefficient_multivariate_point_value_mem,
#             claim_pair_shift_root_polynomial_subfield_coefficient
# 帰属: 係数は円分体 Q(ζ_8)（代数的数の部分体）の元と、Q 上の x^3 - 2 の分解体（数体）の元。
# 部分体 F は Q と Q(√2) = Q(ζ_8 + ζ_8^{-1})。浮動小数点は使わない。
import itertools

failures = []
passes = 0
def check(cond, msg):
    global passes
    if not cond:
        failures.append(msg)
    else:
        passes += 1

def subsets(m, i):
    return [S for S in itertools.combinations(range(m), i)]

def pairs(d):
    return [(i, j) for i in range(d) for j in range(d) if i < j]

class Setting:
    def __init__(self, K, inF, name):
        self.K, self.inF, self.name = K, inF, name
        self.T = PolynomialRing(K, 't')
    def ring(self, m):
        if m == 0:
            return PolynomialRing(self.K, 'W', 1), []
        R = PolynomialRing(self.K, ['X%d' % k for k in range(m)])
        return R, list(R.gens())
    def terms(self, P, m):
        # (指数 a, 係数 mco_a(P)) の一覧（係数が零でないもの）
        if m == 0:
            c = P.constant_coefficient()
            return [((), c)] if c != 0 else []
        out = []
        for a, cf in P.dict().items():
            a = tuple(a) if m > 1 else ((a,) if not isinstance(a, tuple) else tuple(a))
            out.append((a, cf))
        return out
    def mev(self, P, m, alpha):
        # 定義どおりの点での値 Σ_a mco_a(P) ∏_k α(k)^{a(k)}
        return sum((cf * prod((alpha[k] ** a[k] for k in range(m)), self.K(1))
                    for a, cf in self.terms(P, m)), self.K(0))
    def ms(self, P, m, values, Rt):
        return sum((Rt(cf) * prod((values[k] ** a[k] for k in range(m)), Rt(1))
                    for a, cf in self.terms(P, m)), Rt(0))
    def es(self, m, i):
        R, X = self.ring(m)
        return sum((prod((X[k] for k in S), R(1)) for S in subsets(m, i)), R(0))
    def in_F_poly(self, P, m):
        return all(self.inF(cf) for _, cf in self.terms(P, m))
    def symmetric_Q(self, P, d):
        # P = se_d(Q) を満たす Q を Sage の対称関数で求める（d ≥ 1 のとき）
        R, X = self.ring(d)
        if d <= 1:
            # 零変数・一変数では es_{1,1} = X_0 なので Q = P
            return P
        Sym = SymmetricFunctions(self.K)
        e = Sym.e(); mbasis = Sym.m()
        f = e(mbasis.from_polynomial(P))
        Q = R(0)
        for lam, cf in f:
            if any(part > d for part in lam):
                # d 変数では e_{>d} = 0 なので寄与しない
                continue
            Q += cf * prod((X[part - 1] for part in lam), R(1))
        return Q

def run_setting(S, root_lists, cs):
    K, T = S.K, S.T
    t = T.gen()
    # 代入してから値を取る主張（一般の P・y・α）
    for n_, m_ in [(1, 1), (2, 2), (3, 2), (2, 3)]:
        Rn, Xn = S.ring(n_); Rm, Xm = S.ring(m_)
        P = sum(Xn) ** 2 + 3 * prod(Xn) + K(1) / 2
        y = [Xm[(k + 1) % m_] ** 2 - 2 * Xm[k % m_] + K(k) for k in range(n_)]
        alpha = [K(k + 2) / 3 for k in range(m_)]
        lhs = S.mev(S.ms(P, n_, y, Rm), m_, alpha)
        # 第一の等号: 代入の定義の有限和
        line1 = S.mev(sum((Rm(cf) * prod((y[k] ** a[k] for k in range(n_)), Rm(1))
                           for a, cf in S.terms(P, n_)), Rm(0)), m_, alpha)
        # 第二の等号: 値は和・積・冪を保つ
        line2 = sum((S.mev(Rm(cf), m_, alpha) * prod((S.mev(y[k], m_, alpha) ** a[k] for k in range(n_)), K(1))
                     for a, cf in S.terms(P, n_)), K(0))
        # 第三の等号: 定数の値
        line3 = sum((cf * prod((S.mev(y[k], m_, alpha) ** a[k] for k in range(n_)), K(1))
                     for a, cf in S.terms(P, n_)), K(0))
        rhs = S.mev(P, n_, [S.mev(y[k], m_, alpha) for k in range(n_)])
        check(lhs == line1 == line2 == line3 == rhs, "%s 代入してから値 n=%d m=%d" % (S.name, n_, m_))
        if m_ >= 1:
            check(S.mev(Xm[0], m_, alpha) == alpha[0], "%s 変数の値" % S.name)
    for roots, f_in_F in root_lists:
        d = len(roots)
        alpha = list(roots)
        f = prod((t - a for a in alpha), T(1))
        check(all(S.inF(cf) for cf in f.list()) == f_in_F, "%s f の係数の所属の前提 d=%d" % (S.name, d))
        Rd, Xd = S.ring(d)
        # 第二の準備: mev(es_{d,i+1}) = (-1)^{i+1} ac_{d-i-1}(f)、F に入る
        gamma = []
        for i in range(d):
            v = S.mev(S.es(d, i + 1), d, alpha)
            check(v == (-1) ** (i + 1) * f[d - i - 1], "%s 第二の準備の等式 d=%d i=%d" % (S.name, d, i))
            if f_in_F:
                check(S.inF(v), "%s 第二の準備の所属 d=%d i=%d" % (S.name, d, i))
            gamma.append(v)
        P_list = pairs(d)
        N = len(P_list)
        for nu in [P_list, list(reversed(P_list))]:
            for c in cs:
                ps = [Xd[i] + Xd[j] + Rd(c) * Xd[i] * Xd[j] for (i, j) in nu]
                beta = [alpha[i] + alpha[j] + c * alpha[i] * alpha[j] for (i, j) in nu]
                # 第一の準備
                for r in range(N):
                    check(S.mev(ps[r], d, alpha) == beta[r], "%s 第一の準備 d=%d r=%d" % (S.name, d, r))
                g = prod((t - b for b in beta), T(1))
                # 番号が N より大きい係数は零
                for mm in range(N + 1, N + 3):
                    check(g[mm] == 0, "%s 上界 d=%d" % (S.name, d))
                for k in range(N + 1):
                    esN = S.es(N, k)
                    msps = S.ms(esN, N, ps, Rd)
                    Q = S.symmetric_Q(msps, d)
                    seQ = S.ms(Q, d, [S.es(d, i + 1) for i in range(d)], Rd)
                    l0 = g[N - k]
                    l1 = (-1) ** k * S.mev(esN, N, beta)                       # Vieta
                    l2 = (-1) ** k * S.mev(esN, N, [S.mev(ps[r], d, alpha) for r in range(N)])  # 第一の準備
                    l3 = (-1) ** k * S.mev(msps, d, alpha)                     # 代入してから値
                    l4 = (-1) ** k * S.mev(seQ, d, alpha)                      # 対称式の基本定理
                    l6 = (-1) ** k * S.mev(Q, d, gamma)                        # 代入してから値
                    check(l0 == l1 == l2 == l3 == l4 == l6,
                          "%s 式鎖 d=%d c=%s k=%d" % (S.name, d, c, k))
                    check(msps == seQ, "%s P = se_d(Q) d=%d k=%d" % (S.name, d, k))
                    if f_in_F and S.inF(c):
                        check(S.in_F_poly(Q, d), "%s Q の係数の所属 d=%d k=%d" % (S.name, d, k))
                        # 値の所属の主張: 各項と和
                        for a, cf in S.terms(Q, d):
                            check(S.inF(cf * prod((gamma[i] ** a[i] for i in range(d)), K(1))),
                                  "%s 値の項の所属" % S.name)
                        check(S.inF(l6), "%s 係数の所属 d=%d k=%d" % (S.name, d, k))
                if f_in_F and S.inF(c):
                    check(all(S.inF(cf) for cf in g.list()), "%s 主張 d=%d c=%s" % (S.name, d, c))

# Q(ζ_8) の中で F = Q(√2)、F = Q
K8.<z> = CyclotomicField(8)
sqrt2 = z + z^(-1)
conj = K8.hom([z^(-1)])
S1 = Setting(K8, lambda a: conj(a) == a, "Q(√2)")
roots1 = [
    ([], True),
    ([sqrt2], True),
    ([z, z^7], True),                 # t^2 - √2 t + 1
    ([z, z^7, z^3, z^5], True),       # t^4 + 1
    ([z^3, z^5, K8(1)/2], True),
    ([z, z^3], False),                # 対照: 共役で閉じない根
]
run_setting(S1, roots1, [K8(0), K8(1), K8(-2), K8(1)/3, sqrt2])
S2 = Setting(K8, lambda a: a in QQ, "Q")
roots2 = [
    ([z, z^3, z^5, z^7], True),       # t^4 + 1
    ([z^2, z^6], True),               # t^2 + 1
    ([sqrt2, -sqrt2, K8(3)], True),
    ([sqrt2], False),                 # 対照
]
run_setting(S2, roots2, [K8(0), K8(1), K8(-2), K8(1)/3])

# x^3 - 2 の分解体（Q 上の非可換な Galois 群）で F = Q
x = polygen(QQ)
L.<u> = (x^3 - 2).splitting_field()
rts = [r for r, _ in (x^3 - 2).roots(L)]
S3 = Setting(L, lambda a: a in QQ, "Q（x^3-2 の分解体）")
run_setting(S3, [(rts, True), (rts[:2], False)], [L(0), L(1), L(-3)])

# 対照: c が F に入らないと主張は成り立たない（d = 2 で g = t - (α0+α1+cα0α1)）
g_bad = S1.T.gen() - (z + z^7 + z * z * z^7)
check(not all(S1.inF(cf) for cf in g_bad.list()), "対照 c = ζ_8 で Q(√2) 係数にならない")

print("PASS", passes)
if failures:
    print("FAIL", len(failures))
    for m in failures[:20]:
        print(" ", m)
    raise SystemExit(1)
