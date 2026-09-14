# 対象ラベル: claim_totalistic_pairwise_characterization
# 併せて検証: def_totalistic_local_rule_family, def_totalistic_local_signature
# 逆方向: 同じ署名の入力で出力が一致する族から、実現署名で値を選び、非実現署名を 0 で埋めて phi を作る。
# 帰属: 有限集合、有限写像表、ZZ。対数、除算、浮動小数点、R/C 脱出はない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

stage_count = ZZ(0)
pairwise_family_count = ZZ(0)
unrealized_signature_count = ZZ(0)

for cell_count in range(4):
    for cells, stage in closed_neighborhood_stages(cell_count):
        stage_count += 1
        entries = local_input_entries(cells, stage)
        realized_signatures = tuple(sorted(set(local_signature(stage, cell, local_input) for cell, local_input in entries)))
        seen_families = set()
        for signature_outputs in itertools.product(STATES, repeat=len(realized_signatures)):
            values = dict(zip(realized_signatures, signature_outputs))
            family = {
                (cell, local_input): values[local_signature(stage, cell, local_input)]
                for cell, local_input in entries
            }
            family_code = tuple(family[entry] for entry in entries)
            assert family_code not in seen_families
            seen_families.add(family_code)
            assert pairwise_condition(cells, stage, family)

            reconstructed = reconstruct_totalistic_table(cells, stage, family)
            for signature in signature_domain(cell_count):
                if signature in values:
                    assert reconstructed[signature] == values[signature]
                else:
                    assert reconstructed[signature] == 0
                    unrealized_signature_count += 1
            assert family_matches_table(cells, stage, family, reconstructed)
            pairwise_family_count += 1

        assert len(seen_families) == ZZ(2) ** ZZ(len(realized_signatures))

assert stage_count == ZZ(12)
assert pairwise_family_count == ZZ(333)
assert unrealized_signature_count > 0
print('closed-neighborhood stages checked:', stage_count)
print('pairwise-consistent families reconstructed:', pairwise_family_count)
print('unrealized signatures filled with zero:', unrealized_signature_count)
print('RESULT: PASS')
