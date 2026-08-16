# 対象ラベル: def_rational_log_order_group_cauchy_sequence
# 帰属: ZZ / QQ と素因数分解、有限台辞書だけを使う厳密計算。浮動小数点は使わない
#       （定義は Λ_Q の加法・逆元・順序だけで書かれており、実数体は現れない）。
#
# 定義そのものは「任意の ε … ある N … すべての L,M」の形で普遍量化されており、有限回の計算で
# 確かめられるのは、ε・N・有限個の L,M を固定した各比較（決定手続き）と、具体的な列の例だけである。
# ここで確かめること:
#   (1) 決定手続き: −ε ≤_{Λ_Q} λ_L−λ_M ≤_{Λ_Q} ε の各比較が、def_rational_log_order_group_order の
#       正準の証人（N_λN_μ の証人 N_μλ_{N_λ}, N_λμ_{N_μ}）の Λ の比較（= 二つの正の有理数の比較）で決まること、
#       および「ある共通分母」形と「すべての共通分母（N ≤ 24）」形が一致すること。
#   (2) 定数列 λ_L = c は、任意の ε > 0 について N = 1 が証人になる（λ_L − λ_M = 0 で −ε ≤ 0 ≤ ε）。
#   (3) 列 λ_L = (1/L)·ι(ℓ_2) について、ε をいくつか取り、条件を満たす N を探索で見つけ、
#       N ≤ L, M ≤ N + 40 の範囲で二つの比較がすべて成り立つこと、および N を 1 にすると
#       条件を破る (L, M) が存在すること（N が ε に依存すること）を見る。
#   (4) 列 λ_L = L·ι(ℓ_2) について、ε = ι(ℓ_2) と N ≤ 30 のどの N についても、
#       N ≤ L, M で条件を破る (L, M)（L = N, M = N+2）が存在することを見る（Cauchy 列でない例）。
# 有限標本の検査であり、普遍量化された主張の証明ではない。


def lamq_add(lam_q, mu_q):
    # Λ_Q の加法（def_rational_log_order_group）。素数ごとに Q の加法。値 0 の素数は台から落とす
    out = dict(lam_q)
    for p, z in mu_q.items():
        out[p] = out.get(p, QQ(0)) + z
    return {p: z for p, z in out.items() if z != 0}


def lamq_neg(lam_q):
    # Λ_Q の逆元
    return {p: -z for p, z in lam_q.items()}


def lamq_sub(lam_q, mu_q):
    # λ − μ := λ + (−μ)
    return lamq_add(lam_q, lamq_neg(mu_q))


def qsmul(r, lam_q):
    # Λ_Q の有理数倍
    return {p: QQ(r) * z for p, z in lam_q.items() if r * z != 0}


def zsmul(n, lam):
    # Λ の整数倍
    return {p: ZZ(n) * z for p, z in lam.items() if n * z != 0}


def iota(lam):
    # ι_{Λ→Λ_Q}
    return {p: QQ(z) for p, z in lam.items()}


def rat_of_log(lam):
    # rat_Λ(λ) = ∏ p^{λ(p)} ∈ Q_{>0}（def_rational_of_log）
    r = QQ(1)
    for p, e in lam.items():
        r *= QQ(p) ** ZZ(e)
    return r


def log_order_le(lam, mu):
    # λ ≤_Λ μ :⟺ rat_Λ(λ) ≤ rat_Λ(μ)（def_log_order_group_order）
    return rat_of_log(lam) <= rat_of_log(mu)


def denominator_product(lam_q):
    # claim_common_denominator_exists の N_λ（空積は 1）
    N = ZZ(1)
    for v in lam_q.values():
        N *= v.denominator()
    return N


def witness_of_denominator_product(lam_q):
    # claim_common_denominator_exists の証人 λ_{N_λ}
    N = denominator_product(lam_q)
    nu = {}
    for p, v in lam_q.items():
        val = ZZ(N // v.denominator()) * ZZ(v.numerator())
        if val != 0:
            nu[p] = val
    return nu


def witnesses(lam_q, max_N):
    # λ の共通分母 N ≤ max_N とその一意な証人 λ_N
    out = {}
    for N in range(1, max_N + 1):
        scaled = qsmul(N, lam_q)
        if all(v.denominator() == 1 for v in scaled.values()):
            out[ZZ(N)] = {p: ZZ(v) for p, v in scaled.items()}
    return out


MAX_N_DENOM = 24
count_compare = 0


def rational_log_order_le(lam_q, mu_q):
    # def_rational_log_order_group_order の決定手続き（正準の証人の Λ の比較一度）。
    # 併せて「ある共通分母」形＝「すべての共通分母」形（N ≤ MAX_N_DENOM）であることも見る。
    global count_compare
    Nl, Nm = denominator_product(lam_q), denominator_product(mu_q)
    lam_M = zsmul(Nm, witness_of_denominator_product(lam_q))
    mu_M = zsmul(Nl, witness_of_denominator_product(mu_q))
    canonical = log_order_le(lam_M, mu_M)
    Wl, Wm = witnesses(lam_q, MAX_N_DENOM), witnesses(mu_q, MAX_N_DENOM)
    common = sorted(set(Wl) & set(Wm))
    if common:
        exists_form = any(log_order_le(Wl[N], Wm[N]) for N in common)
        forall_form = all(log_order_le(Wl[N], Wm[N]) for N in common)
        assert exists_form == forall_form == canonical
    count_compare += 1
    return canonical


def within_epsilon(diff, eps):
    # −ε ≤_{Λ_Q} diff ≤_{Λ_Q} ε
    return rational_log_order_le(lamq_neg(eps), diff) and rational_log_order_le(diff, eps)


def is_positive(eps):
    # 0 ≤_{Λ_Q} ε かつ ε ≠ 0
    return rational_log_order_le({}, eps) and eps != {}


ell = lambda p: {ZZ(p): QQ(1)}   # ι(ℓ_p)

# ε の標本（すべて 0 ≤ ε, ε ≠ 0 であることを確かめる）
epsilons = [
    ell(2),                                   # ι(ℓ_2)
    qsmul(QQ(1) / 3, ell(2)),                 # (1/3)·ι(ℓ_2)
    qsmul(QQ(1) / 7, ell(2)),                 # (1/7)·ι(ℓ_2)
    lamq_sub(ell(3), ell(2)),                 # ι(log(3/2)) = ι(ℓ_3) − ι(ℓ_2)
    qsmul(QQ(1) / 2, lamq_sub(ell(5), qsmul(2, ell(2)))),   # (1/2)·ι(log(5/4))
    lamq_sub(qsmul(QQ(3), ell(2)), qsmul(QQ(1) / 2, ell(7))),  # 3ι(ℓ_2) − (1/2)ι(ℓ_7)（8 > √7）
]
for eps in epsilons:
    assert is_positive(eps)
# 負や 0 は ε の資格が無いことも見る
assert not is_positive({})
assert not is_positive(lamq_neg(ell(2)))
assert not is_positive(lamq_sub(ell(2), ell(3)))

# (2) 定数列: N = 1 が証人。λ_L − λ_M = 0
const_value = lamq_add(qsmul(QQ(2) / 3, ell(2)), qsmul(QQ(-1) / 5, ell(3)))
count_const = 0
for eps in epsilons:
    for L in range(1, 8):
        for M in range(1, 8):
            diff = lamq_sub(const_value, const_value)
            assert diff == {}
            assert within_epsilon(diff, eps)
            count_const += 1

# (3) λ_L = (1/L)·ι(ℓ_2)
def seq_inv(L):
    return qsmul(QQ(1) / L, ell(2))

WINDOW = 40
count_inv = 0
found_N = []
for eps in epsilons:
    N_found = None
    for N in range(1, 200):
        ok = all(within_epsilon(lamq_sub(seq_inv(L), seq_inv(M)), eps)
                 for L in range(N, N + WINDOW + 1) for M in range(N, N + WINDOW + 1))
        if ok:
            N_found = N
            break
    assert N_found is not None
    found_N.append(N_found)
    count_inv += (WINDOW + 1) ** 2
    # N = 1 では条件を破る (L, M) がある（L = 1 と、範囲内のある M で破れる）
    if N_found > 1:
        assert any(not within_epsilon(lamq_sub(seq_inv(1), seq_inv(M)), eps)
                   for M in range(1, N_found + WINDOW + 1))
# 参考: ε = (1/3)ι(ℓ_2) では N = 3（|1/L − 1/M| ≤ 1/3 が L,M ≥ 3 で成り立つ）
assert found_N[1] == 3
assert found_N[2] == 7

# (4) λ_L = L·ι(ℓ_2) は Cauchy 列でない: ε = ι(ℓ_2) で、どの N ≤ 30 でも (L, M) = (N, N+2) が破る
count_lin = 0
for N in range(1, 31):
    diff = lamq_sub(qsmul(N, ell(2)), qsmul(N + 2, ell(2)))
    assert not within_epsilon(diff, ell(2))
    count_lin += 1

print("PASS: rational-log-order-group-cauchy-sequence (%d epsilons, %d constant-sequence checks, %d checks for (1/L)·ι(ℓ_2) with N=%s, %d non-Cauchy checks, %d order comparisons)"
      % (len(epsilons), count_const, count_inv, found_N, count_lin, count_compare))
