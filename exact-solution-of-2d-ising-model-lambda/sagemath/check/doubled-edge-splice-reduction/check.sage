"""完全切り替え不能な残余で、反転対の辺を台から除く縮約候補を調べる。

対象: claim_fully_unswitchable_contacts_witness_doubled_edges。

一辺 L=2 の完全切り替え不能な残余と、その各接触対が指す反転対の辺について、
二つの向きを置換の巡回から同時に抜いて固定点へ戻す写像を作る。縮約後が置換か、
非後退か、反転対 D と単純通過辺 E がどう変わるかを有限集合の等号で調べる。
浮動小数点は使わない。
"""

load("sagemath/check/fully-unswitchable-contacts-witness-doubled-edges/check.sage")


def splice_out_doubled_edge(phi, base):
    forward = base + (0,)
    backward = base + (1,)
    inverse = {image: edge for edge, image in phi.items()}
    result = dict(phi)
    result[inverse[forward]] = phi[forward]
    result[inverse[backward]] = phi[backward]
    result[forward] = forward
    result[backward] = backward
    return result


checked = 0
permutation_count = 0
nonbacktracking_count = 0
fiber_reduction_count = 0
first_backtracking = None
first_nonbacktracking = None
for phi in nonbacktracking_permutations:
    pairs = contact_pairs(phi)
    if not pairs or any(is_switchable_contact_pair(phi, *tuple(pair)) for pair in pairs):
        continue

    doubled, single = doubled_and_single_sets(phi)
    witnesses = set()
    for pair in pairs:
        edge, other = tuple(pair)
        pair_witnesses = {base for base in (edge[:3], other[:3]) if base in doubled}
        assert pair_witnesses
        witnesses.update(pair_witnesses)
    for base in witnesses:
        reduced = splice_out_doubled_edge(phi, base)
        is_permutation = (set(reduced.keys()) == set(oriented)
                          and set(reduced.values()) == set(oriented)
                          and len(set(reduced.values())) == len(oriented))
        if is_permutation:
            permutation_count += 1
        bad_connections = {
            (current, reduced[current]) for current in oriented
            if reduced[current] != current and reduced[current] not in successor_lists[current]
        }
        is_nonbacktracking = is_permutation and not bad_connections
        if is_nonbacktracking:
            nonbacktracking_count += 1
            reduced_doubled, reduced_single = doubled_and_single_sets(reduced)
            if reduced_doubled == doubled.difference({base}) and reduced_single == single:
                fiber_reduction_count += 1
            if first_nonbacktracking is None:
                first_nonbacktracking = (base, doubled, single,
                                         reduced_doubled, reduced_single)
        elif first_backtracking is None:
            first_backtracking = (base, bad_connections)
        checked += 1

assert checked > 0
assert permutation_count == checked
assert checked == 2912
assert nonbacktracking_count == 32
assert fiber_reduction_count == 0
print("PASS: L=%d の完全切り替え不能な残余の接触が指す反転対 %d 件について、"
      "巡回から二方向を抜く縮約は置換 %d 件、非後退 %d 件、D だけを一辺減らすもの %d 件"
      % (L, checked, permutation_count, nonbacktracking_count, fiber_reduction_count))
if first_backtracking is not None:
    print("非後退でない最初の例（反転対の辺、新しく生じた不許可接続）:", first_backtracking)
if first_nonbacktracking is not None:
    print("非後退になる最初の例（除いた辺、元の D,E、縮約後の D,E）:",
          first_nonbacktracking)
