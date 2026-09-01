"""接触の無い非後退置換の位相積が、軌道ごとの巻き付き二次符号の積に一致することを
厳密検査する。

対象: claim_contact_free_permutation_phase_product。

一辺 L=2 のトーラスで、非後退置換を全列挙し、置換の接触対の個数
  N_ct(φ) = |{ {e,f} ⊆ M(φ) : e ≠ f, tgt(e) = tgt(f) }|
が零のものについて、四つのスピン構造 (a,b) ごとに
  Π_C ( - Π_{e∈C} M^{a,b}_{e,φ(e)} ) = Π_C χ_{a,b}(h(γ^φ_C), v(γ^φ_C))
を Q(ζ8) で比較する。併せて証明の中間段（各軌道列の通過の頂点が相異なること
= n_ct(γ^φ_C) = 0）と、基点を一つ回した選択でも右辺が変わらないことを確かめる。
浮動小数点は使わない。
"""

load("sagemath/check/kac-ward-nonbacktracking-sum/check.sage")


def permutation_contact_pair_count(phi):
    """def_permutation_contact_pair_count。M(φ) の二元部分集合で終点が一致する個数。"""
    moved = [edge for edge in oriented if phi[edge] != edge]
    count = 0
    for i in range(len(moved)):
        for j in range(i + 1, len(moved)):
            if endpoints(L, moved[i])[1] == endpoints(L, moved[j])[1]:
                count += 1
    return count


def quadratic_sign(a, b, h_parity, v_parity):
    """def_torus_quadratic_sign。χ_{a,b}(h,v) = (-1)^{hv+(1-a)h+(1-b)v}。"""
    exponent = h_parity * v_parity + (1 - a) * h_parity + (1 - b) * v_parity
    return K8(ZZ(-1) ** exponent)


def walk_parities(walk):
    """軌道列の二つの切断線偶奇 (h, v)。def_edge_sequence_seam_parities。"""
    h_parity = sum(seam_parities(L, edge)[0] for edge in walk) % 2
    v_parity = sum(seam_parities(L, edge)[1] for edge in walk) % 2
    return h_parity, v_parity


contact_free = 0
checked = 0
for index, phi in enumerate(nonbacktracking_permutations):
    if permutation_contact_pair_count(phi) != 0:
        continue
    contact_free += 1
    walks = orbits_of[index]

    # 証明の中間段: 各軌道列の通過の頂点（各項の終点）は相異なる。
    for walk in walks:
        targets = [endpoints(L, edge)[1] for edge in walk]
        assert len(set(targets)) == len(targets)

    for a in (0, 1):
        for b in (0, 1):
            entry_product = K8(1)   # 左辺: 遷移成分の軌道積
            sign_product = K8(1)    # 右辺: 二次符号の積（基点は walk の先頭）
            rotated_product = K8(1) # 右辺: 基点を一つ回した選択
            for walk in walks:
                orbit_entry = K8(1)
                for edge in walk:
                    orbit_entry *= K8(transition_entry(L, a, b, edge, phi[edge]))
                entry_product *= -orbit_entry

                h_parity, v_parity = walk_parities(walk)
                sign_product *= quadratic_sign(a, b, h_parity, v_parity)

                rotated = walk[1:] + walk[:1]
                h_rot, v_rot = walk_parities(rotated)
                rotated_product *= quadratic_sign(a, b, h_rot, v_rot)

            assert entry_product == sign_product
            assert sign_product == rotated_product
            checked += 1

assert contact_free > 0
assert checked == 4 * contact_free
print("PASS: L=%d 非後退置換 %d 個中、接触の無い置換 %d 個、検査 %d 件"
      % (L, len(nonbacktracking_permutations), contact_free, checked))
