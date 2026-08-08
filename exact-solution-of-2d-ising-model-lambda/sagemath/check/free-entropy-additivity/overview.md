# SageMath Check: 対数の加法性・冪の法則と Φ_L(1)

## 対象

**対象ラベル**: `claim_log_additive`, `claim_log_power`, `claim_free_entropy_at_one`
（structured-latex 側の安定識別子）

- 本文: `structured-latex/content/main-text.ts` の章「有限系の自由エントロピー」の主張
  「対数の加法性」「対数の冪の法則」「すべての配位を等しく数える点での自由エントロピー」
- 併せて使う定義: `def_prime_exponent` / `def_log_order_group` / `def_rational_log` /
  `def_finite_free_entropy` / `def_partition_polynomial` / `def_multiplicity`

### 何を確定させるための検証か

1. 正の有理点 10 個の全対（100 通り）について $\log(q_1q_2)=\log q_1+\log q_2$ を確かめる。
   $\Lambda$ の元は $\{p:w_p(q)\}$ の辞書として表し、加法は素数ごとの整数の加法として実装する
   （`def_log_order_group` どおり）。本文の第 7 の等号と結びにあたる「各素数で値が一致すること」も
   別途素数ごとに確かめる。
2. 同じ有理点と $k=0,\dots,7$ について $\log(q^k)=k\log q$ を確かめる。
   $k=0$ の場合（$\log1$ が $\Lambda$ の単位元であること）も単独で見る。
3. $L=1,2,3$ について $Z_L(1)$ が多重度の総和かつ $2^{L^2}$ に等しいこと（本文の第 2–第 4 の等号）と、
   $\Phi_L(1)=L^2\ell_2$（本文の第 1・第 5–第 8 の等号）を確かめる。
   $\log2=\ell_2$（第 6–第 8 の等号）も単独で見る。

$Z_L(1)$ は分配多項式への代入から作り、比較相手の $2^{L^2}$ と多重度の総和は独立に作っている。

### 計算の厳密性

すべて `ZZ` / `QQ` / `ZZ['x']` の厳密計算で行う。素因数分解は Sage の `factor` を使う。
**浮動小数点は使わない。** 本文がこの章で $\mathbb{R}$ へ脱出していないので、検証側にも脱出を
持ち込まない（$\log$ は素因数分解であって実対数ではなく、$\Lambda$ の元は整数の辞書である）。

## 実行

```sh
sage sagemath/check/free-entropy-additivity/check.sage
```

## 実行ステータスと結果

| 項目 | 状態 |
| --- | --- |
| 実行 | 2026-08-08 実行（SageMath, `/usr/local/bin/sage`） |
| 結果 | 全アサーション成立（有理点 10 個の全対、$k=0,\dots,7$、$L=1,2,3$） |

$\Phi_L(1)$ の出力:

| $L$ | $Z_L(1)$ | $\Phi_L(1)$ |
| --- | --- | --- |
| 1 | $2$ | $\ell_2$ |
| 2 | $16$ | $4\ell_2$ |
| 3 | $512$ | $9\ell_2$ |

いずれも $L^2\ell_2$ と一致している。
