# SageMath Check: 有理係数の対数順序群の Cauchy 列（定義）

## 対象

**対象ラベル**: `def_rational_log_order_group_cauchy_sequence`

- 実行日: 2026-08-16
- 状態: PASS（$\varepsilon$ の標本 6 点、定数列 294 検査、列 $(1/L)\cdot\iota(\ell_2)$ 10086 検査、
  Cauchy 列でない例 30 検査、$\Lambda_{\mathbb Q}$ の順序の比較 21051 回。所要 6 秒）
- 帰属: `ZZ`/`QQ` と素因数分解、有限台辞書による厳密計算。浮動小数点は使わない
  （定義は $\Lambda_{\mathbb Q}$ の加法・逆元・順序だけで書かれており、実数体は現れない）。

## 検査内容

定義は「任意の $\varepsilon$ … ある $N$ … すべての $L,M$」の形で普遍量化されており、
有限回の計算で確かめられるのは、$\varepsilon$・$N$・有限個の $L,M$ を固定した各比較と、具体的な列の例だけである。

- **決定手続き**: $-\varepsilon\le_{\Lambda_{\mathbb Q}}\lambda_L-\lambda_M\le_{\Lambda_{\mathbb Q}}\varepsilon$ の各比較を、
  `def_rational_log_order_group_order` の正準の証人（$N_\lambda N_\mu$ の証人 $N_\mu\lambda_{N_\lambda}$、$N_\lambda\mu_{N_\mu}$）の
  $\Lambda$ の比較（二つの正の有理数の比較）一度で判定し、「ある共通分母」形と「すべての共通分母（$N\le24$）」形が
  それと一致することを毎回見る（21051 回）。
- $\varepsilon$ の標本 $\iota(\ell_2)$、$\frac13\iota(\ell_2)$、$\frac17\iota(\ell_2)$、$\iota(\log\frac32)$、
  $\frac12\iota(\log\frac54)$、$3\iota(\ell_2)-\frac12\iota(\ell_7)$ がすべて $0\le_{\Lambda_{\mathbb Q}}\varepsilon$ かつ $\varepsilon\ne0$ を満たし、
  $0$・$-\iota(\ell_2)$・$\iota(\ell_2)-\iota(\ell_3)$ が満たさないこと。
- **定数列**は $N=1$ が証人になること（$\lambda_L-\lambda_M=0$ で $-\varepsilon\le0\le\varepsilon$）。
- 列 $\lambda_L=\frac1L\cdot\iota(\ell_2)$ について、各 $\varepsilon$ に対し条件を満たす $N$ を探索で見つけ
  （$N=1,3,7,2,6,1$）、$N\le L,M\le N+40$ の範囲で二つの比較がすべて成り立つこと、および $N>1$ のときは
  $N=1$ では条件を破る $(L,M)$ が存在すること（$N$ が $\varepsilon$ に依存すること）。
- 列 $\lambda_L=L\cdot\iota(\ell_2)$ について、$\varepsilon=\iota(\ell_2)$ と $N\le30$ のどの $N$ でも
  $(L,M)=(N,N+2)$ が条件を破ること（Cauchy 列でない例）。

## 検査できないこと（黙って広げない）

有限標本検査は、どの列についても「すべての $L,M$」の主張の証明ではない（列 $\frac1L\cdot\iota(\ell_2)$ が
Cauchy 列であることも、ここでは $N+40$ までの窓で見ただけである）。定義の Lean 版は
`IsCauchyRationalLogOrder`（`ThermodynamicLimit/RationalLogOrderGroupCauchySequence.lean`）で、
定数列が Cauchy 列であること（`isCauchyRationalLogOrder_const`）だけを一般に示してある（2026-08-16）。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/rational-log-order-group-cauchy-sequence/check.sage
```
