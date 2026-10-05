# 対象ラベル: claim_gauged_terminal_matrix_skew
import os, sys
if '_sk_cases' not in globals():
    _sk_dir=os.path.dirname(os.path.abspath(__file__))
    if not os.path.isfile(os.path.join(_sk_dir, '_prelude.sage')):
        _sk_dir=os.path.dirname(os.path.abspath(sys.argv[0]))
    load(os.path.join(_sk_dir, '_prelude.sage'))
_sk_check('long_true', 2, 'long_true_coefficient')
