# 行列式の定義へ戻す
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

check_line("determinant_definition",
    lambda n, A, c, data: c**n*sum((w*P for s, w, P in data), R(0)),
    lambda n, A, c, data: c**n*A.det(),
    termwise=False)
