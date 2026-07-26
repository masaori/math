# cycle 14 / T1: 2 変数 P の Z_p^2 塔での v_p(a_{p^n}) — 非自明性判定の検証
#
# a_L := prod_{z^L=1, w^L=1} P(z,w) = Res_z(z^L-1, Res_w(w^L-1, P))   (両者モニックなので厳密)
#
# 本スクリプトは次を検証する。
#   (1) 判定式: v_p(a_{p^n}) > 0  <=>  p | P(1,1)   (全 n>=0)
#   (2) 1 変数の判定式 mu_ell = v_ell(content) が d=2 では成立しないこと(content=1 でも増大する例)
#   (3) Deninger の条件(P mod p が単項式)より本判定式の方が真に鋭いこと
#   (4) 増大の形が DuBose-Vallieres Thm A の P(ell^n, n) 型(総次数<=2, n について次数<=1)に
#       当てはまるか(数値フィット。証明ではない)

print("=" * 92)
print("cycle 14 / T1: 2 変数 P の Z_p^2 塔での v_p(a_{p^n})")
print("=" * 92)

R.<z, w> = ZZ[]

def a_L(P, L):
    """a_L = prod_{z^L=1,w^L=1} P(z,w) を終結式で厳密整数計算する。"""
    Rw.<W> = PolynomialRing(PolynomialRing(ZZ, 'Z'))
    Z = Rw.base_ring().gen()
    Q = (W**L - 1).resultant(P.subs({z: Z, w: W}))
    Zt.<t> = PolynomialRing(ZZ)
    return ZZ((t**L - 1).resultant(Zt(Q)))

def content(P):
    return gcd([ZZ(c) for c in P.coefficients()])

def mod_p_is_monomial(P, p):
    """P mod p が (定数)×(単項式) か。= Deninger arXiv:math/0608539 Prop 2.4 c) の条件。"""
    nz = [c for c in P.coefficients() if ZZ(c) % p != 0]
    return len(nz) == 1

# (z,w) を消して Laurent を多項式にしたものを使う。torus 上の積は単数倍しか変わらない
# (prod_{z^L=1} z = (-1)^(L+1) を L^2 個掛けると平方になり 1)。
CASES = [
    ("5-(z+1/z)-(w+1/w) [xzw]", 5*z*w - z^2*w - w - z*w^2 - z),
    ("2*(上)",                   2*(5*z*w - z^2*w - w - z*w^2 - z)),
    ("4*(上)",                   4*(5*z*w - z^2*w - w - z*w^2 - z)),
    ("3 - z - w",                3 - z - w),
    ("6 - z - w",                6 - z - w),
    ("2 + z + w",                2 + z + w),
    ("1 + z + 2w",               1 + z + 2*w),
    ("3 + z + w",                3 + z + w),
    ("5 + z + w",                5 + z + w),
    ("2 + 3z + 3w",              2 + 3*z + 3*w),
    ("1 + 2z + 4w",              1 + 2*z + 4*w),
    ("3 + 3z + w",               3 + 3*z + w),
    ("7 - 2z - 2w",              7 - 2*z - 2*w),
    ("9 - z - w",                9 - z - w),
    ("4 - z - 2w",               4 - z - 2*w),
    ("2zw (Deninger 条件を満たす)", 2*z*w),
    ("6zw",                      6*z*w),
]
PRIMES = [2, 3, 5, 7]

print()
print("--- (1) 判定式: v_p(a_{p^n}) > 0  <=>  p | P(1,1) ---")
print("  根拠(証明は report §3, 補題 V0): mod p では z^(p^n)-1 = (z-1)^(p^n) なので終結式が潰れて")
print("  a_{p^n} ≡ P(1,1)^(p^(2n)) (mod p)。ゆえに p ∤ P(1,1) なら a は p で割れず v_p=0、")
print("  p | P(1,1) なら a ≡ 0 で v_p ≥ 1。代数的整数論も p 進体も使わない。")
print()
print("%-26s %8s %8s %5s %-9s %s" % ("P", "P(1,1)", "content", "p", "p|P(1,1)?", "v_p(a_{p^n}) n=0,1,2,..."))
bad = 0
records = {}
for name, P in CASES:
    P11 = ZZ(P.subs({z: 1, w: 1}))
    c = content(P)
    for p in PRIMES:
        vals = []
        degen = False
        for n in range(0, 4):
            L = p**n
            if L**2 > 300:
                break
            v = a_L(P, L)
            if v == 0:
                degen = True
                vals.append("deg")
            else:
                vals.append(ZZ(v).valuation(p))
        divides = (P11 != 0 and P11 % p == 0)
        # 判定式の検査(退化していない段のみ)
        nums = [x for x in vals if x != "deg"]
        if nums:
            pos = any(x > 0 for x in nums)
            allzero = all(x == 0 for x in nums)
            ok = (pos == divides) if not degen else (True if divides or allzero else False)
            if not ok:
                bad += 1
                mark = "  <== 判定式に反する"
            else:
                mark = ""
        else:
            mark = "  (全段退化)"
        records[(name, p)] = vals
        print("%-26s %8s %8s %5d %-9s %s%s"
              % (name, P11, c, p, "yes" if divides else "no", vals, mark))
print()
print("判定式に反した組: %d 件" % bad)

print()
print("--- (2) 1 変数の判定式 mu = v_p(content) は d=2 では成立しない ---")
print("  content=1(=> 1 変数なら mu=0)なのに v_p(a_{p^n}) が増大する例:")
found = 0
for name, P in CASES:
    if content(P) != 1:
        continue
    P11 = ZZ(P.subs({z: 1, w: 1}))
    for p in PRIMES:
        vals = records.get((name, p), [])
        nums = [x for x in vals if x != "deg"]
        if len(nums) >= 2 and nums[-1] > nums[0] and nums[-1] > 0:
            found += 1
            print("    P=%-22s content=1, p=%d: v_p(a_{p^n}) = %s  (P(1,1)=%s)"
                  % (name, p, vals, P11))
print("  該当 %d 件。=> content は d=2 の増大を支配しない(cycle 13 の (☆) は d=1 限定)。" % found)

print()
print("--- (3) Deninger の条件(P mod p が単項式)との比較 ---")
print("  Deninger arXiv:math/0608539 Thm 1.1 の仮定は「P が p 進トーラス上に零点をもたない」で、")
print("  Prop 2.4 c) より「P mod p が (定数)×(単項式)」と同値。これは v_p ≡ 0 の十分条件だが")
print("  必要条件ではない。本判定式(p ∤ P(1,1))の方が真に鋭いことを示す例:")
sharper = 0
for name, P in CASES:
    P11 = ZZ(P.subs({z: 1, w: 1}))
    for p in PRIMES:
        if P11 == 0:
            continue
        mono = mod_p_is_monomial(P, p)
        divides = (P11 % p == 0)
        vals = records.get((name, p), [])
        nums = [x for x in vals if x != "deg"]
        if (not mono) and (not divides) and nums and all(x == 0 for x in nums):
            sharper += 1
            print("    P=%-22s p=%d: P mod p は単項式でない(Deninger 不適用)が P(1,1)=%s は p で割れず v_p≡0"
                  % (name, p, P11))
print("  該当 %d 件。=> Deninger の条件は十分だが必要でない。" % sharper)

print()
print("--- (4) 増大の形(DuBose-Vallieres Thm A の P(ell^n, n) 型か) ---")
print("  総次数<=2, n について次数<=1 なので a X^2 + b X Y + c X + d Y + e (X=p^n, Y=n)。")
print("  4 段しか取れない場合は未知数 5 個に対し方程式 4 本で一意に定まらない。")
print("  ここでは a=0(content=1 なので X^2 項なしと仮定)として b,c,d,e を解き、整合を見るだけ。")
print("  **これはフィットであって証明ではない。**")
print("  **重要**: 4 段だけのフィットは誤る。実際 P=6-z-w, p=2 を n<=3 の 4 段で解くと")
print("  2n2^n-4*2^n+5n+6 が得られるが、n=4,5 の真値 86,199 に対しこの式は 90,223 を与えて外れる。")
print("  以下は n<=5 の 6 段を使い、n=0 を含める場合と n>=1 に限る場合を分けて解く。")
for name, P in [("6 - z - w", 6 - z - w), ("2 + 3z + 3w", 2 + 3*z + 3*w)]:
    p = 2
    seq = []
    for n in range(0, 6):
        v = a_L(P, p**n)
        seq.append(ZZ(v).valuation(p))
    print("    P=%-14s p=%d: v_p(a_{p^n}) (n=0..5) = %s" % (name, p, seq))
    for lo, tag in [(0, "n>=0"), (1, "n>=1")]:
        rows, rhs = [], []
        for n in range(lo, lo + 5):
            X = p**n
            rows.append([X*X, X*n, X, n, 1])
            rhs.append(seq[n])
        M = matrix(QQ, rows)
        if M.rank() < 5:
            print("      %s: 階数不足で一意に定まらない" % tag)
            continue
        sol = M.solve_right(vector(QQ, rhs))
        pred = [sol[0]*(p**n)**2 + sol[1]*(p**n)*n + sol[2]*(p**n) + sol[3]*n + sol[4]
                for n in range(0, 6)]
        ok = all(pred[n] == seq[n] for n in range(0, 6))
        print("      %s で解く: (a,b,c,d,e)=%s -> 全 n=0..5 と一致? %s  予測=%s"
              % (tag, tuple(sol), ok, [QQ(x) for x in pred]))
print("  => n>=1 の 5 段で解いた式は n=0 では外れる(DuBose-Vallieres も n>>0 でのみ主張している)。")
print("  => いずれにせよ 5 未知数に 5 方程式なので、これは同定であって証明ではない。")

print()
print("=" * 92)
print("結論: (1) の判定式は全例で成立(反例 0 件)。証明は report §3。")
print("      (2)(3) は判定式の位置づけ(d=1 の content 判定式・Deninger の条件との関係)を示す。")
print("      (4) はフィットであって証明ではない。増大の完全な形は未証明(report §5)。")
print("=" * 92)

print()
print("--- (5) 初等証明の核: a_{p^n} ≡ P(1,1)^(p^(2n))  (mod p) ---")
print("  mod p では z^(p^n)-1 = (z-1)^(p^n) なので、終結式が")
print("    a_L mod p = Res_z((z-1)^L, Res_w((w-1)^L, P)) = [P(1,1)^L]^L = P(1,1)^(L^2)")
print("  と潰れる(z^L-1, w^L-1 はモニックなので mod p 還元と終結式が可換)。")
print("  p 進体を一切使わない。以下 L=p^n で両辺を直接比較する。")
bad5 = 0
tot5 = 0
for name, P in CASES:
    P11 = ZZ(P.subs({z: 1, w: 1}))
    for p in PRIMES:
        for n in range(0, 4):
            L = p**n
            if L**2 > 300:
                break
            v = a_L(P, L)
            lhs = ZZ(v) % p
            rhs = ZZ(P11**(L*L)) % p
            tot5 += 1
            if lhs != rhs:
                bad5 += 1
                print("    不一致: P=%s p=%d n=%d : a_L mod p=%s, P(1,1)^(L^2) mod p=%s"
                      % (name, p, n, lhs, rhs))
print("  検査 %d 件、不一致 %d 件。" % (tot5, bad5))
print("  (a_L=0 の退化例も含む。その場合 P(1,1)≡0 mod p でなければ不一致として検出される。)")
