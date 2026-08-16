# SageMath Check: 有理係数の対数順序群の Archimedes 性

## 対象

**対象ラベル**: `claim_rational_log_order_group_archimedean`

- 実行日: 2026-08-16
- 状態: PASS（$\mu$ 7 点 × $\varepsilon$ 6 点 = 42 組。冪の検査を外した組 0）
- 帰属: `ZZ`・`QQ`・有限台辞書による厳密計算。浮動小数点は使わない。

## 検査内容

$\mu\in\{0,\ \iota(\ell_2),\ 2\iota(\ell_2),\ \tfrac12\iota(\ell_3),\ \iota(\ell_2)-\tfrac12\iota(\ell_3),\ \tfrac13\iota(\ell_5),\ \iota(\ell_3)+\tfrac12\iota(\ell_2)\}$、
$\varepsilon\in\{\iota(\ell_2),\ \tfrac12\iota(\ell_2),\ \tfrac13\iota(\ell_2),\ \iota(\log\tfrac32),\ \tfrac12\iota(\log\tfrac54),\ 3\iota(\ell_2)-\tfrac12\iota(\ell_7)\}$
の各組について、証明の各段をそのまま計算する:
準備の第一（$N:=N_\mu N_\varepsilon$ が $\mu$・$\varepsilon$・$0$・$n\cdot\varepsilon$ の共通分母で証人が $\mu_N,\varepsilon_N,0,n\varepsilon_N$）、
準備の第二（$1\le\operatorname{rat}_\Lambda(\mu_N)$、$1\le\operatorname{rat}_\Lambda(\varepsilon_N)$）、
準備の第三（$\varepsilon_N\ne0$、$1<\operatorname{rat}_\Lambda(\varepsilon_N)$、$h>0$、$0\le A-1$）、
準備の第四（$r\ge0$、$n=\operatorname{num}(r)\in\mathbb N$、$A-1=rh\le nh$ の四段）、
本体の五段の鎖（Bernoulli 不等式・$\operatorname{rat}_\Lambda(n\varepsilon_N)=\operatorname{rat}_\Lambda(\varepsilon_N)^n$）、
$\mu_N\le_\Lambda n\varepsilon_N$、$\mu\le_{\Lambda_{\mathbb Q}}n\cdot\varepsilon$（決定手続き。共通分母は最小公倍数）。
$\mu\ne0$ の組では $n=0$ で成り立たないことも見る。

証明の $n=\operatorname{num}((A-1)/h)$ は $A=\operatorname{rat}_\Lambda(\mu_N)$ が $\mu$ の値の指数関数的に大きいため、
標本を大きくすると $(1+h)^n$ の分子・分母が桁あふれする（最初の標本では $n\sim10^{100}$ の組が出て
浮動小数点例外で落ちた）。そのため標本を小さく取り、$n$ が上限 20000 を超える組は冪の検査を外して
組を出力に記録する仕組みにしてある（今回の標本では該当 0。$n$ の最大は 5831）。
有限標本の検査であり、普遍量化された主張の証明ではない。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/rational-log-order-group-archimedean/check.sage
```
