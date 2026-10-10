# 右への結合
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

check_line("associate_right",
    lambda n, A, c, s, w, P: (c**n*w)*P,
    lambda n, A, c, s, w, P: c**n*(w*P),
    termwise=True)
