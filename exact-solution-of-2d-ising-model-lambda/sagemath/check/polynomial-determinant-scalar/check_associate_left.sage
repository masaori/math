# 左への結合
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

check_line("associate_left",
    lambda n, A, c, s, w, P: w*(c**n*P),
    lambda n, A, c, s, w, P: (w*c**n)*P,
    termwise=True)
