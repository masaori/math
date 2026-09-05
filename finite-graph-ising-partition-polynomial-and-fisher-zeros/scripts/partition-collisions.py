"""Fixed finite exploration; Python integers only, no optional wider input range."""
import argparse
from collections import Counter, defaultdict
from itertools import combinations, permutations, product
import json
from pathlib import Path

OUTPUT = Path(__file__).resolve().parents[1] / 'docs/research/partition-collisions/certificates.json'
ORDERS = (1, 2, 3, 4, 5)


def connected(a):
    reached = {0}
    pending = [0]
    while pending:
        u = pending.pop()
        for v in range(len(a)):
            if a[u][v] and v not in reached:
                reached.add(v)
                pending.append(v)
    return len(reached) == len(a)


def flattened(a, p):
    return tuple(a[u][v] for u in p for v in p)


def coefficients(a):
    edges = [(u, v) for u, v in combinations(range(len(a)), 2) if a[u][v]]
    counts = [0] * (len(edges) + 1)
    for spin in product(('up', 'down'), repeat=len(a)):
        counts[sum(spin[u] != spin[v] for u, v in edges)] += 1
    return counts


def polynomial_key(counts):
    trimmed = list(counts)
    while len(trimmed) > 1 and trimmed[-1] == 0:
        trimmed.pop()
    return tuple(trimmed)


def generate():
    graphs, summary = [], []
    for n in ORDERS:
        pairs = list(combinations(range(n), 2))
        orders = list(permutations(range(n)))
        classes = {}
        labeled = 0
        for edge_bits in product((0, 1), repeat=len(pairs)):
            a = [[0] * n for _ in range(n)]
            for (u, v), bit in zip(pairs, edge_bits):
                a[u][v] = a[v][u] = bit
            if not connected(a):
                continue
            labeled += 1
            canonical = min(flattened(a, p) for p in orders)
            counts = coefficients(a)
            if canonical in classes:
                assert classes[canonical]['coefficients'] == counts
                classes[canonical]['labeled_count'] += 1
            else:
                classes[canonical] = {
                    'order': n,
                    'canonical': ''.join(map(str, canonical)),
                    'adjacency': [list(canonical[i*n:(i+1)*n]) for i in range(n)],
                    'coefficients': counts,
                    'labeled_count': 1,
                }
        records = [classes[key] for key in sorted(classes)]
        graphs.extend(records)
        summary.append({'order': n, 'labeled_connected': labeled, 'isomorphism_classes': len(records)})
    groups = defaultdict(list)
    for graph in graphs:
        groups[polynomial_key(graph['coefficients'])].append(graph)
    collisions = []
    for key, group in sorted(groups.items()):
        for left, right in combinations(group, 2):
            assert left['order'] == right['order']
            n = left['order']
            a, b = left['adjacency'], right['adjacency']
            # A differing entry for every possible isomorphism V(left) -> V(right).
            witnesses = []
            for p in permutations(range(n)):
                u, v = next((u, v) for u, v in combinations(range(n), 2) if a[u][v] != b[p[u]][p[v]])
                witnesses.append({'permutation': list(p), 'differing_pair': [u, v]})
            collisions.append({'left': left['canonical'], 'right': right['canonical'],
                               'coefficients': list(key), 'nonisomorphism': witnesses})
    return {'orders': list(ORDERS), 'summary': summary, 'graphs': graphs, 'collisions': collisions}


def verify(data):
    """Recompute using edge masks, cut subsets, and full adjacency relabeling."""
    assert data['orders'] == list(ORDERS)
    records = data['graphs']
    by_key = {r['canonical']: r for r in records}
    assert len(by_key) == len(records)
    observed = Counter()
    summaries = []
    for n in ORDERS:
        pairs = [(u, v) for u in range(n) for v in range(u + 1, n)]
        counts_by_key = Counter()
        for mask in range(1 << len(pairs)):
            edges = {pair for bit, pair in enumerate(pairs) if mask & (1 << bit)}
            # Connected iff no nonempty proper vertex subset has an empty cut.
            cuts = []
            for subset in range(1 << n):
                cuts.append(sum(((subset >> u) & 1) != ((subset >> v) & 1) for u, v in edges))
            if any(cuts[s] == 0 for s in range(1, (1 << n) - 1)):
                continue
            strings = []
            for p in permutations(range(n)):
                strings.append(''.join('1' if tuple(sorted((p[u], p[v]))) in edges else '0'
                                       for u in range(n) for v in range(n)))
            key = min(strings)
            record = by_key[key]
            assert record['order'] == n
            assert record['adjacency'] == [[int(key[u*n+v]) for v in range(n)] for u in range(n)]
            histogram = Counter(cuts)
            expected = [histogram[m] for m in range(len(edges) + 1)]
            assert record['coefficients'] == expected
            assert expected[0] == 2 and sum(expected) == 1 << n
            counts_by_key[key] += 1
            observed[key] += 1
        summaries.append({'order': n, 'labeled_connected': sum(counts_by_key.values()),
                          'isomorphism_classes': len(counts_by_key)})
    assert data['summary'] == summaries
    assert set(observed) == set(by_key)
    for key, record in by_key.items():
        assert record['labeled_count'] == observed[key]
    expected_pairs = set()
    for left, right in combinations(records, 2):
        length = max(len(left['coefficients']), len(right['coefficients']))
        lc = left['coefficients'] + [0] * (length - len(left['coefficients']))
        rc = right['coefficients'] + [0] * (length - len(right['coefficients']))
        if lc == rc:
            expected_pairs.add((left['canonical'], right['canonical']))
    actual_pairs = set()
    for collision in data['collisions']:
        pair = collision['left'], collision['right']
        assert pair not in actual_pairs
        actual_pairs.add(pair)
        left, right = (by_key[k] for k in pair)
        assert polynomial_key(left['coefficients']) == tuple(collision['coefficients'])
        n = left['order']
        assert n == right['order']
        certificates = collision['nonisomorphism']
        assert len(certificates) == len(list(permutations(range(n))))
        assert {tuple(w['permutation']) for w in certificates} == set(permutations(range(n)))
        for witness in certificates:
            p = witness['permutation']
            u, v = witness['differing_pair']
            assert 0 <= u < v < n
            assert left['adjacency'][u][v] != right['adjacency'][p[u]][p[v]]
    assert actual_pairs == expected_pairs


def serialize(data):
    # Keep each finite witness on one line so the certificate is reviewable.
    lines = ['{', '  "orders": ' + json.dumps(data['orders']) + ',', '  "summary": [']
    lines.append(',\n'.join('    ' + json.dumps(row) for row in data['summary']))
    lines.extend(['  ],', '  "graphs": ['])
    lines.append(',\n'.join('    ' + json.dumps(row) for row in data['graphs']))
    lines.extend(['  ],', '  "collisions": ['])
    blocks = []
    for collision in data['collisions']:
        fields = {key: value for key, value in collision.items() if key != 'nonisomorphism'}
        block = '    {\n' + ''.join('      ' + json.dumps(key) + ': ' + json.dumps(value) + ',\n'
                                     for key, value in fields.items())
        block += '      "nonisomorphism": [\n'
        block += ',\n'.join('        ' + json.dumps(row) for row in collision['nonisomorphism'])
        blocks.append(block + '\n      ]\n    }')
    lines.append(',\n'.join(blocks))
    lines.extend(['  ]', '}'])
    return '\n'.join(lines) + '\n'


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--write', action='store_true', help='generate the fixed certificate file')
    args = parser.parse_args()
    if args.write:
        data = generate()
        verify(data)
        OUTPUT.write_text(serialize(data))
    else:
        data = json.loads(OUTPUT.read_text())
        verify(data)
        assert data == generate(), 'certificate differs from deterministic regeneration'
    print(json.dumps({'status': 'PASS', 'summary': data['summary'],
                      'collision_pairs': len(data['collisions'])}, ensure_ascii=False))


if __name__ == '__main__':
    main()
