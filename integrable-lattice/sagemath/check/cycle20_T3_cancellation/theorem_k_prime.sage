# cycle 20 / T3 Pure: 定理 K'（無仮定版）— cycle 19 が tie で落とした塔を埋める。
#
# 対応する証明本体: outputs/reports/cycle20_T3_cancellation_recursion.md（§5）
#
# cycle 19 Step D は、定理 B' の最小点が 1 点でも tie なら予言を出さないという運用で、
# ell=2 で 174 個、ell=3 で 165 個の塔を落としていた。定理 L4（終結式公式）は
# 仮定なしに hat theta を出すので、それらの塔でも予言できる。ここでその件数を測る。
#
# 実行: sage theorem_k_prime.sage > theorem_k_prime.out 2>&1

import sys, time
from itertools import combinations_with_replacement as cwr
sys.stdout.reconfigure(line_buffering=True)

load('_defs20.sage')

FAIL = 0
TRUNC = []
def check(cond, msg):
    global FAIL
    if not cond:
        FAIL += 1
        print("   *** FAIL:", msg)
    return cond

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
T_START = time.time()
print("=" * 78)
print("cycle 20 / T3: 定理 K'（無仮定版）— tie で落ちていた塔が何個埋まるか")
print("=" * 78)

# ==========================================================================
print()
print("=" * 78)
print("Step E: 定理 K'（無仮定版）— cycle 19 が tie で落とした塔が何個埋まるか", el())
print("=" * 78)
print("""
  cycle 19 Step D は、定理 B' の最小点が 1 点でも tie なら「予言を出さない」として
  ell=2 で 174 個、ell=3 で 165 個の塔を落としていた。
  定理 L4 は仮定なしに hat theta を出すので、それらの塔でも予言できる。
  ここでは母集団を走査し、
    - cycle 19 の判定（tie の有無）
    - 定理 K' の予言と、Matrix-Tree 定理による塔の値の照合
  を両方出す。ell=5,7 は cycle 19 でも tie 0 件なので対象外（新規に埋まる塔が無い）。
""")
NMAX = {2: 4, 3: 3}
E_BUDGET = 1500.0
E_STATS = {}
for ell in [2, 3]:
    t0 = time.time()
    ntower = ntie = nfill = nfill_ok = nplain = nplain_ok = 0
    nskip_H = 0
    nleft = 0
    fill_ex = []
    for (name, m, edges) in POP:
        if time.time() - t0 > E_BUDGET:
            nleft += 1
            continue
        if not connected_by_lattice(m, edges, ell, ell):
            nskip_H += 1
            continue
        D = detL(m, edges)
        if D == 0:
            nskip_H += 1
            continue
        mu = mu_content(D, ell)
        co = cleared_coeffs(E_of(D, ell, mu))
        # cycle 19 の判定（tie があるか）
        tie = False
        dead = False
        for M in range(1, NMAX[ell] + 1):
            (th, ok) = Theta_level(co, ell, M)
            if th is None:
                dead = True
                break
            if not ok:
                tie = True
        if dead:
            nskip_H += 1
            continue
        (preds, inv) = predicted_ord_K_exact(m, edges, ell, NMAX[ell])
        if inv.get('dead'):
            nskip_H += 1
            continue
        ntower += 1
        allok = True
        for (n, pred) in preds:
            N = ell**n
            actual = ZZ(kappa_derived(m, edges, N, N)).valuation(ell)
            if actual != pred:
                allok = False
                check(False, "定理 K' ell=%d %s n=%d: 予言 %s != 実測 %s" % (ell, name, n, pred, actual))
        if tie:
            ntie += 1
            nfill += 1
            if allok:
                nfill_ok += 1
                if len(fill_ex) < 3:
                    fill_ex.append(name)
        else:
            nplain += 1
            if allok:
                nplain_ok += 1
    if nleft:
        TRUNC.append("Step E ell=%d: 壁時計 %.0fs 超過のため %d 個を未実施" % (ell, E_BUDGET, nleft))
    E_STATS[ell] = (ntower, ntie, nfill_ok, nplain, nplain_ok, nskip_H, nleft)
    print("  ell=%-2d : 走査した塔 %d 個（(H) 等で除外 %d / 時間切れ未実施 %d）" % (ell, ntower, nskip_H, nleft))
    print("           cycle 19 が tie で落としていた塔 %d 個 → 定理 K' が予言でき、塔の値と一致 %d 個"
          % (ntie, nfill_ok))
    print("           cycle 19 でも予言できていた塔 %d 個 → 一致 %d 個" % (nplain, nplain_ok))
    if fill_ex:
        print("           新たに埋まった塔の例: %s" % ', '.join(fill_ex))


# ==========================================================================
print()
print("=" * 78)
print("まとめ", el())
print("=" * 78)
print("  FAIL 件数 =", FAIL)
print("  打ち切った計算 =", len(TRUNC), "件")
for t in TRUNC:
    print("    -", t)
print("  総所要 = %.1f 秒" % (time.time() - T_START))
