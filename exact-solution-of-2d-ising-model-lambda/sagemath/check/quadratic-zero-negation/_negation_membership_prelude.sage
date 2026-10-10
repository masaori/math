import os
import sys

_qnm_dir = os.path.dirname(os.path.abspath(__file__))
if not os.path.isfile(os.path.join(_qnm_dir, '_representation_prelude.sage')):
    _qnm_dir = os.path.dirname(os.path.abspath(sys.argv[0]))
if '_qzr_cases' not in globals():
    load(os.path.join(_qnm_dir, '_representation_prelude.sage'))
_qnm_cases = _qzr_cases

def _qnm_check(rows, label):
    count = 0
    for lhs, rhs in rows:
        assert lhs == rhs, (label, count, lhs, rhs)
        count += 1
    assert count == 722
    print('PASS %s: %d exact equations' % (label, count))
