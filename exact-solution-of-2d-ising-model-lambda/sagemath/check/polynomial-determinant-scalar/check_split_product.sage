# 有限積の積の分離
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

check_line("split_product",
    lambda n, A, c, s, w, P: w*prod((c*A[i, s[i]] for i in range(n)), R(1)),
    lambda n, A, c, s, w, P: w*(prod((c for i in range(n)), R(1))*P),
    termwise=True)
