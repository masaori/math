# 対象ラベル: def_alternating_neighbor_pairs, claim_alternating_neighbor_matchings
# 本文の25行を順番に実行し、入力と境界例の網羅を独立に確認する。
from pathlib import Path
import sys

_anm_source = Path(globals().get('__file__', sys.argv[0])).resolve()
if not (_anm_source.parent / '_prelude.sage').is_file():
    _anm_source = Path(sys.argv[0]).resolve()
_anm_directory = _anm_source.parent
load(str(_anm_directory / '_prelude.sage'))
_anm_check_coverage()
_anm_files = (
    'check_inverse_double_negation.sage',
    'check_inverse_color_negation.sage',
    'check_inverse_right_inverse.sage',
    'check_color_inside_definition.sage',
    'check_color_inside_hypothesis.sage',
    'check_color_outside_definition.sage',
    'check_color_outside_inverse.sage',
    'check_no_fixed_point.sage',
    'check_involution_inside_color.sage',
    'check_involution_inside_inner_definition.sage',
    'check_involution_inside_outer_definition.sage',
    'check_involution_inside_left_inverse.sage',
    'check_involution_outside_color.sage',
    'check_involution_outside_inner_definition.sage',
    'check_involution_outside_outer_definition.sage',
    'check_involution_outside_right_inverse.sage',
    'check_forward_involution.sage',
    'check_backward_involution.sage',
    'check_forward_family_definition.sage',
    'check_forward_orbit_matching.sage',
    'check_forward_neighbor_matching.sage',
    'check_backward_family_definition.sage',
    'check_backward_orbit_matching.sage',
    'check_backward_neighbor_matching.sage',
    'check_ordered_pair.sage',
)
assert {path.name for path in _anm_directory.glob('check_*.sage')} == set(_anm_files)
for _anm_filename in _anm_files:
    __file__ = str(_anm_directory / _anm_filename)
    load(__file__)
assert len(_anm_results) == 25
assert sum(count for count, kind in _anm_results.values()) == 50923
_anm_totals = {kind: sum(count for count, actual_kind in _anm_results.values()
                         if actual_kind == kind)
               for kind in ('iff', 'equalities', 'judgments')}
assert _anm_totals == {'iff': 22100, 'equalities': 14754, 'judgments': 14069}
print('RESULT: PASS (25 lines; 50923 checks; %s)' % _anm_totals)
