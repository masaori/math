"""選択集合の局所所属を署名へ加えた合同局所符号式の検査。

対象: claim_kac_ward_determinant_fiber_stratified_phase_sum。

parity-identity-simple-cycle-joint-duplicate-adjacency では、上下左右の
スロットの D/E 所属・切断隣接旗に重複隣接旗二つを加えても、一辺二と
一辺三の単純閉路鍵の頂点項を同時に書く局所式が無く、不足は一辺三の
D が非空の鍵で閉路上を伝播する選択情報にあると同定した。そこで各鍵の
辞書式最小の選択 C（key_terms が使う選択子と同じ規約）について、四つの
スロットの C 所属 c_s を署名へ加え、次の三段で判定する。

(1) 直接衝突: 拡張署名の奇数回現れる集合が等しいのに頂点項が異なる
    鍵対があるか。
(2) 存在: 署名ごとの値を自由に選ぶ局所式が合同の F_2 線型系として
    解けるか。一辺三単独でも判定する。
(3) 最小次数: 解けるなら、16 変数（d_s, e_s, c_s, 切断旗）の単項式
    特徴で書ける最小の次数と、核ベクトルで支持台を縮めた表示。

有限集合、F_2、整数、Q(zeta_8) の厳密演算だけを使い、浮動小数点は使わない。
"""

load("sagemath/check/parity-identity-simple-cycle-joint-local-sign-formula/check.sage")


def selector_vertex_signature(side, vertex, doubled, single, chosen):
    memberships = tuple(
        (name, ZZ(base in doubled), ZZ(base in single), ZZ(base in chosen))
        for name, base in incident_base_slots(side, vertex)
    )
    return memberships, vertex_wrap_flags(side, vertex)


def selector_odd_signature_row(side, doubled, single):
    chosen = key_selector(side, doubled, single)
    vertices = sorted({
        endpoint
        for edge in doubled.union(single)
        for endpoint in base_endpoints(side, edge)
    })
    counts = {}
    for vertex in vertices:
        signature = selector_vertex_signature(
            side, vertex, doubled, single, chosen)
        counts[signature] = counts.get(signature, ZZ(0)) + 1
    return frozenset(signature for signature, count in counts.items()
                     if count % 2 == 1)


row_records = {}
conflict_pairs = []
for side_key, doubled, single, term in joint_keys:
    row = selector_odd_signature_row(side_key, doubled, single)
    if row in row_records:
        previous_term, previous_key = row_records[row]
        if previous_term != term:
            conflict_pairs.append(
                (previous_key, (side_key, doubled, single), row))
    else:
        row_records[row] = (term, (side_key, doubled, single))

print("SELECTOR: keys=%d distinct-odd-signature-rows=%d direct-conflicts=%d"
      % (len(joint_keys), len(row_records), len(conflict_pairs)))
assert len(joint_keys) == 7085
assert len(conflict_pairs) == 0

row_list = sorted(
    row_records.items(),
    key=lambda item: tuple(sorted(item[0])))
selector_signatures = sorted({
    signature for row, _ in row_list for signature in row})
membership_matrix = matrix(GF(2), [
    [GF(2)(1) if signature in row else GF(2)(0)
     for signature in selector_signatures]
    for row, _ in row_list
])
term_vector = vector(GF(2), [record[0] for _, record in row_list])
try:
    membership_matrix.solve_right(term_vector)
    joint_solvable = True
except ValueError:
    joint_solvable = False
print("FREE-VALUES: signatures=%d rank=%d solvable=%s"
      % (len(selector_signatures), membership_matrix.rank(), joint_solvable))
assert len(selector_signatures) == 452
assert membership_matrix.rank() == 408
assert not joint_solvable

for selected_side, expected_keys, expected_signatures, expected_rank, expected_solvable in (
        (ZZ(2), 320, 172, 122, True),
        (ZZ(3), 6765, 432, 378, False)):
    selected = [
        (selector_odd_signature_row(side_key, doubled, single), term)
        for side_key, doubled, single, term in joint_keys
        if side_key == selected_side
    ]
    selected_signature_list = sorted({
        signature for row, _ in selected for signature in row})
    selected_matrix = matrix(GF(2), [
        [GF(2)(1) if signature in row else GF(2)(0)
         for signature in selected_signature_list]
        for row, _ in selected
    ])
    selected_terms = vector(GF(2), [term for _, term in selected])
    try:
        selected_matrix.solve_right(selected_terms)
        selected_solvable = True
    except ValueError:
        selected_solvable = False
    print("L=%d: keys=%d signatures=%d rank=%d solvable=%s"
          % (selected_side, len(selected), len(selected_signature_list),
             selected_matrix.rank(), selected_solvable))
    assert len(selected) == expected_keys
    assert len(selected_signature_list) == expected_signatures
    assert selected_matrix.rank() == expected_rank
    assert selected_solvable == expected_solvable

if joint_solvable:
    SELECTOR_SLOT_VARIABLES = tuple(
        prefix + name
        for name in SLOT_NAMES for prefix in ("d_", "e_", "c_"))
    SELECTOR_ALL_VARIABLES = SELECTOR_SLOT_VARIABLES + FLAG_VARIABLES

    def selector_signature_variables(signature):
        memberships, flags = signature
        values = {}
        for name, in_doubled, in_single, in_chosen in memberships:
            values["d_" + name] = GF(2)(in_doubled)
            values["e_" + name] = GF(2)(in_single)
            values["c_" + name] = GF(2)(in_chosen)
        for flag_name, flag in zip(FLAG_NAMES, flags):
            values[flag_name] = GF(2)(flag)
        return values

    signature_values_selector = [
        selector_signature_variables(signature)
        for signature in selector_signatures]
    signature_index = {
        signature: index
        for index, signature in enumerate(selector_signatures)}
    chosen_class = None
    for degree in range(1, 5):
        class_name = "全変数の次数 %d 以下" % degree
        monomials = monomials_up_to_degree(SELECTOR_ALL_VARIABLES, degree)
        feature_rows = [
            vector(GF(2), [
                evaluate_monomial(monomial, values)
                for monomial in monomials])
            for values in signature_values_selector]
        feature_matrix = matrix(GF(2), [
            sum((feature_rows[signature_index[signature]]
                 for signature in row),
                vector(GF(2), len(monomials)))
            for row, _ in row_list
        ])
        try:
            solution = feature_matrix.solve_right(term_vector)
        except ValueError:
            print("CLASS %s: 解なし（特徴 %d 個）"
                  % (class_name, len(monomials)))
            continue
        kernel_basis = feature_matrix.right_kernel().basis()
        sparse_solution = sparsify(solution, kernel_basis)
        support = [
            monomials[index]
            for index in range(len(monomials))
            if sparse_solution[index] != 0]
        print("CLASS %s: 解あり（特徴 %d 個、核次元 %d、支持台 %d 項）"
              % (class_name, len(monomials), len(kernel_basis), len(support)))
        for monomial in support:
            print("TERM: %s" % ("1" if not monomial else "*".join(monomial),))
        chosen_class = (class_name, support)
        break

    if chosen_class is not None:
        class_name, support = chosen_class

        def selector_formula_value(signature):
            values = selector_signature_variables(signature)
            return sum(
                evaluate_monomial(monomial, values)
                for monomial in support)

        for side_key, doubled, single, term in joint_keys:
            chosen = key_selector(side_key, doubled, single)
            vertices = sorted({
                endpoint
                for edge in doubled.union(single)
                for endpoint in base_endpoints(side_key, edge)
            })
            formula_value = sum(
                selector_formula_value(selector_vertex_signature(
                    side_key, vertex, doubled, single, chosen))
                for vertex in vertices)
            assert formula_value == term
        print("PASS: 選択所属を加えた署名により、一辺二と一辺三の全 %d 鍵の"
              "頂点項がクラス「%s」の閉じた局所式（%d 項）の頂点和で"
              "同時に書ける" % (len(joint_keys), class_name, len(support)))
    else:
        print("RESULT: 署名の任意関数としては解けるが、次数 4 以下の"
              "単項式特徴では書けない")
else:
    print("PASS: 選択所属 c_s を加えても、署名ごとの値を自由に選ぶ頂点和の"
          "線型系に解が無く、一辺三単独でも解が無い。一辺三の頂点項は"
          "選択を含む頂点局所署名だけでは決まらない")
