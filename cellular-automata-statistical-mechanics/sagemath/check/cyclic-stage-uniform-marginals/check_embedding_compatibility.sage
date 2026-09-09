# 対象ラベル: claim_cyclic_stage_window_embeddings_compatible
# 式ペア・判定: s <= t <= m で j_(m,s) = j_(m,t)|D_s と、配位の引き戻しの制限が一致する。
# 帰属: 有限集合と ZZ・NN。除算、浮動小数点、R/C 脱出はない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

embedding_cases = ZZ(0)
configuration_cases = ZZ(0)
for stage in range(7):
    for larger_radius in range(stage + 1):
        larger_embedding = embedding(stage, larger_radius)
        assert len(set(larger_embedding.values())) == len(larger_embedding)
        for smaller_radius in range(larger_radius + 1):
            smaller_embedding = embedding(stage, smaller_radius)
            assert all(larger_embedding[offset] == smaller_embedding[offset]
                       for offset in window(smaller_radius))
            embedding_cases += 1

            for configuration in configurations(stage_cells(stage)):
                smaller_pullback = restrict_to_window(configuration, stage, smaller_radius)
                larger_pullback = restrict_to_window(configuration, stage, larger_radius)
                centered_start = larger_radius - smaller_radius
                centered_end = centered_start + len(window(smaller_radius))
                assert larger_pullback[centered_start:centered_end] == smaller_pullback
                configuration_cases += 1

assert embedding_cases == ZZ(84)
assert configuration_cases == ZZ(281562)
print('compatible embedding triples checked:', embedding_cases)
print('configuration pullbacks checked:', configuration_cases)
print('RESULT: PASS')
