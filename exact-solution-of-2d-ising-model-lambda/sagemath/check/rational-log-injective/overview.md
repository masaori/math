# SageMath Check: 正の有理数の対数は単射である

## 対象

**対象ラベル**: `claim_rational_log_injective`

- 実行日: 2026-08-15
- 状態: PASS（6561 件）
- 帰属: `ZZ`/`QQ` と素因数分解による厳密計算。浮動小数点は使わない。

## 検査内容

1 以上の整数 9 個から作った表示 $a/b$ の 81 組どうし（6561 組）について、証明の一続きの計算の各行
（指数の加法性、$w_p$ の移項、仮定 $\log q=\log q'$ の素数ごとの読み替え、有限積表示、有理数の約分）を
素数ごとに確かめ、$\log q=\log q'\iff q=q'$ を全件検査する。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/rational-log-injective/check.sage
```
