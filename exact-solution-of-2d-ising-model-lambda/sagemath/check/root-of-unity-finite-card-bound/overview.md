# SageMath Check: 1 の冪根の全体は有限であり元の個数は指数を超えない

**対象ラベル**: `claim_root_of_unity_finite_card_bound`

`PolynomialRing(QQbar)` で、$n=1,\dots,8$ について $\mu_n$ を $t^n-1$ の相異なる根として
厳密に列挙し、各元が $n$ 乗して 1 になること、集合が有限で元の個数が $n$ 以下であることを確かめる。
また、本文の背理法の終点である $|s|=n+1$ と $|s|\le n$ が両立しないことを整数の厳密計算で確かめる。
浮動小数点は使わない。

```sh
sage sagemath/check/root-of-unity-finite-card-bound/check.sage
```

**2026-08-11 実行: すべて通過。**
