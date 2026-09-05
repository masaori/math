# SageMath Check: 指数が根の次数の倍数のとき、冪の和は根の次数の与える代数的数である

**対象ラベル**: `claim_root_of_unity_power_sum_multiple_value`

$n=1,\dots,8$、$k=0,\dots,12$、$m=nk$ とし、
$S_{n,m}=\sum_{z\in\mu_n}z^{m}$ について、人手証明の鎖
$S_{n,m}=\sum_{z\in\mu_n}z^{m}=\sum_{z\in\mu_n}1=\sum_{i<n}1=n$
の各段を `QQbar` の厳密計算で確かめる（準備の $\lvert\mu_n\rvert=n$ も検査する）。
浮動小数点は使わない。

```sh
sage sagemath/check/root-of-unity-power-sum-multiple-value/check.sage
```

**2026-08-12 実行: すべて通過。**

2026-09-06 のレビューで、リストの長さだけを個数の根拠にしていた点を修正した。
列挙した元の相異性・根への所属・多項式から独立に求めた全根との集合一致も判定する。
修正後のプログラミングによる検証は 104 組で通過した。
