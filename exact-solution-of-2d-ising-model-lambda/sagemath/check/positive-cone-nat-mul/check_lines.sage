# 対象ラベル: claim_quadratic_positive_cone_nat_mul
from pathlib import Path
import sys

if '_pn_check' not in globals():
    _source = Path(globals().get('__file__', sys.argv[0])).resolve()
    if not (_source.parent / '_prelude.sage').is_file():
        _source = Path(sys.argv[0]).resolve()
    load(str(_source.parent / '_prelude.sage'))

import json
print('COUNTS_JSON:', json.dumps({k: int(v) for k, v in _pn_check().items()}, sort_keys=True))
