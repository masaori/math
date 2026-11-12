# 有理点での分散因子の正値性

**対象ラベル**: `claim_dispersion_positive_at_rational_point`

| ファイル | 検証内容 | 状態 |
|---|---|---|
| `check.sage` | $2-\varpi-\varpi^{-1}$・$2-\varsigma-\varsigma^{-1}$ の五行ずつ、$q(1-q^2)$ の三行、正値分解を $x:=q$ で評価した四行、$p=0$ の矛盾の三行を $\mathbb Q[q,\alpha,\beta,\gamma,\delta][\omega]/(\omega^2+1)$ の恒等式で確かめる（$\alpha^2+\beta^2=1$ の代入は差で見る）。辺長 1〜4・四つのスピン構造の全モードと有理点 8 個で、$c_\varpi,c_\varsigma,e,s$ を実代数的数として取り、各行と $\Delta(q;\varpi,\varsigma)=p^2+(se)^2\in R$、$0<_Rp^2\le_R\Delta$ を `QQbar` の厳密計算で確かめる（$R$ として実代数的数、$\omega=i$）。7,570 行、否定の対照 122 件（符号を取り違えた分解、区間外の $q=2$ で $r$ が平方でないこと、自己双対点 $\sqrt2-1$ で $p=0$） | PASS（2026-11-12） |

順序の推論（$se\ne0$ と $se=0$ の場合分け、$p\ne0$ の矛盾）そのものは本文と Lean が受け持つ。SageMath は各行の等式だけを確かめる。
