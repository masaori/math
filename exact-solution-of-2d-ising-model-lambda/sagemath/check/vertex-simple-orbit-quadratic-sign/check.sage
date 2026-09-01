"""頂点単純閉路の軌道位相因子と巻き付き二次符号の一致を厳密検査する。

対象: claim_vertex_simple_orbit_quadratic_sign。
一辺 L=2,3,4 の全頂点単純閉路と四つのスピン構造について、
  -(-1)^(a h + b v) zeta8^t = (-1)^(h v + (1-a)h + (1-b)v)
を円分体 Q(zeta8) で比較する。浮動小数点は使わない。
"""

load("sagemath/check/vertex-simple-cycle-turning/check.sage")

K8.<zeta8> = CyclotomicField(8)

checked = 0
for L in (2, 3, 4):
    oriented = edges(L)
    successor_lists = {
        edge: [other for other in oriented
               if endpoints(L, edge)[1] == endpoints(L, other)[0]
               and other != reversal(edge)]
        for edge in oriented
    }
    for start in oriented:
        source_of_start = endpoints(L, start)[0]
        stack = [([start], frozenset([endpoints(L, start)[1]]))]
        while stack:
            walk, visited = stack.pop()
            last = walk[-1]
            if endpoints(L, last)[1] == source_of_start and start != reversal(last):
                m = len(walk)
                turning = ZZ(sum(step_turning(walk[r], walk[(r + 1) % m])
                                 for r in range(m)))
                h = ZZ(sum(directed_winding(edge, L)[0] for edge in walk) % 2)
                v = ZZ(sum(directed_winding(edge, L)[1] for edge in walk) % 2)
                for a in (ZZ(0), ZZ(1)):
                    for b in (ZZ(0), ZZ(1)):
                        phase_factor = -K8((-1) ** (a * h + b * v)) * zeta8 ** turning
                        quadratic_exponent = h * v + (1 - a) * h + (1 - b) * v
                        quadratic_sign = K8((-1) ** quadratic_exponent)
                        assert phase_factor == quadratic_sign, \
                            (L, walk, a, b, h, v, turning,
                             phase_factor, quadratic_sign)
                        checked += 1
                continue
            for nxt in successor_lists[last]:
                target = endpoints(L, nxt)[1]
                if target in visited:
                    continue
                stack.append((walk + [nxt], visited | frozenset([target])))

assert checked == 4 * walk_total
print("PASS: vertex-simple orbit phase factor = torus quadratic sign "
      f"(L=2,3,4, rooted walks {walk_total}, spin structures 4, checks {checked})")
