# 有限和から共通因子を取り出す
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

check_line("factor_sum",
    lambda n, A, c, data: sum((c**n*(w*P) for s, w, P in data), R(0)),
    lambda n, A, c, data: c**n*sum((w*P for s, w, P in data), R(0)),
    termwise=False)
