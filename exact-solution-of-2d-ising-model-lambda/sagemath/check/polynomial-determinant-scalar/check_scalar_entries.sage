# スカラー倍の成分
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

check_line("scalar_entries",
    lambda n, A, c, s, w, P: w*prod(((c*A)[i, s[i]] for i in range(n)), R(1)),
    lambda n, A, c, s, w, P: w*prod((c*A[i, s[i]] for i in range(n)), R(1)),
    termwise=True)
