"""未ねじれの配向類の符号同定を一つの F_2 偶奇恒等式へ還元する。（再利用する厳密構成のみ）

このファイルは下流の検算が読み込む定義だけを置く。観測の出力と assertion は
同じディレクトリの check.sage にある。下流はここだけを読むので、上流の
assertion を再実行しない（全先行検算は日次監査が check.sage を回して維持する）。
"""

load("sagemath/check/selection-common-sign-closed-formula/construction.sage")


def inversion_parity(items, reordered):
    positions = {item: index for index, item in enumerate(items)}
    sequence = [positions[item] for item in reordered]
    return sum(
        ZZ(sequence[left] > sequence[right])
        for left in range(len(sequence))
        for right in range(left + 1, len(sequence))
    ) % 2


def untwisted_sign_exponent(side, doubled, single, orientation):
    moved = frozenset(
        [base + (d,) for base in doubled for d in (0, 1)]
        + [base + (orientation[base],) for base in single]
    )
    ordered = sorted(moved)
    vertices = sorted({endpoints(side, edge)[0] for edge in ordered})
    row_order = sorted(ordered, key=lambda edge: (endpoints(side, edge)[1], edge))
    column_order = sorted(ordered, key=lambda edge: (endpoints(side, edge)[0], edge))
    row_parity = inversion_parity(ordered, row_order)
    column_parity = inversion_parity(ordered, column_order)

    local_product = K8(1)
    for vertex in vertices:
        incoming = [edge for edge in row_order
                    if endpoints(side, edge)[1] == vertex]
        outgoing = [edge for edge in column_order
                    if endpoints(side, edge)[0] == vertex]
        local_matrix = matrix(K8, [
            [K8(transition_entry(side, 0, 0, edge, successor))
             for successor in outgoing]
            for edge in incoming
        ])
        local_product *= local_matrix.det()

    n_four = degree_four_count(side, single) if single else ZZ(0)
    normalized = local_product / K8(ZZ(2) ** n_four)
    assert normalized in (K8(1), K8(-1))
    local_phase_parity = ZZ(normalized == K8(-1))
    exponent = (ZZ(len(moved)) + row_parity + column_parity
                + local_phase_parity) % 2
    reconstructed = K8((-1) ** exponent * ZZ(2) ** n_four)
    actual = class_sum_by_local_formula(
        side, doubled, single, orientation, 0, 0)
    assert reconstructed == actual
    return exponent


def target_exponent(side, doubled, single, selector):
    eh, ev = subset_parities(side, single)
    a_h, a_v = subset_parities(side, doubled.union(selector))
    intersection = (a_h * ev + eh * a_v) % 2
    return (eh + ev + eh * ev + intersection) % 2
