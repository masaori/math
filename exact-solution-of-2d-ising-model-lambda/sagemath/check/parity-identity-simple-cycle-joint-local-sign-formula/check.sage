"""一辺二と一辺三の単純閉路鍵を同時に満たす局所符号式を探す。

対象: claim_kac_ward_determinant_fiber_stratified_phase_sum。

parity-identity-simple-cycle-local-sign-formula-extension では、一辺二で
解いた 16 項の局所式が一辺三の 3,246 鍵で頂点項と食い違うことを固定した。
そこで一辺二の全 320 鍵と、一辺三の自明文字を持つ単純閉路の D が空の鍵
312 件・選択集合が非空で 1 <= |D| <= 2 の鍵 6,453 件を一つの F_2 線型系に
載せ、次の三段で判定する。

(1) 直接衝突: 奇数回現れる局所署名の集合が等しいのに頂点項が異なる鍵対が
    あるか。あれば、頂点和が署名の関数である限りどんな局所式も存在しない。
(2) 存在: 署名ごとの値を自由に選ぶ局所式（署名の任意関数）が線型系として
    解けるか。
(3) 最小次数: 解けるなら、署名成分の単項式特徴で書ける最小の次数と、
    核ベクトルで支持台を縮めた表示。

有限集合、F_2、整数、Q(zeta_8) の厳密演算だけを使い、浮動小数点は使わない。
"""

from itertools import combinations

load("sagemath/check/parity-identity-simple-cycle-local-sign-formula/check.sage")


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
assert len(joint_keys) == 320

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
assert len(cycles_three) == 312

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
assert nonempty_count == 6453
assert len(joint_keys) == 320 + 312 + 6453

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

print("JOINT: keys=%d distinct-odd-signature-rows=%d direct-conflicts=%d"
      % (len(joint_keys), len(row_records), len(conflict_pairs)))
assert len(joint_keys) == 7085
assert len(row_records) == 7084
assert len(conflict_pairs) == 0

if conflict_pairs:
    key_a, key_b, row = conflict_pairs[0]
    side_a, doubled_a, single_a = key_a
    side_b, doubled_b, single_b = key_b
    print("CONFLICT: L=%s D=%s E=%s ↔ L=%s D=%s E=%s"
          % (side_a, tuple(sorted(doubled_a)), tuple(sorted(single_a)),
             side_b, tuple(sorted(doubled_b)), tuple(sorted(single_b))))
    print("PASS: 奇署名集合が等しく頂点項が異なる鍵対があるため、"
          "署名の関数の頂点和で両辺長を同時に書く局所式は存在しない")
else:
    row_list = sorted(
        row_records.items(),
        key=lambda item: tuple(sorted(item[0])))
    joint_signatures = sorted({
        signature for row, _ in row_list for signature in row})
    membership_matrix = matrix(GF(2), [
        [GF(2)(1) if signature in row else GF(2)(0)
         for signature in joint_signatures]
        for row, _ in row_list
    ])
    term_vector = vector(GF(2), [record[0] for _, record in row_list])
    try:
        free_solution = membership_matrix.solve_right(term_vector)
        free_exists = True
    except ValueError:
        free_exists = False
    print("FREE-VALUES: signatures=%d rank=%d solvable=%s"
          % (len(joint_signatures), membership_matrix.rank(), free_exists))
    assert len(joint_signatures) == 274
    assert membership_matrix.rank() == 246

    if not free_exists:
        print("PASS: 直接衝突は無いが、署名ごとの値を自由に選んでも"
              "頂点和の線型系に解が無く、両辺長を同時に満たす局所式は"
              "存在しない")
    else:
        signature_values_joint = [
            signature_variables(signature)
            for signature in joint_signatures]
        joint_feature_classes = tuple(
            ("全変数の次数 %d 以下" % degree,
             monomials_up_to_degree(ALL_VARIABLES, degree))
            for degree in range(1, len(ALL_VARIABLES) + 1)
        )
        chosen_joint = None
        for class_name, monomials in joint_feature_classes:
            feature_rows = [
                vector(GF(2), [
                    evaluate_monomial(monomial, values)
                    for monomial in monomials])
                for values in signature_values_joint]
            signature_index = {
                signature: index
                for index, signature in enumerate(joint_signatures)}
            joint_matrix = matrix(GF(2), [
                sum((feature_rows[signature_index[signature]]
                     for signature in row),
                    vector(GF(2), len(monomials)))
                for row, _ in row_list
            ])
            try:
                solution = joint_matrix.solve_right(term_vector)
            except ValueError:
                print("CLASS %s: 解なし（特徴 %d 個）"
                      % (class_name, len(monomials)))
                continue
            kernel_basis = joint_matrix.right_kernel().basis()
            sparse_solution = sparsify(solution, kernel_basis)
            support_joint = [
                monomials[index]
                for index in range(len(monomials))
                if sparse_solution[index] != 0]
            print("CLASS %s: 解あり（特徴 %d 個、核次元 %d、支持台 %d 項）"
                  % (class_name, len(monomials), len(kernel_basis),
                     len(support_joint)))
            chosen_joint = (class_name, support_joint)
            break

        assert chosen_joint is not None
        class_name, support_joint = chosen_joint
        for monomial in support_joint:
            print("TERM: %s"
                  % ("1" if not monomial else "*".join(monomial),))

        def joint_formula_value(signature):
            values = signature_variables(signature)
            return sum(
                evaluate_monomial(monomial, values)
                for monomial in support_joint)

        for side, doubled, single, term in joint_keys:
            vertices = sorted({
                endpoint
                for edge in doubled.union(single)
                for endpoint in base_endpoints(side, edge)
            })
            formula_value = sum(
                joint_formula_value(
                    relative_vertex_signature(side, vertex, doubled, single))
                for vertex in vertices)
            assert formula_value == term
        print("PASS: 一辺二の全 320 鍵と一辺三の全 %d 鍵の頂点項は、"
              "クラス「%s」の閉じた局所式（%d 項）の頂点和で同時に書ける"
              % (312 + 6453, class_name, len(support_joint)))
