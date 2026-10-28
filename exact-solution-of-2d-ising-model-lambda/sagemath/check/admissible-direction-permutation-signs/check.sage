# 対象ラベル: claim_admissible_direction_permutation_signs
from pathlib import Path
import sys
base = Path(sys.argv[0]).resolve().parent
for name in ('0123', '0132', '0213', '1023', '1032', '1230', '3012', '3120', '3210'):
    load(str(base / ('check_' + name + '.sage')))
