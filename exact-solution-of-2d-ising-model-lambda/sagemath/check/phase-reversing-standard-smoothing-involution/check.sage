"""標準対平滑化が位相反転部分集合の上で符号反転対合であることを厳密検査する。

対象: claim_phase_reversing_standard_smoothing_involution。

一辺 L=2 のトーラスの全非後退置換から、標準接触対 ct_min(phi) が切り替え可能な
置換の集合 A_L と、その中で ct_min(phi) が位相反転接触対（二接続の回転数和が
平滑化前後で等しい）である部分集合 B_L を作る。B_L の各元について、標準対平滑化
S(phi) = Sm_{ct_min(phi)}(phi) が B_L に留まり、二回適用で元へ戻り、不動点を持たず、
M・D・E_1 を保ち、四つのスピン構造すべてで位相寄与 W の符号を反転することを
Q(zeta_8) と整数の等号だけで検査する。浮動小数点は使わない。
"""

load("sagemath/check/phase-reversing-standard-smoothing-involution/construction.sage")

members = [phi for phi in nonbacktracking_permutations if in_B(phi)]
in_A_count = 0
for phi in nonbacktracking_permutations:
    if contact_pairs(phi):
        pair = tuple(ct_min(phi))
        if is_switchable_contact_pair(phi, pair[0], pair[1]):
            in_A_count += 1

sign_checked = 0
for phi in members:
    pair = tuple(ct_min(phi))
    psi = smooth(phi, pair[0], pair[1])

    # S(phi) が B_L に属する。
    assert in_B(psi)

    # 対合: 標準対が不変（claim_contact_pair_set_smoothing_invariant）なので同じ対で戻る。
    assert ct_min(psi) == frozenset(pair)
    assert smooth(psi, pair[0], pair[1]) == phi

    # 不動点なし。
    assert psi != phi

    # ファイバー保存: M・D・E_1 が変わらない。
    assert moved_edges(psi) == moved_edges(phi)
    assert doubled_and_single_sets(psi) == doubled_and_single_sets(phi)

    # 位相寄与の符号反転（四つのスピン構造すべて）。
    for a in (0, 1):
        for b in (0, 1):
            before = contributions[permutation_key(phi)][(a, b)]
            after = contributions[permutation_key(psi)][(a, b)]
            assert before != 0
            assert after == -before
            sign_checked += 1

assert len(members) > 0
assert sign_checked == 4 * len(members)
print("PASS: L=%d 非後退置換 %d 個中、A_L は %d 個、B_L は %d 個。"
      "B_L 全数で符号反転対合・不動点なし・ファイバー保存を検査（符号反転 %d 件）"
      % (L, len(nonbacktracking_permutations), in_A_count, len(members), sign_checked))
