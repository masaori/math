"""同じ接触対が平滑化後も切り替え可能で、同じ対での平滑化が対合であることを厳密検査する。

対象: claim_contact_smoothing_same_pair_involution。

一辺 L=2 のトーラスの全非後退置換について、切り替え可能な接触対を全列挙し、
像を交換した置換でも同じ対が切り替え可能な接触対の三条件を満たすこと、
証明が使う等式（psi(f)=phi(e)、psi(e)=phi(f)、非後退性からの後続所属）、
および同じ対で再び平滑化すると元の置換へ戻ることを有限集合の等号で検査する。
浮動小数点は使わない。
"""

load("sagemath/check/contact-smoothing-same-pair-involution/construction.sage")

# 構成側でも回している文をここでもう一度回すので、累算器を初期化し直す
# （初期化が構成側にしかないと、構成での実行ぶんへ二重に足し込む）。
checked = 0
permutations_with_pair = 0

for phi in nonbacktracking_permutations:
    pairs = switchable_contact_pairs(phi)
    if pairs:
        permutations_with_pair += 1
    for edge, other in pairs:
        psi = smooth(phi, edge, other)

        # 証明の第二・第三条件が使う等式: 像の交換と、非後退性からの後続所属。
        assert psi[other] == phi[edge] and psi[edge] == phi[other]
        assert phi[edge] in successor_lists[edge]
        assert phi[other] in successor_lists[other]

        # 同じ対が psi の切り替え可能な接触対である（三条件をそのまま判定する）。
        assert is_switchable_contact_pair(psi, edge, other)

        # 同じ対での平滑化は対合である。
        assert smooth(psi, edge, other) == phi
        checked += 1

assert permutations_with_pair > 0
assert checked > 0
print("PASS: L=%d 非後退置換 %d 個中、切り替え可能な接触対を持つ置換 %d 個、接触対 %d 件で対合性を検査"
      % (L, len(nonbacktracking_permutations), permutations_with_pair, checked))
