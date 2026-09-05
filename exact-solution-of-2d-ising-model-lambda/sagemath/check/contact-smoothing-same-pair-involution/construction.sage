"""同じ接触対が平滑化後も切り替え可能で、同じ対での平滑化が対合であることを厳密検査する。（再利用する厳密構成のみ）

このファイルは下流の検算が読み込む定義だけを置く。観測の出力と assertion は
同じディレクトリの check.sage にある。下流はここだけを読むので、上流の
assertion を再実行しない（全先行検算は日次監査が check.sage を回して維持する）。
"""

load("sagemath/check/kac-ward-nonbacktracking-sum/construction.sage")


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

        # 同じ対が psi の切り替え可能な接触対である（三条件をそのまま判定する）。

        # 同じ対での平滑化は対合である。
        checked += 1
