# 対象ラベル: claim_tagged_short_pair_successor
# 一行目は反転の端点、二行目は短い対の共通始点、三行目は反転の対合性。
for size in (1, 2, 3):
    vertices = tuple(range(size * size))
    edges = []
    for row in range(size):
        for col in range(size):
            start = row * size + col
            edges.append((start, row * size + ((col + 1) % size)))
            edges.append((start, ((row + 1) % size) * size + col))

    oriented = tuple((index, direction)
                     for index in range(len(edges)) for direction in (0, 1))

    def source(edge):
        return edges[edge[0]][edge[1]]

    def target(edge):
        return edges[edge[0]][1 - edge[1]]

    def reverse(edge):
        return (edge[0], 1 - edge[1])

    for g in oriented:
        for f in oriented:
            if source(g) != source(f) or g == f:
                continue
            assert target(reverse(g)) == source(g)
            assert source(g) == source(f)
            assert reverse(reverse(g)) == g
            assert target(reverse(g)) == source(f)
            assert f != reverse(reverse(g))
            assert target(reverse(g)) == source(f) and f != reverse(reverse(g))

print('RESULT: PASS; all local short pairs give a nonbacktracking successor for L=1,2,3')
