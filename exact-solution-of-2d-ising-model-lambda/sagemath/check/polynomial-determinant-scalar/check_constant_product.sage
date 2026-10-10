# 同じ元の有限積を冪へ書き換え
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

check_line("constant_product",
    lambda n, A, c, s, w, P: w*(prod((c for i in range(n)), R(1))*P),
    lambda n, A, c, s, w, P: w*(c**n*P),
    termwise=True)
