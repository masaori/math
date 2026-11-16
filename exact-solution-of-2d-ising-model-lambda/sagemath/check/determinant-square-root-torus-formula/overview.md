# 四つの多項式平方根による有限トーラス公式

**対象ラベル**: `claim_determinant_polynomial_square_root_exists`, `claim_determinant_square_root_torus_formula`

| ファイル | 検証内容 | 実行状態・結果 |
|---|---|---|
| `check.sage` | 辺長一・二で四つの平方根の定数項・平方と、その正符号の和を厳密計算する。定数項は本文の式鎖の四行（$|A|=0$ の項の和、空集合だけ、空集合の巻き付き偶奇は零、$(-1)^0=1$）を一行ずつ確かめる。有限トーラス公式の式鎖の三行（$Z_L=\frac12(2Z_L)$、$=\frac12\sum Q^{a,b}_L$、$=\frac12\sum S^{a,b}_L$）を $\overline{\mathbb Q}[x]$ で確かめる | PASS（2026-11-16、平方根8件・和2件） |

有限例の検算であり、任意の辺長についての証明は本文が担う。
