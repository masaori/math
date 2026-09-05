"""一辺二と一辺三の単純閉路鍵を同時に満たす局所符号式を探す。（再利用する厳密構成のみ）

このファイルは下流の検算が読み込む定義だけを置く。観測の出力と assertion は
同じディレクトリの check.sage にある。下流はここだけを読むので、上流の
assertion を再実行しない（全先行検算は日次監査が check.sage を回して維持する）。
"""

load("sagemath/check/parity-identity-simple-cycle-local-sign-formula/construction.sage")

from itertools import combinations


def subsets_of_cycle(cycle):
    ordered = tuple(sorted(cycle))
    for size in range(len(ordered) + 1):
        for chosen in combinations(ordered, size):
            yield frozenset(chosen)


def admissible_selectors(side, doubled, single):
    def is_even(edges):
        degrees = {}
        for edge in edges:
            for vertex in base_endpoints(side, edge):
                degrees[vertex] = degrees.get(vertex, ZZ(0)) + 1
        return all(value % 2 == 0 for value in degrees.values())

    return tuple(
        chosen for chosen in subsets_of_cycle(single)
        if is_even(doubled.union(chosen))
    )


def key_selector(side, doubled, single):
    # key_terms が参照する選択子をここで置き換える。単純閉路 E では選択集合が
    # 非空ならちょうど二つなので、辞書式最小を取る（extension 検査と同じ規約）。
    found = admissible_selectors(side, doubled, single)
    assert len(found) == 2
    return min(found, key=lambda item: tuple(sorted(item)))


def odd_signature_row(side, doubled, single):
    vertices = sorted({
        endpoint
        for edge in doubled.union(single)
        for endpoint in base_endpoints(side, edge)
    })
    counts = {}
    for vertex in vertices:
        signature = relative_vertex_signature(side, vertex, doubled, single)
        counts[signature] = counts.get(signature, ZZ(0)) + 1
    return frozenset(signature for signature, count in counts.items()
                     if count % 2 == 1)


joint_keys = []
for (doubled, single), vertex_term in zip(cycle_keys, vertex_terms):
    joint_keys.append((ZZ(2), doubled, single, GF(2)(vertex_term)))

side_three = ZZ(3)
edges_three = tuple(
    (kind, row, column) for kind in ("h", "v")
    for row in range(side_three) for column in range(side_three))
cycles_three = tuple(sorted((
    single for single in even_subgraphs_three
    if is_simple_cycle(side_three, single)
    and character_is_trivial_general(side_three, single)
    and curved_free_orientations(side_three, single)
), key=lambda item: tuple(sorted(item))))

for single in cycles_three:
    _, vertex_term, _, _ = key_terms(side_three, frozenset(), single)
    joint_keys.append((side_three, frozenset(), single, GF(2)(vertex_term)))

nonempty_count = ZZ(0)
for single in cycles_three:
    complement = tuple(edge for edge in edges_three if edge not in single)
    for size in (1, 2):
        for doubled_tuple in combinations(complement, size):
            doubled = frozenset(doubled_tuple)
            if not admissible_selectors(side_three, doubled, single):
                continue
            _, vertex_term, _, _ = key_terms(side_three, doubled, single)
            joint_keys.append(
                (side_three, doubled, single, GF(2)(vertex_term)))
            nonempty_count += 1

row_records = {}
conflict_pairs = []
for side, doubled, single, term in joint_keys:
    row = odd_signature_row(side, doubled, single)
    if row in row_records:
        prev_term, prev_key = row_records[row]
        if prev_term != term:
            conflict_pairs.append((prev_key, (side, doubled, single), row))
    else:
        row_records[row] = (term, (side, doubled, single))
