# 対象ラベル: claim_vertex_simple_boundary_distinct_pass_propagation
# 辺長三で単一セルの境界を巡る閉路を整数で検算する。
L = 3
walk = [((0, 0, 0), 0), ((1, 0, 1), 0),
        ((0, 1, 0), 1), ((1, 0, 0), 1)]
boundary = walk

def endpoints(edge):
    axis, i, j = edge
    return ((i, j), (i, (j + 1) % L)) if axis == 0 else \
        ((i, j), ((i + 1) % L, j))

def oriented_endpoints(term):
    source, target = endpoints(term[0])
    return (target, source) if term[1] else (source, target)

def coefficient(edge):
    return sum(ZZ(1 - 2 * direction) for base, direction in boundary if base == edge)

for k in range(len(walk)):
    incoming = walk[k]
    outgoing = walk[(k + 1) % len(walk)]
    vertex = oriented_endpoints(incoming)[1]
    assert oriented_endpoints(outgoing)[0] == vertex
    assert incoming[0] != outgoing[0]
    assert oriented_endpoints(incoming)[0] != vertex
    assert oriented_endpoints(outgoing)[1] != vertex
    for axis in (0, 1):
        for i in range(L):
            for j in range(L):
                edge = (axis, i, j)
                if edge in (incoming[0], outgoing[0]):
                    continue
                source, target = endpoints(edge)
                incidence = ZZ(source == vertex) - ZZ(target == vertex)
                assert coefficient(edge) * incidence == 0
    assert coefficient(incoming[0]) * (1 - 2 * ZZ(incoming[1])) == \
        coefficient(outgoing[0]) * (1 - 2 * ZZ(outgoing[1]))

print('RESULT: PASS; four distinct-edge passages of a cell boundary')
