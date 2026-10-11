from collections import Counter
from pathlib import Path
import json
import sys

source_path = Path(globals().get('__file__', sys.argv[0])).resolve()
if not (source_path.parent / '_prelude.sage').is_file():
    source_path = Path(sys.argv[0]).resolve()
check_dir = source_path.parent
check_paths = sorted(check_dir.glob('check_*.sage'))
assert len(check_paths) == 93
for check_path in check_paths:
    __file__ = str(check_path)
    load(__file__)
assert len(qpm_results) == 93
assert Counter(mode for count, mode in qpm_results.values()) == {
    'polynomial identity': 69,
    'rational comparison': 22,
    'quadratic quotient; both roots': 1,
    'quadratic field; both roots': 1,
}
print('ROW_RESULTS: ' + json.dumps(qpm_results, sort_keys=True))
print('RESULT: PASS (93 rows; 69 polynomial identities; '
      '22 comparisons on 67308 inputs; quadratic representation and membership for both roots)')
