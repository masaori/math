# SageMath Check: 正錐の元の冪は正錐の元である

**対象ラベル**: `claim_quadratic_positive_cone_pow_closed`

本文の自然数についての帰納法を厳密計算で確認する。$s^2=2$ の二つの根と、
正錐の三条件を覆う四つの表示について、出発点 $(1,0)$ と、積の表示による
各帰納法ステップが通常の代数的数の冪に一致し、正錐に留まることを確かめる。
浮動小数点は使わない。

```sh
sage sagemath/check/positive-cone-pow/check.sage
```

**2026-08-18 実行: すべて通過。**
