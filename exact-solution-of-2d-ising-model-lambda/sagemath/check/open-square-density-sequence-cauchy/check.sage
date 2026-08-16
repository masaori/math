# 対象ラベル: claim_open_square_density_sequence_cauchy_le_one
#
# 帰属: ZZ / QQ だけを使う厳密計算。浮動小数点は使わない（主張は Λ_Q で閉じている）。
# 有限標本での検査であり、普遍量化された主張そのものの証明ではない（それは本文の人手証明が担う）。
#
# 大きさについて: 核 Γ(q) は正なので Archimedes 性の倍率 n は 1 以上、したがって a = n+2 ≥ 3、N = a² ≥ 9 であり、
# 検査には一辺 9 以上の開境界正方形の分配関数の値 Z^op_{L,L}(q) ∈ QQ が要る。配位の全列挙（2^{81} 通り）は
# できないので、行ごとの動的計画法（行配位 2^L 通りに対し、行内の破れボンド数と隣接行間の破れボンド数で
# q の冪を掛けて足し上げる。配位の和を行の列で並べ替えただけの同じ和）で計算し、一辺 2, 3 では配位の全列挙と
# 一致することを確かめる。
# また Z^op_{L,L}(q) の素因数分解（数十桁の整数）は時間内に終わらないので、Λ_Q の元は「素数ごとの有理数」の
# 辞書ではなく「正の有理数の対数の有理数係数の形式和」（底 → 係数の辞書）で持ち、順序の判定は
# def_rational_log_order_group_order の手続きどおり、係数の分母の最小公倍数 N を掛けて Λ の証人へ戻し、
# rat_Λ（正の有理数の積、def_rational_of_log）の大小で比べる。rat_Λ が対数の和を積へ移すことは本文の主張である。
# 定数（ι(ℓ_2)・ι(log q)・ι(log(1+q))）については素数ごとの辞書と一致することも見る。
#
# 検査すること（claim_open_square_density_sequence_cauchy_le_one の証明の中身）:
#   準備の第一: 0 ≤ Γ(q)、Archimedes 性の倍率 n（Γ(q) ≤ n·ε となる最小の n を取る）、a := n+2、N := a²、
#               a ≥ 1、n ≤ a、a < a²、N ≥ 1。
#   準備の第二: N ≤ L, N ≤ M から a < L、a < M、a² ≤ L、a² ≤ M。
#   準備の第三: (1/a)·Γ(q) ≤ ε（claim_rational_log_order_group_div_ge_multiplier_le）。
#   上端: Ψ_L + (−Ψ_M) ≤ R_a（差の上からの評価）、R_a = (1/a)Γ(q)（核の等式）、≤ ε、結論 Ψ_L + (−Ψ_M) ≤ ε。
#   下端: −ε ≤ −((1/a)Γ(q))（逆元の順序反転）、= −R_a、≤ Ψ_L + (−Ψ_M)（差の下からの評価）、結論。

from itertools import product
import operator   # Sage の前処理は ^ を冪に変えるので、ビットの排他的論理和は operator.xor で書く
import time

# ---------- 開境界正方形の分配関数の値（QQ） ----------

def open_vertices(a, b):
    return [(i, j) for i in range(a) for j in range(b)]


def open_edges(a, b):
    horizontal = [('h', i, j) for i in range(a) for j in range(b - 1)]
    vertical = [('v', i, j) for i in range(a - 1) for j in range(b)]
    return horizontal + vertical


def endpoints(edge):
    direction, i, j = edge
    if direction == 'h':
        return (i, j), (i, j + 1)
    return (i, j), (i + 1, j)


def open_partition_value_bruteforce(L, q):
    # def_open_rectangle_partition_value_at_positive_rational を配位の全列挙で（一辺 3 まで）
    vertices = open_vertices(L, L)
    edges = [endpoints(e) for e in open_edges(L, L)]
    total = QQ(0)
    for values in product((ZZ(1), ZZ(-1)), repeat=len(vertices)):
        sigma = dict(zip(vertices, values))
        m = sum(ZZ(sigma[u] != sigma[v]) for u, v in edges)
        total += QQ(q) ** m
    return total


def open_partition_value_rows(L, q):
    # 同じ和を行ごとに並べ替えて計算する（行配位は L ビットの整数で持つ）
    q = QQ(q)
    states = list(range(2 ** L))
    def popcount(n):
        return bin(n).count('1')
    mask = (1 << (L - 1)) - 1
    intra = [popcount(operator.xor(s >> 1, s) & mask) for s in states]     # 行内の破れボンド数
    powers = [q ** k for k in range(2 * L + 1)]
    v = [powers[intra[s]] for s in states]                          # 第一行
    for _ in range(L - 1):
        w = []
        for t in states:
            acc = QQ(0)
            for s in states:
                acc += v[s] * powers[popcount(operator.xor(s, t))]              # 隣接行間の破れボンド数
            w.append(acc * powers[intra[t]])
        v = w
    total = sum(v, QQ(0))
    assert total > 0                                                # claim_open_rectangle_value_at_rational_is_positive
    return total


# ---------- Λ_Q の元（正の有理数の対数の有理数係数の形式和） ----------

def flog(b, c=QQ(1)):
    # c·ι(log b)（b ∈ QQ_{>0}、c ∈ QQ）
    assert QQ(b) > 0
    return {QQ(b): QQ(c)} if QQ(c) != 0 else {}


def fadd(x, y):
    out = dict(x)
    for b, c in y.items():
        out[b] = out.get(b, QQ(0)) + c
    return {b: c for b, c in out.items() if c != 0}


def fsmul(r, x):
    return {b: QQ(r) * c for b, c in x.items() if QQ(r) * c != 0}


def fneg(x):
    return {b: -c for b, c in x.items()}


def rat_of_witness(x, N):
    # N·x ∈ ι(Λ) の証人 λ_N の rat_Λ（正の有理数の積）
    r = QQ(1)
    for b, c in x.items():
        e = QQ(N) * c
        assert e.denominator() == 1
        r *= QQ(b) ** ZZ(e)
    return r


def flog_le(x, y):
    # def_rational_log_order_group_order の決定手続き
    N = ZZ(1)
    for c in list(x.values()) + list(y.values()):
        N = lcm(N, c.denominator())
    return rat_of_witness(x, N) <= rat_of_witness(y, N)


def feq(x, y):
    # Λ_Q の等号（両向きの ≤。順序は反対称なので等号と一致する）
    return flog_le(x, y) and flog_le(y, x)


def prime_dict(x):
    # 底が素因数分解できる元について、素数ごとの有理数の辞書（def_rational_log_order_group の表示）
    out = {}
    for b, c in x.items():
        for p, e in QQ(b).factor():
            out[ZZ(p)] = out.get(ZZ(p), QQ(0)) + c * e
    return {p: v for p, v in out.items() if v != 0}


# ---------- 検査 ----------

def check_cauchy(q, eps, sides):
    q = QQ(q)
    assert 0 < q <= 1
    checks = 0
    ell2 = flog(2)                          # ι(ℓ_2)
    log_1q = flog(1 + q)                    # ι(log(1+q))
    log_q = flog(q)                         # ι(log q)
    zero = {}
    # 核 Γ(q)（def_open_square_density_difference_bound_core）
    X = fadd(fsmul(2, ell2), fsmul(4, log_1q))
    Y = fsmul(4, log_q)
    C = fadd(ell2, fsmul(2, log_1q))
    Gamma = fadd(fadd(X, fneg(Y)), fsmul(2, C))
    # 定数の表示が素数ごとの辞書と一致すること
    assert prime_dict(Gamma) == prime_dict(fadd(fadd(fsmul(4, ell2), fsmul(8, log_1q)), fsmul(-4, log_q)))
    checks += 1

    # 準備の第一
    assert flog_le(zero, eps) and not feq(zero, eps)                    # 0 ≤ ε、ε ≠ 0
    assert flog_le(zero, Gamma)                                         # claim_open_square_density_difference_bound_core_nonneg_le_one
    n = 0
    while not flog_le(Gamma, fsmul(n, eps)):                            # claim_rational_log_order_group_archimedean の倍率（最小のもの）
        n += 1
        assert n < 10 ** 4
    a = n + 2
    N = a ** 2
    assert a >= 1 and n <= a and a < a ** 2 and N >= 1
    checks += 4

    # 準備の第三: (1/a)·Γ ≤ ε
    inv_a_Gamma = fsmul(QQ(1) / QQ(a), Gamma)
    assert flog_le(inv_a_Gamma, eps)
    checks += 1

    # R_a（差の一様な評価の右辺）と核の等式
    U = fadd(fsmul(QQ(2) / a, ell2), fsmul(QQ(4) / a, log_1q))
    D = fsmul(QQ(4) / a, log_q)
    R = fadd(fadd(U, fneg(D)), fsmul(QQ(2) / a, C))
    assert feq(inv_a_Gamma, R)                                          # claim_open_square_density_difference_bound_is_core_over_base_side
    checks += 1

    # 密度 Ψ^op_L(q)（L ∈ sides、すべて N 以上であること）
    psi = {}
    for L in sides:
        assert N <= L
        Z = open_partition_value_rows(L, q)
        psi[L] = fsmul(QQ(1) / QQ(L ** 2), flog(Z))
    for L in sides:
        for M in sides:
            # 準備の第二
            assert a < L and a < M and a ** 2 <= L and a ** 2 <= M
            diff = fadd(psi[L], fneg(psi[M]))
            # 上端
            assert flog_le(diff, R)                                     # claim_open_square_large_sides_density_difference_upper_le_one
            assert flog_le(diff, eps)                                   # 結論
            # 下端
            assert flog_le(fneg(eps), fneg(inv_a_Gamma))                # claim_rational_log_order_group_neg_reverses_order
            assert feq(fneg(inv_a_Gamma), fneg(R))
            assert flog_le(fneg(R), diff)                               # claim_open_square_large_sides_density_difference_lower_le_one
            assert flog_le(fneg(eps), diff)                             # 結論
            checks += 7
    return checks, n, a, N


t0 = time.time()
# 行ごとの計算が配位の全列挙と一致すること（一辺 2, 3）
for L in (2, 3):
    for q in (QQ(1), QQ(1) / 2, QQ(2) / 3):
        assert open_partition_value_rows(L, q) == open_partition_value_bruteforce(L, q)
print("rows == bruteforce for L=2,3: OK")

total = 0
# ε は核より大きめに取り、倍率 n = 1、a = 3、N = 9 になる標本（一辺 9, 10 の分配関数を計算する）
cases = [
    (QQ(1), flog(2, 12)),            # q=1: Γ(1) = 12ι(ℓ_2)。ε := 12ι(ℓ_2) で n = 1
    (QQ(1) / 2, flog(2, 30)),        # q=1/2: Γ(1/2) = 8ι(ℓ_3)。ε := 30ι(ℓ_2) で n = 1
    (QQ(2) / 3, flog(2, 40)),        # q=2/3: ε := 40ι(ℓ_2) で n = 1
]
for q, eps in cases:
    c, n, a, N = check_cauchy(q, eps, sides=(9, 10))
    print(f"q={q}: n={n}, a={a}, N={N}, checks={c}")
    total += c
print(f"ALL PASS: {total} checks, {time.time() - t0:.1f}s")
