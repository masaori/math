# SageMath Check: 1 の冪根の全体はちょうど指数個の元を持つ

**対象ラベル**: `claim_root_of_unity_card`

`PolynomialRing(QQbar)` で、$n=1,\dots,8$ について $t^n-1$ の相異なる根を厳密に列挙する。
各元が $n$ 乗して 1 になること、既存の上界に対応する「元の個数は $n$ 以下」と、
相異なる $n$ 個の根の構成に対応する「元の個数は $n$ 以上」を別々に確かめ、等号を検算する。
浮動小数点は使わない。

```sh
sage sagemath/check/root-of-unity-card/check.sage
```

**2026-08-12 実行: すべて通過。**
