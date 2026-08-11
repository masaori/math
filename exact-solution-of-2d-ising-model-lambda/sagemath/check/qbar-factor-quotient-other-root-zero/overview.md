# SageMath Check: 一次因子を取り除いた商は、もとの根と相異なる根で零になる

**対象ラベル**: `claim_qbar_factor_quotient_other_root_zero`

本文の鎖（5 段）を `PolynomialRing(QQbar)` の厳密計算で一段ずつ確かめる。
4 組の相異なる代数的数と商を使い、因子を戻した多項式がもう一つの根で零になること、
商もその根で零になること、各中間値が一致することを検査する。
また 2 つの根が同じなら商が零にならない例を置き、相異なるという仮定を外せないことを確かめる。
浮動小数点は使わない。

```sh
sage sagemath/check/qbar-factor-quotient-other-root-zero/check.sage
```

**2026-08-11 実行: すべて通過。**
