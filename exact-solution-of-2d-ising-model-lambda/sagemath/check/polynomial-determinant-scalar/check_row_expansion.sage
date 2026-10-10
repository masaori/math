# 行指定の行列式の定義
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

check_line("row_expansion",
    lambda n, A, c, data: (c*A).det(),
    lambda n, A, c, data: sum((w*prod(((c*A)[i, s[i]] for i in range(n)), R(1)) for s, w, P in data), R(0)),
    termwise=False)
