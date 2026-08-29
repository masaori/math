# 対象ラベル: claim_finite_self_map_injective_iff_surjective
# 有限集合上の自己写像について、単射性と全射性が同値であることを検査する。
# 併せて、証明が使う数え上げの各段（|Im F| ≤ |A^V|、|Im F| = |A^V| ⟺ Im F = A^V、
# 単射なら |Im F| = |A^V|、非単射なら |Im F| ≤ |A^V| - 1）を別々に検査する。
# 帰属: 有限集合と非負整数の等号・大小比較だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

tested_maps = 0
injective_maps = 0
for name, mapping in exhaustive_maps_with_larger_stage():
    state_count = len(mapping)
    image = image_of(mapping)
    injective = is_injective_by_definition(mapping)
    surjective = is_surjective_by_definition(mapping)

    # 前段: 部分集合の個数と、個数が等しいことと集合が等しいことの同値
    assert len(image) <= state_count, name
    assert (len(image) == state_count) == (image == frozenset(range(state_count))), name

    # (⇒): 単射なら A^V → Im F が全単射なので個数が等しい
    if injective:
        assert len(image) == state_count, name
        injective_maps += 1
    # (⇐) の対偶: 単射でなければ Im F = { F y : y ∈ B }, |B| = |A^V| - 1 なので |Im F| ≤ |A^V| - 1
    else:
        collisions = [
            (y0, y1)
            for y0 in range(state_count)
            for y1 in range(state_count)
            if y0 != y1 and mapping[y0] == mapping[y1]
        ]
        assert collisions, name
        y0, y1 = collisions[0]
        B = [y for y in range(state_count) if y != y1]
        assert len(B) == state_count - 1, name
        assert image == frozenset(mapping[y] for y in B), name
        assert len(image) <= state_count - 1, name

    # 主張本体
    assert injective == surjective, name
    tested_maps += 1

print("maps checked: {}; injective maps among them: {}".format(tested_maps, injective_maps))
print("RESULT: PASS")
