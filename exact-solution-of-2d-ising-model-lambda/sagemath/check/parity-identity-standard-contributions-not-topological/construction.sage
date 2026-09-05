"""標準形の四寄与が巻き付き偶奇と交差対だけでは決まらないことを検査する。（再利用する厳密構成のみ）

このファイルは下流の検算が読み込む定義だけを置く。観測の出力と assertion は
同じディレクトリの check.sage にある。下流はここだけを読むので、上流の
assertion を再実行しない（全先行検算は日次監査が check.sage を回して維持する）。
"""

load("sagemath/check/parity-identity-standard-orientation-reduction/construction.sage")


def standard_pattern(side, doubled, single, selector):
    orientations = curved_free_orientations(side, single)
    standard, _ = standard_orientation(side, single, orientations)
    pieces, total = pair_and_seam_decomposition(
        side, doubled, single, standard)
    epsilon_h, epsilon_v = subset_parities(side, single)
    union_h, union_v = subset_parities(side, doubled.union(selector))
    crossing = (union_h * epsilon_v + epsilon_h * union_v) % 2
    topology = (epsilon_h, epsilon_v, crossing)
    assert total == (epsilon_h + epsilon_v
                     + epsilon_h * epsilon_v + crossing) % 2
    return topology, tuple(pieces)
