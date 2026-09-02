"""経路反転が標準接触対に依存する分類を保たないことを厳密検査する。

対象: claim_path_reversal_contact_pair_preservation と
def_standard_turning_difference_subsets、def_unswitchable_standard_pair_subset。

一辺 L=2 の全非後退置換について、接触の無い部分、位相反転部分 B_L、
回転差 -4, 4 の部分、残余 R_L の間で経路反転が作る遷移を数える。
接触の無い部分だけは保たれる一方、標準接触対に依存する四部分の間には
実際に移る置換があることを有限集合と整数の等号だけで確認する。
"""

load("sagemath/check/path-reversal-contact-pair-preservation/check.sage")


def standard_pair_delta(phi):
    edge, other = tuple(ct_min(phi))
    return (
        step_turning(edge, phi[edge]) + step_turning(other, phi[other])
        - step_turning(edge, phi[other]) - step_turning(other, phi[edge])
    )


def standard_class(phi):
    pairs = contact_pairs(phi)
    if not pairs:
        return "contact-free"
    edge, other = tuple(ct_min(phi))
    if not is_switchable_contact_pair(phi, edge, other):
        return "residual"
    delta = standard_pair_delta(phi)
    if delta == 0:
        return "phase-reversing"
    assert delta in (-4, 4)
    return "turning-%+d" % delta


transition_counts = {}
for phi in nonbacktracking_permutations:
    transition = (standard_class(phi), standard_class(path_reversal(phi)))
    transition_counts[transition] = transition_counts.get(transition, 0) + 1

assert transition_counts[("contact-free", "contact-free")] == 49
assert all(
    target == "contact-free"
    for (source, target), count in transition_counts.items()
    if source == "contact-free" and count > 0
)

# 標準対に依存する分類は保存されない。それぞれ実例が存在する。
assert transition_counts[("residual", "phase-reversing")] == 1416
assert transition_counts[("residual", "turning--4")] == 384
assert transition_counts[("residual", "turning-+4")] == 520
assert transition_counts[("phase-reversing", "turning--4")] == 136
assert transition_counts[("turning--4", "turning-+4")] == 1548

# 経路反転が対合なので遷移数は向きを反転しても等しい。
for (source, target), count in transition_counts.items():
    assert transition_counts[(target, source)] == count

print("PASS: L=%d の非後退置換 %d 個で経路反転による標準対分類の遷移を全数検査。"
      "接触なしは %d 個で保存。R->B %d、R->A(-4) %d、R->A(+4) %d、"
      "B->A(-4) %d、A(-4)->A(+4) %d の非保存例を確認"
      % (L, len(nonbacktracking_permutations),
         transition_counts[("contact-free", "contact-free")],
         transition_counts[("residual", "phase-reversing")],
         transition_counts[("residual", "turning--4")],
         transition_counts[("residual", "turning-+4")],
         transition_counts[("phase-reversing", "turning--4")],
         transition_counts[("turning--4", "turning-+4")]))
