"""同じ接触対が平滑化後も切り替え可能で、同じ対での平滑化が対合であることを厳密検査する。

対象: claim_contact_smoothing_same_pair_involution。

一辺 L=2 のトーラスの全非後退置換について、切り替え可能な接触対を全列挙し、
像を交換した置換でも同じ対が切り替え可能な接触対の三条件を満たすこと、
証明が使う等式（psi(f)=phi(e)、psi(e)=phi(f)、非後退性からの後続所属）、
および同じ対で再び平滑化すると元の置換へ戻ることを有限集合の等号で検査する。
浮動小数点は使わない。
"""

load("sagemath/check/kac-ward-nonbacktracking-sum/check.sage")


def moved_edges(phi):
    return {edge for edge in oriented if phi[edge] != edge}


def is_switchable_contact_pair(phi, edge, other):
    if edge == other:
        return False
    moved = moved_edges(phi)
    if edge not in moved or other not in moved:
        return False
    if endpoints(L, edge)[1] != endpoints(L, other)[1]:
        return False
    if phi[other] not in successor_lists[edge] or phi[edge] not in successor_lists[other]:
        return False
    if phi[other] == edge or phi[edge] == other:
        return False
    return True


def switchable_contact_pairs(phi):
    moved = [edge for edge in oriented if phi[edge] != edge]
    pairs = []
    for i in range(len(moved)):
        for j in range(i + 1, len(moved)):
            if is_switchable_contact_pair(phi, moved[i], moved[j]):
                pairs.append((moved[i], moved[j]))
    return pairs


def smooth(phi, edge, other):
    result = dict(phi)
    result[edge] = phi[other]
    result[other] = phi[edge]
    return result


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
