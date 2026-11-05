# 対象ラベル: product_of_real_entry_matrices_has_real_entries
# 人手証明の鎖 (AB)_ik = Σ_j A_ijB_jk = Σ_j (s_j)_C(t_j)_C = Σ_j (s_jt_j)_C = (Σ_j s_jt_j)_C を、
# A, B の成分 s_ij, t_jk を QQ 上の不定元として、m, n, p = 1..3 の全成分 (i, k) で 1 行ずつ確かめる。
# 複素数は definition_of_cc のとおり実数の組で組み（共通の準備 complex_as_real_pairs.sage）、ℂ の有限和は
# def_finite_sum_of_complex_numbers、ℝ の有限和は def_finite_sum_of_real_numbers のとおり左から足す。
load("../../_shared/complex_as_real_pairs.sage")
set_random_seed(20261104)

steps = 0


def eq(a, b, what):
    global steps
    assert a == b, what
    steps += 1


def cc_sum(terms):
    """def_finite_sum_of_complex_numbers: Σ_{j=1}^{1} := z_1、Σ_{j=1}^{r+1} := (Σ_{j=1}^{r}) + z_{r+1}。"""
    S = terms[0]
    for z in terms[1:]:
        S = cc_add(S, z)
    return S


def rr_sum(terms):
    """def_finite_sum_of_real_numbers（左から足す）。"""
    S = terms[0]
    for r in terms[1:]:
        S = S + r
    return S


for m in range(1, 4):
    for n in range(1, 4):
        for p in range(1, 4):
            names = [f"s_{i}_{j}" for i in range(m) for j in range(n)] + [f"t_{j}_{k}" for j in range(n) for k in range(p)]
            P = PolynomialRing(QQ, names)
            g = P.gens()
            s = {(i, j): g[i * n + j] for i in range(m) for j in range(n)}
            t = {(j, k): g[m * n + j * p + k] for j in range(n) for k in range(p)}
            A = {(i, j): (s[(i, j)], P(0)) for i in range(m) for j in range(n)}   # A の成分（実数の組。虚部 0）
            B = {(j, k): (t[(j, k)], P(0)) for j in range(n) for k in range(p)}
            for i in range(m):
                for k in range(p):
                    w = f"m={m},n={n},p={p},(i,k)=({i},{k})"
                    for j in range(n):
                        eq(A[(i, j)], iota(s[(i, j)], P), f"{w}: A_ij = (s_j)_C")
                        eq(B[(j, k)], iota(t[(j, k)], P), f"{w}: B_jk = (t_j)_C")
                        # real_inclusion_preserves_product を各項で: 積は definition_of_cc の積、右辺は ℝ の積の像
                        eq(cc_mul(iota(s[(i, j)], P), iota(t[(j, k)], P)), iota(s[(i, j)] * t[(j, k)], P), f"{w}: 積の像 j={j}")
                    L = [cc_sum([cc_mul(A[(i, j)], B[(j, k)]) for j in range(n)]),                 # mat_mult
                         cc_sum([cc_mul(iota(s[(i, j)], P), iota(t[(j, k)], P)) for j in range(n)]),
                         cc_sum([iota(s[(i, j)] * t[(j, k)], P) for j in range(n)]),
                         iota(rr_sum([s[(i, j)] * t[(j, k)] for j in range(n)]), P)]
                    for a, b in zip(L, L[1:]):
                        eq(a, b, f"{w}: 鎖")
                    eq(L[0][1], P(0), f"{w}: 虚部は 0")
            # 比べる側（別の経路）: Sage の QQ(i) の行列積に具体の有理数を入れ、成分の虚部が 0 で、実部が鎖の最後の行の実数と一致
            K.<I> = QuadraticField(-1)
            vals = [QQ(randint(-9, 9)) / randint(1, 5) for _ in g]
            sub = {g[q]: vals[q] for q in range(len(g))}
            Ak = matrix(K, m, n, [vals[i * n + j] for i in range(m) for j in range(n)])
            Bk = matrix(K, n, p, [vals[m * n + j * p + k] for j in range(n) for k in range(p)])
            C = Ak * Bk
            for i in range(m):
                for k in range(p):
                    eq(C[i, k].imag(), 0, "組み込みの積の虚部")
                    eq(rr_sum([s[(i, j)] * t[(j, k)] for j in range(n)]).subs(sub), C[i, k].real(), "鎖の実数と組み込みの積の実部")

# 否定コントロール: A の成分の一つを虚部 1 の (s, 1) に替えると、積の成分の虚部が 0 でない（仮定「成分が実」が効いている）
P1.<s0, t0> = PolynomialRing(QQ)
bad = cc_mul((s0, P1(1)), iota(t0, P1))
assert bad[1] == t0 and bad[1] != 0
print(f"  {steps} 段（m, n, p = 1..3 の全成分、不定元 s_ij, t_jk。実数の組で組んだ ℂ の厳密計算と、QQ(i) の組み込みの積との比較）")
print("  否定コントロール 1 件: A の成分の虚部を 1 にすると積の成分の虚部が t になる")
print("RESULT: PASS")
