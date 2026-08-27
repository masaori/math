# 対象ラベル: claim_neighborhood_assignment_monoid_center_characterization
# 本文の証明の第二段。N ∈ Z_star(V) かつ q ∈ N(p) のとき p = q であることを、本文の順に分けて検査する。
#   q ∈ (N star E_{q,q})(p)          (q ∈ N(p) かつ q ∈ E_{q,q}(q))
#   N star E_{q,q} = E_{q,q} star N   (中心の定義)
#   q ∈ (E_{q,q} star N)(p)
#   p ≠ q なら (E_{q,q} star N)(p) = ∪_{u in ∅} N(u) = ∅ で矛盾
# したがって p = q、すなわち p ∈ N(p) を得る。
# 第四段（N(v) ⊆ I_V(v)）も同じ証人 E_{w,w} を使うので、同じ形で別に検査する。
# 帰属: 有限集合と有限写像表だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

membership_count = 0
central_count = 0
edge_case_count = 0

for n in (0, 1, 2, 3):
    cells = tuple(range(n))
    # 証人 E_{q,q} の値の表そのものを定義から確認する
    for q in cells:
        E = single_edge(cells, q, q)
        for v in cells:
            assert E[v] == (frozenset((q,)) if v == q else frozenset())
            edge_case_count += 1

    for N in neighborhood_assignments(cells):
        if not is_central(cells, N):
            continue
        central_count += 1
        for p in cells:
            for q in cells:
                if q not in N[p]:
                    continue
                membership_count += 1
                E = single_edge(cells, q, q)
                left = compose(cells, N, E)
                right = compose(cells, E, N)
                # 第一段: q ∈ N(p) かつ q ∈ E_{q,q}(q) から q ∈ (N star E_{q,q})(p)
                assert q in E[q]
                assert q in left[p]
                # 第二段: 中心の定義による二つの合成の等号
                assert left == right
                # 第三段: したがって q ∈ (E_{q,q} star N)(p)
                assert q in right[p]
                # 第四段: p ≠ q なら E_{q,q}(p) = ∅ なので右辺は空集合となり矛盾する
                if p != q:
                    assert E[p] == frozenset()
                    assert right[p] == frozenset()
                    raise AssertionError("p != q が中心の元で起きた")
                assert p == q
                # 得られた結論: p ∈ N(p)
                assert p in N[p]

        # 本文の最終段 N(v) ⊆ I_V(v) も同じ証人で検査する
        for v in cells:
            for w in N[v]:
                E = single_edge(cells, w, w)
                assert compose(cells, N, E) == compose(cells, E, N)
                assert w in compose(cells, N, E)[v]
                assert w in compose(cells, E, N)[v]
                assert v == w
            assert N[v] <= identity_assignment(cells)[v]

print("PASS check_self_loop_from_edge_witness")
print("  central assignments scanned:", central_count)
print("  membership witnesses checked:", membership_count)
print("  single edge table cases:", edge_case_count)
