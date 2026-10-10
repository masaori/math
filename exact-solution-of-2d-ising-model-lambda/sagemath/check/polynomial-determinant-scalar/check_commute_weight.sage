# 符号係数と冪の交換
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

check_line("commute_weight",
    lambda n, A, c, s, w, P: (w*c**n)*P,
    lambda n, A, c, s, w, P: (c**n*w)*P,
    termwise=True)
