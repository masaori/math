# cycle 20 / T3 Pure: ell = 2 の決着（ell_equals_2）
#
# 対応する証明本体: outputs/reports/cycle20_T3_ell_equals_2.md
# 前提として読んでいる一次情報:
#   outputs/reports/cycle19_T3_theta_ge_ell_plus_1.md（定理 J4/J6/J7、系 J10、§5.4、§7.1、§7.3）
#   outputs/reports/cycle19_T3_theta_infinity.md（命題 8、定理 X/X'、注 5.2、§9.3）
#   outputs/reports/cycle16_T3_lower_order_and_degeneracy.md（補題 5.1-5.6、定理 D2、注 5.8）
#
# 実行: sage ell2.sage > ell2.out 2>&1
#
# 検証する Step:
#   A  定理 Y（ell=2・族 p(1,0)+q(0,1) の点ごとの付値）を、円分体での独立な付値計算と
#      **全点網羅**で照合する。枝ごとの内訳（何点がどの枝に落ちたか）も出す。
#   B  定理 Y'（ell=2・族の閉形式）を 2 経路で照合する。
#      B1 定理 Y から積み上げた Sigma_n との照合（全点の和）。
#      B2 塔の値 kappa_n（Matrix-Tree / 終結式。フィットパラメータ 0 個）との照合。
#      B3 円分体の Theta_m 経路（補題 J1）での高い n までの照合。
#   C  ell=2 での構造: 族は常に退化・常に theta=infinity（常に型 III）であること、
#      命題 8（例外直線の決定）が ell=2 でも成り立つこと、
#      定理 X'（ell 奇で証明済み）が ell=2 で成り立つのは case B かつ lam1>=2 のとき**ちょうど**であること。
#   D  注 5.2 の 3 つの「ell が奇であること」の使用箇所が ell=2 でどう破れるかを実測する。
#      D1 (i) v(a'-b') と v(a'+b') が同時に正になる（ell=2 では常に）。
#      D2 (ii) a'≡b' と a'≡-b' の排反性（m>=2 では成り立ち、m=1 で壊れる）。
#      D3 (iii) 狭義不等号の破れ = 打ち消し。ちょうどどの点で起き、次の 2 進桁 w が効くこと。
#   E  cycle 16 補題 5.5 を cycle 19 の言葉（ファイバー Newton・S_infty 近傍の層）で読み直す。
#      層ごとの寄与が j に依らず一定であること（定理 J7 証明 (b) と同じ相殺）と、
#      飽和層（r = m-1）が M に依らない定数寄与 2*2^M を出すこと。
#   F  定理 J7 の仮定 (N)・(B*) が ell=2 の族でどう成り立つ／破れるか、
#      それでも b = sum_{P in S_infty} j*(P) が当たるか。
#   G  **族の外**の一般 ell=2 塔（母集団全走査）。ord_2(kappa_n) を円分体経路で n<=NMAX_G まで出し、
#      形 mu(4^n-1) + b n 2^n + c 2^n + d n + e を高い n で解いて**低い n で out-of-sample 照合**、
#      b が sum j* と一致するかを見る。**これは数値支持であって証明ではない**（report §7 に検出力を明記）。
#   H  敵対的レビュー。
#
# **証明したことと数値支持どまりのことの区別は report §7 に書いてある。**
# Step A-F は証明済み命題の照合（宣言した範囲の全走査）、Step G は数値支持である。

load('_defs20.sage')

import sys
import time
from itertools import combinations_with_replacement as cwr

sys.stdout.reconfigure(line_buffering=True)

TOTAL_FAIL = 0
TOTAL_PASS = 0
CUTOFFS = []
T0 = time.time()

# 壁時計上限（秒）。前サイクルの反省により、掃引は前景で上限つきに回し、
# 打ち切ったら件数と中身を必ず出す。
BUDGET_G = 7500.0


def el():
    return '[%7.1fs]' % (time.time() - T0)


def report(tag, ok, detail=''):
    global TOTAL_FAIL, TOTAL_PASS
    if ok:
        TOTAL_PASS += 1
    else:
        TOTAL_FAIL += 1
        if TOTAL_FAIL <= 60:
            print('    FAIL %s %s' % (tag, detail))


def hr(title):
    print()
    print('=' * 78)
    print(title)
    print('=' * 78)


# 族の (p,q) 走査範囲。case A/B、lam0 = 1 / >= 2、lam1 = 1 / >= 2、w の各値を含むように取る。
PQ_FULL = [(p, q) for p in range(1, 13) for q in range(1, 13)]
PQ_POINT = [(1, 1), (1, 3), (3, 5), (1, 7), (5, 3), (1, 5), (3, 1), (5, 7), (9, 7), (1, 15),
            (1, 2), (2, 1), (1, 4), (3, 4), (2, 3), (4, 3), (8, 3), (1, 6), (6, 1), (2, 5),
            (4, 5), (12, 5), (16, 3), (10, 3), (2, 2), (2, 6), (4, 4), (6, 10), (2, 2 * 7),
            (1, 9), (9, 1), (7, 9), (11, 5), (3, 13), (1, 31), (32, 3), (3, 32), (24, 5)]

NMAX_A = 4          # Step A の全点網羅の段数
NMAX_B2 = 4         # Step B2（塔の値）の段数
NMAX_B3 = 8         # Step B3（円分体 Theta_m 経路）の段数


# ==========================================================================
hr('Step A  定理 Y（ell=2・族の点ごとの付値）の全点照合')
# ==========================================================================
print("""
族 X(p,q) = 1 頂点 bouquet（voltage (1,0) の loop p 本、(0,1) の loop q 本）、ell = 2。
mu = v_2(gcd(p,q))、p' = p/2^mu、q' = q/2^mu（同時には偶にならない）、E = 2^{-mu} D。

定理 Y（report §4）: g を原始 2^n 乗根、zeta = g^a、xi = g^b、(a,b) != (0,0) とする。

[A] p', q' がともに奇（lam0 := v_2(p'+q') >= 1）。
    eps = min(v_2(a), v_2(b))、m = n - eps、a' = a/2^eps、b' = b/2^eps in Z/2^m、phi_m = 2^{m-1}。
    m = 1:                        phi_1 v_2(E) = 2       (a',b' の一方だけ奇)
                                  phi_1 v_2(E) = 2+lam0  (両方奇)
    m >= 2、一方だけ奇:            phi_m v_2(E) = 2
    m >= 2、両方奇:  s = v_2(a'-b'), t = v_2(a'+b')（**ell=2 では min(s,t) = 1**）、r = max(s,t)
        r >= m（a' = +-b'、例外直線上）:      phi_m v_2(E) = lam0 phi_m + 2
        lam0 = 1 かつ r = m-1（4 による飽和）: phi_m v_2(E) = 2 phi_m = 2^m
        それ以外:                             phi_m v_2(E) = 2 + 2^r

[B] p' か q' の一方が偶（lam1 := v_2(偶数側) >= 1、w := v_2(偶数側/2 + 奇数側)）。
    A = 偶数側の指数、B = 奇数側の指数、phi_n = 2^{n-1} として
        U_A = lam1 phi_n + 2^{v_2(A)+1}（A = 0 なら oo）、U_B = 2^{v_2(B)+1}（B = 0 なら oo）
        U_A != U_B:  phi_n v_2(E) = min(U_A, U_B)
        U_A = U_B（**打ち消し**。lam1 = 1 かつ v_2(A) = n-2 かつ v_2(B) = n-1 のときだけ起きる）:
                     v_2(E) = 2 + w      （<- 係数の**次の 2 進桁** w が効く）

以下、円分体 Q(zeta_{2^n}) での独立な付値計算（cycle 16 実装 point_val）と全点で照合する。
""")

BRANCH = {}
npts = 0
for (p, q) in PQ_POINT:
    (m, edges) = fam(p, q)
    D = detL(m, edges)
    mu = mu_content(D, 2)
    Ev = E_of(D, 2, mu)
    for n in range(1, NMAX_A + 1):
        for a in range(2**n):
            for b in range(2**n):
                if a == 0 and b == 0:
                    continue
                (pred, br) = Y_pointwise(p, q, n, a, b, want_branch=True)
                act = point_val(Ev, 2, n, a, b)
                BRANCH[br] = BRANCH.get(br, 0) + 1
                npts += 1
                report('A (p,q)=(%d,%d) n=%d (a,b)=(%d,%d)' % (p, q, n, a, b),
                       act == pred, 'pred=%s actual=%s branch=%s' % (pred, act, br))
print('  %s 照合点数 %d（(p,q) %d 組 x n <= %d の全点。標本抽出ではない）'
      % (el(), npts, len(PQ_POINT), NMAX_A))
print('  枝ごとの内訳:')
for k in sorted(BRANCH):
    print('    %-16s %6d 点' % (k, BRANCH[k]))
print('  -> 打ち消し枝 B/tie が実際に発生していることに注意（0 件なら照合になっていない）。')


# ==========================================================================
hr('Step B  定理 Y\'（ell=2・族の閉形式）の照合')
# ==========================================================================
print("""
定理 Y'（report §5）: kappa(X) = 1、mu = v_2(gcd(p,q)) として、**全ての n >= 1** で

  [A] lam0 = 1:      ord_2(kappa_n) = mu(4^n - 1) + 2n 2^n + 4*2^n - 6n - 1
  [A] lam0 >= 2:     ord_2(kappa_n) = mu(4^n - 1) + 2n 2^n + 2 lam0 2^n - 2n - 3 lam0 + 2
  [B] lam1 >= 2:     ord_2(kappa_n) = mu(4^n - 1) + 2n 2^n + lam1 (2^n - 1)
  [B] lam1 = 1:      ord_2(kappa_n) = mu(4^n - 1) + 2n 2^n + 2n - 1 + 2w   (n >= 2)
                     n = 1 は上の lam1 >= 2 の式（= 5）と一致する。

[A] lam0 = 1 の式は cycle 16 定理 D2（(p,q) = (1,1)）そのものであり、
定理 Y' はそれを族全体へ広げたものである。
""")

print('  B1: 定理 Y から積み上げた Sigma_n と閉形式の照合（(p,q) %d 組 x n <= 7 の全点和）'
      % len(PQ_POINT))
nb1 = 0
for (p, q) in PQ_POINT:
    (mu, pp, qq, case, par) = fam_invariants(p, q)
    for n in range(1, 8):
        S = QQ(0)
        for a in range(2**n):
            for b in range(2**n):
                if a == 0 and b == 0:
                    continue
                S += Y_pointwise(p, q, n, a, b)
        got = mu * (4**n - 1) - 2 * n + S
        report('B1 (p,q)=(%d,%d) n=%d' % (p, q, n), got == Y_closed(p, q, n),
               'fromY=%s closed=%s' % (got, Y_closed(p, q, n)))
        nb1 += 1
print('  %s B1 照合 %d 件' % (el(), nb1))

print()
print('  B2: 塔の値 kappa_n（Matrix-Tree / 終結式。**フィットパラメータ 0 個**）との照合')
nb2 = 0
b2_cut = 0
for (p, q) in PQ_POINT:
    (m, edges) = fam(p, q)
    ords = tower_ords(m, edges, 2, NMAX_B2, tag='fam(%d,%d)' % (p, q), budget=300)
    got = usable_prefix(ords)
    b2_cut += (NMAX_B2 + 1 - len(got))
    for n in range(1, len(got)):
        report('B2 (p,q)=(%d,%d) n=%d' % (p, q, n), got[n] == Y_closed(p, q, n),
               'tower=%s closed=%s' % (got[n], Y_closed(p, q, n)))
        nb2 += 1
print('  %s B2 照合 %d 件、到達できなかった段 %d 件' % (el(), nb2, b2_cut))
CUTOFFS.append(('B2 塔の値', b2_cut))

print()
print('  B3: 円分体の Theta_m 経路（補題 J1 + cycle 14 (1.1)）で n <= %d まで照合' % NMAX_B3)
nb3 = 0
b3_cut = 0
for (p, q) in PQ_POINT[:20]:
    (m, edges) = fam(p, q)
    got = ords_via_sigma(m, edges, 2, NMAX_B3, budget=60)
    if got is None:
        b3_cut += 1
        continue
    b3_cut += (NMAX_B3 + 1 - len(got))
    for n in range(1, len(got)):
        report('B3 (p,q)=(%d,%d) n=%d' % (p, q, n), got[n] == Y_closed(p, q, n),
               'sigma=%s closed=%s' % (got[n], Y_closed(p, q, n)))
        nb3 += 1
print('  %s B3 照合 %d 件、到達できなかった段 %d 件' % (el(), nb3, b3_cut))
CUTOFFS.append(('B3 円分体経路', b3_cut))
print()
print('  例（cycle 16 定理 D2 の数列と、族の他のメンバー）:')
for (p, q) in [(1, 1), (1, 3), (1, 2), (1, 4), (2, 2)]:
    (mu, pp, qq, case, par) = fam_invariants(p, q)
    print('    (p,q)=(%2d,%2d) mu=%d case=%s par=%s : %s'
          % (p, q, mu, case, par, [Y_closed(p, q, n) for n in range(0, 7)]))


# ==========================================================================
hr('Step C  ell=2 での構造（族は常に型 III／命題 8／定理 X\' の射程）')
# ==========================================================================
print("""
C1: ell=2 では族 X(p,q) は**すべて**退化かつ theta=infinity を持つ（= 常に型 III）。
    根拠: H = -(p'T^2 + q'S^2) mod 2 は、p',q' ともに奇なら (T+S)^2、
          一方が偶なら（奇な側の変数）^2 で、いずれも P^1(F_2) に零点を持つ。
    cycle 19 step 2 命題 9（ell 奇: 非退化 / 型 II / 型 III の 3 分割）の ell=2 版は
    「常に 3 番目」である。
""")
nc1 = 0
for (p, q) in PQ_FULL:
    (m, edges) = fam(p, q)
    D = detL(m, edges)
    mu = mu_content(D, 2)
    Ev = E_of(D, 2, mu)
    lines = exceptional_lines(Ev, 2)
    (H, zh) = (None, None)
    Hh = lowest_form(D, 2)
    report('C1 (p,q)=(%d,%d)' % (p, q), len(lines) >= 1,
           'exceptional lines = %s' % lines)
    nc1 += 1
print('  %s C1 照合 %d 組（1 <= p,q <= 12 の全組）' % (el(), nc1))

print()
print("""C2: 命題 8（cycle 19 step 2）は ell=2 でも成り立つ。
    theta=infinity <=> ell | p'q'(p'+q')（ell=2 では常に真）、
    例外直線と lam は: 両方奇 -> (1,1),(1,-1) の 2 本・lam = v_2(p'+q')、
                       p' 偶  -> (1,0) の 1 本・lam = v_2(p')、
                       q' 偶  -> (0,1) の 1 本・lam = v_2(q')。""")
nc2 = 0
for (p, q) in PQ_FULL:
    (mu, pp, qq, case, par) = fam_invariants(p, q)
    (m, edges) = fam(p, q)
    D = detL(m, edges)
    Ev = E_of(D, 2, mu_content(D, 2))
    lines = exceptional_lines(Ev, 2)
    got = sorted((tuple(u), lam) for (u, lam, th) in lines)
    if case == 'A':
        (lam0, lamm) = par
        want = sorted([((1, 1), lam0), ((1, -1), lam0)])
        want = sorted((u if u[0] > 0 or (u[0] == 0 and u[1] > 0) else (-u[0], -u[1]), l)
                      for (u, l) in want)
    else:
        (lam1, w, swapped) = par
        want = [((0, 1), lam1)] if swapped else [((1, 0), lam1)]
    report('C2 (p,q)=(%d,%d)' % (p, q), got == sorted(want),
           'got=%s want=%s' % (got, sorted(want)))
    nc2 += 1
print('  %s C2 照合 %d 組（全組。lam まで含めた一致）' % (el(), nc2))

print()
print("""C3: cycle 19 step 2 定理 X'（ell 奇で証明済み）を ell=2 に当てると、
    **case B かつ lam1 >= 2 のときちょうど**成り立ち、それ以外では成り立たない。""")
nc3 = 0
agree_cases = {}
for (p, q) in PQ_FULL:
    (mu, pp, qq, case, par) = fam_invariants(p, q)
    ok_all = all(X_prime_closed(p, q, 2, n) == Y_closed(p, q, n) for n in range(1, 7))
    if case == 'A':
        key = 'A lam0=%s' % ('1' if par[0] == 1 else '>=2')
    else:
        key = 'B lam1=%s' % ('1' if par[0] == 1 else '>=2')
    agree_cases.setdefault(key, [0, 0])
    agree_cases[key][0 if ok_all else 1] += 1
    want = (case == 'B' and par[0] >= 2)
    report('C3 (p,q)=(%d,%d)' % (p, q), ok_all == want,
           'X\'=%s Y\'=%s case=%s par=%s'
           % ([X_prime_closed(p, q, 2, n) for n in range(1, 4)],
              [Y_closed(p, q, n) for n in range(1, 4)], case, par))
    nc3 += 1
print('  %s C3 照合 %d 組。場合ごとの内訳（定理 X\' と一致 / 不一致）:' % (el(), nc3))
for k in sorted(agree_cases):
    print('    %-12s 一致 %3d 組 / 不一致 %3d 組' % (k, agree_cases[k][0], agree_cases[k][1]))


# ==========================================================================
hr('Step D  注 5.2 の 3 つの「ell 奇」の使用箇所が ell=2 でどう破れるか（実測）')
# ==========================================================================
print("""
cycle 19 step 2 注 5.2 は、定理 X の証明で ell が奇であることを 3 箇所で使ったと述べている。
  (i)   2 が単元 -> v(a'-b') と v(a'+b') が同時に正にならない
  (ii)  a' = b' と a' = -b' が排反
  (iii) ell - 1 >= 2 による狭義不等号
""")

print('  D1 (i): ell=2、a',end='')
print("',b' ともに奇のとき v_2(a'-b') と v_2(a'+b') は**ともに >= 1** で、min はちょうど 1。")
nd1 = 0
for m in range(2, 10):
    bad = 0
    minne1 = 0
    for ap in range(1, 2**m, 2):
        for bp in range(1, 2**m, 2):
            s = nu2(ap - bp, 2**m)
            t = nu2(ap + bp, 2**m)
            if s is not Infinity and s < 1:
                bad += 1
            if t is not Infinity and t < 1:
                bad += 1
            if min(s, t) != 1:
                minne1 += 1
    report('D1 m=%d' % m, bad == 0 and minne1 == 0,
           'v<1 が %d 件、min != 1 が %d 件' % (bad, minne1))
    nd1 += 1
print('  %s D1 照合 %d レベル（m = 2..9 の両方奇の全点）。odd ell では常に min = 0 で、'
      % (el(), nd1))
print('     この差が定理 X の「1 + ell^r」を ell=2 では「2 + 2^r」に変える。')

print()
print("  D2 (ii): a' = b' と a' = -b' の排反性は m >= 2 で成り立ち、m = 1 で壊れる。")
for m in range(1, 8):
    both = sum(1 for ap in range(1, 2**m, 2) for bp in range(1, 2**m, 2)
               if (ap - bp) % 2**m == 0 and (ap + bp) % 2**m == 0)
    report('D2 m=%d' % m, (both == 0) == (m >= 2),
           'a\'=+-b\' が同時に成り立つ点 %d 件' % both)
print('  %s D2: m=1 では 1 点で同時成立（点 (1,1)、h = -1）。定理 Y の m=1 行はそのために別扱い。'
      % el())

print()
print("""  D3 (iii): 狭義不等号の破れ = 打ち消し（|J| >= 2）。
     case B で U_A = U_B となる点を全列挙し、そこが lam1 = 1 かつ (v_2(A),v_2(B)) = (n-2, n-1)
     に限ることと、真の付値が 2 + w（w = v_2(偶数側/2 + 奇数側)）であることを実測する。""")
nd3 = 0
tie_shapes = {}
for (p, q) in PQ_POINT:
    (mu, pp, qq, case, par) = fam_invariants(p, q)
    if case != 'B':
        continue
    (lam1, w, swapped) = par
    (m, edges) = fam(p, q)
    D = detL(m, edges)
    Ev = E_of(D, 2, mu_content(D, 2))
    for n in range(1, 6):
        for a in range(2**n):
            for b in range(2**n):
                if a == 0 and b == 0:
                    continue
                (A, B) = (b, a) if swapped else (a, b)
                phin = 2**(n - 1)
                na = nu2(A, 2**n)
                nb = nu2(B, 2**n)
                Ua = Infinity if na is Infinity else lam1 * phin + 2**(na + 1)
                Ub = Infinity if nb is Infinity else 2**(nb + 1)
                if Ua is Infinity or Ub is Infinity or Ua != Ub:
                    continue
                tie_shapes[(lam1, na - n, nb - n)] = tie_shapes.get((lam1, na - n, nb - n), 0) + 1
                act = point_val(Ev, 2, n, a, b)
                naive = QQ(Ua) / phin
                report('D3 (p,q)=(%d,%d) n=%d (a,b)=(%d,%d)' % (p, q, n, a, b),
                       act == QQ(2 + w) and act > naive,
                       'actual=%s want=%s naive(min)=%s' % (act, 2 + w, naive))
                nd3 += 1
print('  %s D3 打ち消し点 %d 件を照合。起きた (lam1, v_2(A)-n, v_2(B)-n) の形:' % (el(), nd3))
for k in sorted(tie_shapes):
    print('    lam1=%d, v_2(A)=n%+d, v_2(B)=n%+d : %d 件' % (k[0], k[1], k[2], tie_shapes[k]))
print('  -> 打ち消しは lam1 = 1 かつ (n-2, n-1) の形でしか起きず、そこでの真の値は')
print('     素朴な min より **狭義に深い**（w >= 1）。これが cycle 19 §7.1 の「次の桁へ降りる」')
print('     の、実際に閉じた形での実例である。')

print()
print("  D3b: w が本当に効いていること（同じ (mu, lam1) で w だけ違う 2 組の kappa_n が違う）")
for (P1, P2) in [((1, 2), (1, 6)), ((3, 2), (1, 2)), ((5, 2), (1, 2)), ((2, 3), (2, 1))]:
    (mu1, _, _, c1, pr1) = fam_invariants(*P1)
    (mu2, _, _, c2, pr2) = fam_invariants(*P2)
    print('    (p,q)=%s: case=%s par=%s  ord=%s' % (P1, c1, pr1, [Y_closed(P1[0], P1[1], n) for n in range(1, 6)]))
    print('    (p,q)=%s: case=%s par=%s  ord=%s' % (P2, c2, pr2, [Y_closed(P2[0], P2[1], n) for n in range(1, 6)]))


# ==========================================================================
hr('Step E  cycle 16 補題 5.5 を cycle 19 の言葉で読み直す')
# ==========================================================================
print("""
cycle 16 補題 5.5 は Sigma_M^diag = (M+1)2^M - 4 を直接計算で出していた（(p,q) = (1,1)）。
定理 Y の枝で分けると、この和は

  * r = j の層（2 <= j <= m-2）: 点の個数 2^{m-1} * 2^{m-j}、各点の付値 (2 + 2^j)/2^{m-1}
      -> 層ごとの寄与 2^{m-j+1} + 2^m。**2^m の部分が j に依らない**（個数と付値の j 依存が相殺）。
         これは cycle 19 step 1 定理 J7 の証明 (b) の
             phi(ell^{M'-1-v}) * ell^{v+1} = phi(ell^{M'})   （v に依らない）
         とまったく同じ相殺であり、層の本数が M に比例することが M*2^M 項を生む。
  * r = m-1 の層（**4 による飽和**。lam0 = 1 のときだけ）: 個数 2^m、付値 2
      -> 寄与 2*2^m。M に依らない定数（cycle 16 注 5.8 の「飽和」）。
  * r >= m の層（例外直線上）: 個数 2^m、付値 lam0 + 2/phi_m
      -> 寄与 lam0 2^m + 4。cycle 19 step 2 命題 7 の「例外直線の寄与」に対応し、n2^n を作らない。

以下、各レベルで枝ごとの小計を実測して上の読みを確かめる。
""")
for (p, q) in [(1, 1), (1, 3), (3, 5)]:
    (mu, pp, qq, case, par) = fam_invariants(p, q)
    print('  (p,q)=(%d,%d) case=%s lam0=%s' % (p, q, case, par[0]))
    for m in range(2, 8):
        sub = {}
        for ap in range(1, 2**m, 2):
            for bp in range(1, 2**m, 2):
                (v, br) = Y_pointwise(p, q, m, ap, bp, want_branch=True)
                s = nu2(ap - bp, 2**m)
                t = nu2(ap + bp, 2**m)
                r = max(s, t)
                key = (br, 'r=%s' % ('>=m' if (r is Infinity or r >= m) else r))
                sub[key] = sub.get(key, QQ(0)) + v
        tot = sum(sub.values())
        want = ((m + 1) * 2**m - 4) if par[0] == 1 else 2**m * (m - 1 + par[0])
        report('E (p,q)=(%d,%d) m=%d' % (p, q, m), tot == want,
               'diag sum=%s want=%s' % (tot, want))
        if m <= 5:
            print('    m=%d 合計 %s（閉形式 %s）内訳: %s'
                  % (m, tot, want, sorted((str(k), v) for (k, v) in sub.items())))
    print()
print('  %s -> lam0 = 1 では飽和層があるので (M+1)2^M - 4、lam0 >= 2 では飽和が起きず 2^M(M-1+lam0)。'
      % el())


# ==========================================================================
hr('Step F  定理 J7 の仮定 (N)・(B*) の ell=2 での成否と、b = sum j* の当否')
# ==========================================================================
print("""
cycle 19 step 1 §5.4 は、ell=2 トーラスで定理 J7 の仮定 (N)（argmin の一意性）と
(B*)（定理 B' の最小点の一意性）が破れることを示した。族全体でその成否を数え、
それでも n2^n の係数 b = sum_{P in S_infty} j*(P) が当たるかを見る。
""")
nf = 0
f_stat = {}
for (p, q) in PQ_POINT:
    (mu, pp, qq, case, par) = fam_invariants(p, q)
    (m, edges) = fam(p, q)
    D = detL(m, edges)
    Ev = E_of(D, 2, mu_content(D, 2))
    coeffs = cleared_coeffs(Ev)
    (bstar, det) = jstar_sum(Ev, 2)
    # (B*): 定理 B' の最小点が一意か（レベル <= 4）
    bstar_ok = True
    for Mp in range(1, 5):
        (th, ok) = Theta_level(coeffs, 2, Mp)
        if not ok:
            bstar_ok = False
    key = (case, 'lam=%s' % par[0], 'B*ok' if bstar_ok else 'B*broken')
    f_stat[key] = f_stat.get(key, 0) + 1
    report('F b=sum j* (p,q)=(%d,%d)' % (p, q), bstar == 2,
           'sum j* = %s, S_infty = %s' % (bstar, det))
    nf += 1
print('  %s F 照合 %d 組。**全組で sum j* = 2** であり、定理 Y\' の n2^n の係数 2 と一致する。' % (el(), nf))
print('  (case, lam, (B*) の成否) ごとの件数:')
for k in sorted(f_stat, key=str):
    print('    %-34s %3d 組' % (str(k), f_stat[k]))
print('  -> (B*) が破れても b は当たる。定理 J7 の主要項の主張は ell=2 でもこの族で成立し、')
print('     破れているのは定数項（c, d, e）の方である。これは §5.4 の観察と整合する。')


# ==========================================================================
hr('Step G  族の外の一般 ell=2 塔（母集団全走査。**数値支持であって証明ではない**）')
# ==========================================================================


def gen_pop():
    out = []
    V = [(1, 0), (0, 1), (1, 1), (1, -1), (2, 1), (1, 2), (2, 3), (0, 2), (2, 0)]
    for r in [2, 3]:
        for combo in cwr(range(len(V)), r):
            out.append(('bq ' + ' '.join(str(V[i]) for i in combo), 1,
                        [(0, 0, V[i]) for i in combo]))
    for r in [3]:
        for combo in cwr(range(len(V) + 1), r):
            edges = [(0, 1, ((0, 0) if i == len(V) else V[i])) for i in combo]
            out.append(('2v ' + ' '.join(('(0,0)' if i == len(V) else str(V[i]))
                                         for i in combo), 2, edges))
    return out


POP = gen_pop()
NMAX_G = 9
print("""
母集団 %d 個（bouquet 2-3 ループ / 2 頂点 3 重辺、voltage 9 種。cycle 19 step 1 と同じ）。
各塔について円分体経路（補題 J1 + (1.1)。塔の値も本サイクルの理論も使わない）で
ord_2(kappa_n) を n <= %d まで出し、形

    ord_2(kappa_n) = mu(4^n - 1) + b n 2^n + c 2^n + d n + e

を **n = 6,7,8,9 の 4 点で解き、n = 4,5 で out-of-sample 照合**する（out-of-sample 2 点）。
さらに、その式が成り立つ最小の n（n_0）を n = 1 まで下げて調べ、分布を出す。
そのうえで b を sum_{P in S_infty} j*(P)（D の係数だけからの有限計算。フィット 0 個）と比べる。

**これは数値支持であって証明ではない。** 検出力は §7 に書く。
壁時計上限 %.0f 秒。打ち切った塔は件数と名前を出す。
""" % (len(POP), NMAX_G, BUDGET_G))

g_ok = g_shape_miss = g_short = g_cut = g_degen = g_hfail = 0
g_short_names = []
g_n0tab = {}
g_shape_names = []
g_bmatch = g_bmiss = 0
g_btab = {}
g_dtab = {}
g_cut_names = []
g_bmiss_ex = []
tG = time.time()
for (name, m, edges) in POP:
    if time.time() - tG > BUDGET_G:
        g_cut += 1
        g_cut_names.append(name)
        continue
    D = detL(m, edges)
    if D == 0:
        # voltage 格子が Z^2 を張らない等で det L = 0。仮定 (H) の対象外。
        g_degen += 1
        continue
    mu = mu_content(D, 2)
    if mu is Infinity:
        g_degen += 1
        continue
    Ev = E_of(D, 2, mu)
    ords = ords_via_sigma(m, edges, 2, NMAX_G, budget=120)
    if ords is None:
        g_hfail += 1          # 仮定 (H) が破れる（ある段で E が消え v = oo）
        continue
    if len(ords) < NMAX_G + 1:
        g_short += 1          # 45 秒の段あたり上限で n = %d まで届かなかった
        g_short_names.append((name, len(ords) - 1))
        continue
    sol = fit_shape(ords, mu, [6, 7, 8, 9])
    if sol is None:
        g_shape_miss += 1
        g_shape_names.append((name, ords, None))
        continue
    (b, c, d, e) = sol
    def hits(n):
        return ords[n] == mu * (4**n - 1) + b * n * 2**n + c * 2**n + d * n + e
    oos = all(hits(n) for n in [4, 5])
    n0 = 6
    while n0 >= 1 and hits(n0 - 1):
        n0 -= 1
    g_n0tab[n0] = g_n0tab.get(n0, 0) + 1
    if not oos:
        g_shape_miss += 1
        g_shape_names.append((name, ords, sol))
        continue
    g_ok += 1
    g_btab[b] = g_btab.get(b, 0) + 1
    g_dtab[d] = g_dtab.get(d, 0) + 1
    (bstar, det) = jstar_sum(Ev, 2)
    if bstar == b:
        g_bmatch += 1
    else:
        g_bmiss += 1
        if len(g_bmiss_ex) < 8:
            g_bmiss_ex.append((name, ords, b, bstar, det, sinf_brute(Ev, 2, 6)))
print('  %s 母集団 %d 個の内訳:' % (el(), len(POP)))
print('    形が合った（n=6..9 で解き n=4,5 で out-of-sample 一致）: %d 個' % g_ok)
print('    形が合わなかった                                      : %d 個' % g_shape_miss)
print('    仮定 (H) が破れる（ある段で E が消える）               : %d 個' % g_hfail)
print('    段あたり 120 秒の上限で n=%d まで届かなかった           : %d 個' % (NMAX_G, g_short))
print('    det L = 0（voltage 格子が Z^2 を張らない等）           : %d 個' % g_degen)
print('    全体の壁時計上限 %.0f 秒で打ち切り                      : %d 個' % (BUDGET_G, g_cut))
for (nm, ords, sol) in g_shape_names:
    print('    形が合わなかった塔: %s  ord=%s  fit=%s' % (nm, ords, sol))
if g_short_names:
    print('    時間で届かなかった塔（到達段数）: %s%s'
          % (', '.join('%s(n<=%d)' % t for t in g_short_names[:10]),
             ' ...' if len(g_short_names) > 10 else ''))
if g_cut_names:
    print('    打ち切った塔（%d 個）: %s%s'
          % (len(g_cut_names), ', '.join(g_cut_names[:12]),
             ' ...' if len(g_cut_names) > 12 else ''))
CUTOFFS.append(('G 母集団（時間打ち切り）', g_cut))
CUTOFFS.append(('G 母集団（段あたり時間で短い）', g_short))
CUTOFFS.append(('G 母集団（(H) 破れ）', g_hfail))
CUTOFFS.append(('G 母集団（形が合わない）', g_shape_miss))
print('  式が成り立つ最小段 n_0 の分布: %s' % sorted(g_n0tab.items()))
print('  b（n2^n の係数）の分布: %s' % sorted(g_btab.items()))
print('  d（n の係数）の分布  : %s' % sorted(g_dtab.items()))
print('  b = sum_{P in S_infty} j*(P) が一致: %d 個 / 不一致: %d 個' % (g_bmatch, g_bmiss))
for (name, ords, b, bstar, det, brute) in g_bmiss_ex:
    print('    不一致例: %s' % name)
    print('      ord_2(kappa_n) = %s' % ords)
    print('      b(fit) = %s, sum j* = %s, S_infty(候補集合経由) = %s, S_infty(総当たり |a|,|b|<=6) = %s'
          % (b, bstar, det, brute))
print('  -> d != 0（n の線形項）が出るかどうかも ell=2 の特徴である。分布を上に出した。')


# ==========================================================================
hr('Step H  敵対的レビュー')
# ==========================================================================

print('  H1: 「定理 Y\' は塔の値へのフィットではないか」')
print('      -> 予言に使うのは (mu, case, lam0 or lam1, w) だけで、すべて (p,q) からの有限計算。')
for (p, q) in [(1, 1), (1, 3), (1, 2), (1, 6), (8, 3)]:
    (mu, pp, qq, case, par) = fam_invariants(p, q)
    print('      (p,q)=(%2d,%2d) -> mu=%d case=%s par=%s' % (p, q, mu, case, par))
print('      Step B2 は全段が out-of-sample（塔の値を一切使わずに予言してから照合）。')

print()
print('  H2: 「S_infty の候補集合（系 J10）は ell=2 でも取りこぼさないか」')
nh2 = 0
for (p, q) in PQ_POINT[:20]:
    (m, edges) = fam(p, q)
    D = detL(m, edges)
    Ev = E_of(D, 2, mu_content(D, 2))
    cand = sorted(tuple(u) for (u, lam, th) in exceptional_lines(Ev, 2))
    brute = sinf_brute(Ev, 2, 8)

    def norm(u):
        (a, b) = (ZZ(u[0]), ZZ(u[1]))
        return (a, b) if (a > 0 or (a == 0 and b > 0)) else (-a, -b)
    cs = set(norm(u) for u in cand)
    bs = set(norm(u) for u in brute)
    report('H2 (p,q)=(%d,%d)' % (p, q), bs <= cs, 'brute=%s cand=%s' % (sorted(bs), sorted(cs)))
    nh2 += 1
print('  %s H2 照合 %d 組（総当たり |a|,|b| <= 8 が候補集合に含まれること）' % (el(), nh2))

print()
print('  H3: 「ell=2 の族の閉形式は、cycle 16 定理 D2 の焼き直しにすぎないのではないか」')
print('      -> 違う。定理 D2 は (p,q)=(1,1)（case A, lam0=1）1 点である。')
print('         定理 Y\' の 4 つの場合の値を比べる:')
for (p, q) in [(1, 1), (1, 3), (1, 2), (1, 4)]:
    (mu, pp, qq, case, par) = fam_invariants(p, q)
    print('        (p,q)=(%d,%d) case=%s par=%s : %s'
          % (p, q, case, par, [Y_closed(p, q, n) for n in range(1, 7)]))
print('         4 つの数列は互いに異なる（定理 D2 の式で他の 3 つは出ない）。')

print()
print('  H4: 「ell=2 でも定理 X\' が成り立つ場合があるのは偶然か」')
print('      -> 偶然ではない。case B（例外直線 1 本）で lam1 >= 2 なら打ち消しも飽和も起きず、')
print('         定理 X の [B] の証明の狭義不等号がそのまま通る。Step C3 が全組で確認している。')

print()
print('  H5: 「n=1 の例外は本質的か」')
for (p, q) in [(1, 2), (1, 6), (3, 2)]:
    (mu, pp, qq, case, par) = fam_invariants(p, q)
    (lam1, w, swapped) = par
    nm = 2 * 1 * 2 + 2 * 1 - 1 + 2 * w
    print('      (p,q)=(%d,%d) w=%d: n>=2 の式を n=1 に当てると %d、真の値は %d'
          % (p, q, w, nm, Y_closed(p, q, 1)))
print('      -> 打ち消しは v_2(A) = n-2 を要するので n >= 2 でしか起きない。n=1 は打ち消しなしの式。')


# ==========================================================================
hr('総計')
# ==========================================================================
print('PASS = %d, FAIL = %d' % (TOTAL_PASS, TOTAL_FAIL))
print('打ち切り:')
for (k, v) in CUTOFFS:
    print('  %-28s %d' % (k, v))
if SKIPS:
    print('tower_ords の段ごと打ち切り（%d 件）:' % len(SKIPS))
    for s in SKIPS[:20]:
        print('  %s' % (s,))
else:
    print('tower_ords の段ごと打ち切り: 0 件')
print('総時間 %s' % el())
