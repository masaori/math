# SageMath Check: 対称化した極限量に対して粗視化は必要でない

**対象ラベル**: `claim_coarse_graining_not_necessary_for_symmetrized_limit_quantity`

$q\neq1$、$q'=1/q$ について、箱の辺 $L=2$ と有理点 6 点で $\mathbb Q$ と素指数ベクトルの厳密計算で確認する。

| 確かめた段 | 方法 | ステータス |
| --- | --- | --- |
| 粗視化の値 $Z_L(q)\neq Z_L(q')$ | `QQ` の不等式 | PASS |
| 対称化した列の項 $(\#V_L,\sigma_L(q))=(\#V_L,\sigma_L(q'))$ | `QQ(...).factor()` の素指数ベクトルを整数係数で結合して比較 | PASS |
| $\tilde a_L$ の底 $Z_L(q)^2/q^{\#E_L}=Z_L(q')^2/q'^{\#E_L}$ | `QQ` の等式 | PASS |

$L=3$ は全配位の列挙（$2^{27}$ 個）になるため今回は含めていない。浮動小数点、実対数、指数関数、無限和、極限は使わない。

```sh
sage sagemath/check/coarse-graining-not-necessary-for-symmetrized-limit-quantity/check.sage
```

**2026-08-17 実行: すべて通過。**
