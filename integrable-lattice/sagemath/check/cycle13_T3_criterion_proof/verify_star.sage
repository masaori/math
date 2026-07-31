# cycle 13 / T3 Pure: 命題 7.2（bouquet の content = ループ重複度の gcd）の機械検証。
#
# 証明本体: outputs/reports/cycle13_T3_mu_content_criterion_proof.md 命題 7.2。
#   m = 1（1 頂点、辺は全てループ）で、voltage ±a のループの本数を m_a（a ≥ 1）とすると
#       content_z(det L(z)) = gcd_{a≥1} m_a.
#   したがって bouquet で μ_ℓ > 0 になるのは「全ての a で ℓ | m_a」＝ ℓ 重多重グラフの
#   自明例に限る（voltage 0 のループは L(z) に寄与しないので除く）。
#
# 本ファイルは救済元ブランチ（worktree-nifty-drifting-engelbart）の verify_star.sage のうち
# **D 節だけ**を残したものである。同ファイルの A 節（(★)）・B 節（連結性判定）・C 節（content 保存）は
# 既存の proof_steps.sage の Step 4 / Step 3 / Step 5 が同じ主張をより広い対象で検証済みなので
# 重複させない。理由と対応は README.md に記載した。
#
# 計算は全て ℤ[z,z^{-1}] 上の厳密計算で、ℝ・ℂ を経由しない。

import os, sys
_HERE = os.path.dirname(os.path.abspath(sys.argv[0])) if (sys.argv and sys.argv[0]) else os.getcwd()
_LIB = os.path.join(_HERE, "lib_voltage.sage")
load(_LIB if os.path.exists(_LIB) else "lib_voltage.sage")

NFAIL = 0

def check(cond, msg):
    global NFAIL
    if not cond:
        NFAIL += 1
        print("    *** FAIL: " + msg)


print("=" * 78)
print("D. 命題 7.2: bouquet（m=1）では content_z(det L) = ループ重複度の gcd")
print("=" * 78)
print("   ＝ μ_ℓ > 0 になるのは『全ての a で ℓ | m_a』の自明例のみ。")
print()

from collections import Counter

BOUQUETS = [
    [1], [1, 1], [1, 2], [1, 1, 2, 2], [2, 2, 2], [1, 2, 3],
    [3, 3, 3, 3], [1, 1, 1, 5, 5, 5], [0, 1, 1], [0, 0, 2, 2],
    # 追加: 負 voltage（±a を同一視する規約の確認）と、ℓ 重の非自明な組み合わせ
    [-1, 1], [1, -1, 2, -2], [2, 2, 4, 4, 4],
    [1, 1, 1, 1, 3, 3, 3, 3], [1, 2, 2, 3, 3, 3],
]

for loops in BOUQUETS:
    edges = [(0, 0, a) for a in loops]
    D = detL(1, edges)
    if D == 0:
        # voltage 0 のみ → L(z) ≡ 0。content は定義されない（判定式の仮定外）。
        check(all(a == 0 for a in loops), f"loops={loops} で D ≡ 0 になったが voltage 0 のみではない")
        print(f"  loops={loops}: det L ≡ 0（voltage 0 のみ。content 未定義＝仮定外）")
        continue
    cnt = Counter(abs(a) for a in loops if a != 0)
    g = gcd(list(cnt.values()))
    c = content_z(D)
    check(c == g, f"bouquet content が loops={loops} で破れた: {c} vs {g}")
    # μ_ℓ > 0 ⟺ ℓ | 全ての m_a を素数ごとに確認する（命題 7.2 の帰結）。
    ok_mu = True
    for ell in [2, 3, 5, 7]:
        mu = ZZ(c).valuation(ell)
        all_div = all(ell.divides(v) for v in cnt.values())
        if (mu > 0) != all_div:
            ok_mu = False
    check(ok_mu, f"『μ_ℓ>0 ⟺ 全ての m_a が ℓ で割れる』が loops={loops} で破れた")
    print(f"  loops={loops}: det L = {D}")
    print(f"      m_a = {dict(sorted(cnt.items()))}, gcd_a m_a = {g}, content_z = {c}, 一致 = {c == g}")

print()
print("=" * 78)
print(f"FAIL 数: {NFAIL}")
print("=" * 78)
