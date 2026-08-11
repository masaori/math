# SageMath Check: 一次因子の積から指定した因子を取り出す

**対象ラベル**: `claim_qbar_poly_linear_factor_product_extract`

本文の帰納法に対応させ、空積と「最後の因子を掛ける」一歩、および各番号の
因子を先頭へ取り出した等式を `QQbar[t]` の厳密計算で確かめる。
同じ根を重複して含む列も使い、相異性を仮定していないことも確かめる。
強化した statement（残りの因子 $B$ の係数は番号 $j-1$ より上で零である）に対応させ、
本文の帰納法どおりに構成した $B$ について、分解の等式と係数の上界、
および上界が過大でないこと（番号 $j-1$ の係数が $1$）も確かめる。
浮動小数点は使わない。

```sh
sage sagemath/check/qbar-poly-linear-factor-product-extract/check.sage
```

**2026-08-12 実行: すべて通過。**
