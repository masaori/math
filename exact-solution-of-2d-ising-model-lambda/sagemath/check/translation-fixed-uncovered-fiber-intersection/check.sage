"""平行移動固定ファイバーと単一偶部分グラフで覆えないファイバーの交わりを検査する。

対象: claim_selection_even_subgraph_action_character,
      claim_selection_sum_character_evaluation。

一辺 L=2 の巻き付き文字が非自明なファイバーについて、単一の偶部分グラフ H では
全置換を一様被覆できない 16 鍵と、非零平行移動で固定される鍵を直接突き合わせる。
計算は有限集合と有限写像の等号だけで行う。
"""

load("sagemath/check/even-subgraph-fiberwise-uniform-matching/check.sage")


def translate_base_edge(shift, edge):
    kind, i, j = edge
    a, b = shift
    return (kind, (i + a) % L, (j + b) % L)


def translate_fiber_key(shift, fiber_key):
    doubled, single = fiber_key
    return (
        frozenset(translate_base_edge(shift, edge) for edge in doubled),
        frozenset(translate_base_edge(shift, edge) for edge in single),
    )


nonzero_shifts = ((0, 1), (1, 0), (1, 1))
uncovered_set = set(uncovered_fibers)
fixed_by_shift = {
    shift: {
        fiber_key for fiber_key in all_fibers
        if translate_fiber_key(shift, fiber_key) == fiber_key
    }
    for shift in nonzero_shifts
}
fixed_uncovered_by_shift = {
    shift: fixed_keys & uncovered_set
    for shift, fixed_keys in fixed_by_shift.items()
}

assert len(uncovered_set) == 16
assert {shift: len(keys) for shift, keys in fixed_by_shift.items()} == {
    (0, 1): 35,
    (1, 0): 35,
    (1, 1): 37,
}
assert fixed_uncovered_by_shift == {shift: set() for shift in nonzero_shifts}
assert all(
    translate_fiber_key(shift, fiber_key) != fiber_key
    for fiber_key in uncovered_set
    for shift in nonzero_shifts
)

for shift in nonzero_shifts:
    print(f"shift={shift}: realized fixed fibers {len(fixed_by_shift[shift])}, "
          f"fixed and uncovered {len(fixed_uncovered_by_shift[shift])}")
print("PASS: translation-fixed-uncovered-fiber-intersection")
