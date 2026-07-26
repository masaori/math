# cycle 13 / T1 step 3: 観察 T の証明の各ステップを機械照合する
#
# README §2 の証明は「数値一致」ではなく完全な演繹である。本スクリプトは
# その各補題が主張どおりの等式・整除・既約性を与えているかを、有限個の L で
# 実際に計算して確認する（＝証明の書き写しミスを検出するための照合であって、
# 証明の代用ではない）。
#
# 証明の骨格（奇数 L, h := (L-1)/2）:
#   L1  f_L(x) = (x-2) m_L(x)^2 ,  m_L in ZZ[x] monic, deg m_L = h
#   L2  m_L(2) = L ,  m_L(0) = ±1
#   L3  tau(L) = L^2 * R^4 ,  R := Res(m_L(x), m_L(4-x)) in ZZ
#   L4  m_L(4-x) ≡ m_L(x)  (mod 2) in ZZ[x] ; D := (m_L(4-x) - m_L(x))/2 in ZZ[x]
#   L5  D ≡ x * (m_L mod 2)'  (mod 2)
#   L6  disc(m_L) は奇数（⇔ m_L mod 2 が分離的 ⇔ gcd(m̄, m̄')=1）
#   L7  ⇒ v_2(R) = h,  よって v_2(tau(L)) = 4h = 2(L-1)
#
# 実行: sage tau_v2_proof_check.sage

R.<x> = ZZ[]
F2 = GF(2)['y']
y = F2.gen()

def p_seq(n):
    a, b = R(2), x
    if n == 0:
        return a
    for _ in range(n - 1):
        a, b = b, x * b - a
    return b

def f_poly(L):
    return p_seq(L) - 2

def tau_res(L):
    f = f_poly(L)
    q = f // (x - 2)
    return q.resultant(R(f(4 - x)))

def mod2(p):
    return F2([ZZ(c) % 2 for c in p.list()])


print("=" * 78)
print("奇数 L に対する証明ステップの機械照合（L = 3,5,...,81）")
print("=" * 78)
print()
hdr = "  L   L1  L2:m(2),m(0)      L3         L4  L5  L6:disc奇  L7: v2(R)=h  v2(tau)=2(L-1)"
print(hdr)
print("  " + "-" * (len(hdr) - 2))

for L in range(3, 82, 2):
    L = ZZ(L)
    h = (L - 1) // 2
    f = f_poly(L)

    # --- L1: f_L = (x-2) m_L^2 -----------------------------------------
    q = f // (x - 2)
    assert q * (x - 2) == f
    m = q.sqrt()
    L1 = (m * m == q) and (f == (x - 2) * m ** 2) and m.is_monic() and m.degree() == h

    # --- L2: m_L(2) = L, m_L(0) = ±1 -----------------------------------
    L2 = (m(2) == L) and (m(0) in (1, -1))

    # --- L3: tau(L) = L^2 R^4 ------------------------------------------
    Rres = m.resultant(R(m(4 - x)))
    L3 = (tau_res(L) == L ** 2 * Rres ** 4)

    # --- L4: m_L(4-x) = m_L(x) + 2 D(x), D in ZZ[x] --------------------
    diff = R(m(4 - x)) - m
    L4 = all(ZZ(c) % 2 == 0 for c in diff.list())
    D = diff // 2
    assert 2 * D == diff

    # --- L5: D ≡ x * m̄'  (mod 2) ---------------------------------------
    mb = mod2(m)
    L5 = (mod2(D) == y * mb.derivative())

    # --- L6: disc(m_L) odd  ⇔  gcd(m̄, m̄') = 1 --------------------------
    L6 = (ZZ(m.discriminant()) % 2 == 1) and (gcd(mb, mb.derivative()) == 1)

    # --- L7: conclusion -------------------------------------------------
    vR = ZZ(Rres).valuation(2)
    vt = ZZ(tau_res(L)).valuation(2)
    L7 = (vR == h) and (vt == 2 * (L - 1))

    assert L1 and L2 and L3 and L4 and L5 and L6 and L7, ("FAILED at L=%d" % L)
    if L <= 21 or L % 20 == 1:
        print("  %2d   OK  m(2)=%2d, m(0)=%2d   OK(L^2R^4)  OK  OK  OK        %3d = %3d   %4d = %4d"
              % (L, m(2), m(0), vR, h, vt, 2 * (L - 1)))

print()
print("  L=3,5,...,81 の全 40 個で L1–L7 が全て成立（assert 通過）。")

print()
print("=" * 78)
print("補足: 証明で使う 2 つの整数論的事実の確認")
print("=" * 78)
print()
print("  (i)  prod_{k=1}^{L-1} (2 - zeta_L^k - zeta_L^{-k}) = L^2   [これが m_L(2)^2 = L^2]")
for L in [3, 5, 7, 9, 15, 21, 25]:
    K.<zt> = CyclotomicField(L)
    val = prod(2 - zt ** k - zt ** (-k) for k in range(1, L))
    print("       L=%2d : %s  (= L^2 = %d)  %s" % (L, val, L ** 2, val == L ** 2))
print()
print("  (ii) prod_{k=1}^{L-1} (1 + zeta_L^k) = 1  [これが m_L(0)^2 = 1]")
for L in [3, 5, 7, 9, 15, 21, 25]:
    K.<zt> = CyclotomicField(L)
    val = prod(1 + zt ** k for k in range(1, L))
    print("       L=%2d : %s" % (L, val))

print()
print("=" * 78)
print("偶数 L: 同じ分解を実行したところ（観察 T' の部分還元。証明ではない）")
print("=" * 78)
print()
print("  偶数 L では f_L(x) = (x-2)(x+2) n_L(x)^2, deg n_L = L/2 - 1 となり、")
print("  tau(L) = (L^2 P_L^4 / 2) * S^4,  S := Res(n_L(x), n_L(4-x)),  P_L = Pell 数")
print("  が成り立つ（下で確認）。したがって")
print("      v_2(tau(L)) = 2 v_2(L) + 4 v_2(P_L) - 1 + 4 v_2(S)")
print("  であり、v_2(P_L) = v_2(L)（L 偶数, 下で確認）を使うと 6s - 1 + 4 v_2(S)。")
print("  観察 T' が成り立つことは v_2(S) = (s+2)L/2 - 3s と同値。")
print("  この最後の等式は本セッションでは証明していない（奇数の場合の L4–L6 に相当する")
print("  議論が偶数では通らない: 2 進的な相殺が 1 回で止まらない）。")
print()
Pell = [ZZ(0), ZZ(1)]
for i in range(2, 300):
    Pell.append(2 * Pell[-1] + Pell[-2])
print("  L   s  v2(P_L)  tau==(L^2 P_L^4/2)S^4   v2(S)   (s+2)L/2-3s")
for L in range(2, 41, 2):
    L = ZZ(L)
    s = L.valuation(2)
    f = f_poly(L)
    q = (f // (x - 2)) // (x + 2)
    assert q * (x - 2) * (x + 2) == f
    n = q.sqrt()
    assert n * n == q
    S = n.resultant(R(n(4 - x)))
    lhs = tau_res(L)
    rhs = (L ** 2 * Pell[L] ** 4) / 2 * S ** 4
    vS = ZZ(S).valuation(2)
    print("  %3d %2d    %2d        %-8s              %4d      %4d"
          % (L, s, Pell[L].valuation(2), lhs == rhs, vS, (s + 2) * L / 2 - 3 * s))
