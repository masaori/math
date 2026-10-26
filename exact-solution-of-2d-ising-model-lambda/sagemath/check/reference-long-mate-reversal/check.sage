# 対象ラベル: claim_reference_long_mate_reversal
# 基準マッチングの二元組に含まれる一意な相手を厳密に照合する。
for size in (1, 2, 3):
    oriented = tuple((edge, direction)
                     for edge in range(2 * size * size)
                     for direction in (0, 1))

    def reversal(edge):
        return (edge[0], 1 - edge[1])

    long_pairs = {frozenset((edge, reversal(edge))) for edge in oriented}
    for edge in oriented:
        assert reversal(edge) != edge
        assert frozenset((edge, reversal(edge))) in long_pairs
        containing = [pair for pair in long_pairs if edge in pair]
        assert len(containing) == 1
        partner = next(iter(containing[0] - {edge}))
        assert partner == reversal(edge)

print('RESULT: PASS; reference-long mate equals reversal for L=1,2,3')
