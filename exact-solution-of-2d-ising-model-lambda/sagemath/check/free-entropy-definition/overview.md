# SageMath Check: 有限系の自由エントロピー Φ_L(q) の定義

## 対象

**対象ラベル**: `claim_rational_exponent_well_defined`, `claim_value_at_rational_is_positive`
（structured-latex 側の安定識別子）

- 本文: `structured-latex/content/main-text.ts` の章「有限系の自由エントロピー」の主張
  「有理数の指数は表示の取り方によらない」と「分配多項式の正の有理点での値は正の有理数である」
- 併せて使う定義: `def_prime_exponent` / `def_log_order_group` / `def_rational_log` /
  `def_finite_free_entropy` / `def_partition_polynomial` / `def_broken_bond_count` / `def_configuration`

### 何を確定させるための検証か

1. 同じ有理数の異なる表示 $a/b=a'/b'$ を多数作り、$v_p(a)-v_p(b)=v_p(a')-v_p(b')$ が
   表示の全対で成り立つことを確かめる（主張「有理数の指数は表示の取り方によらない」の Step 1–4）。
   表示は共通因子を掛けたものと既約表示から作る。
2. そうして得た $w_p(q)$ が、Sage の素因数分解が返す指数と一致することを確かめる
   （$\log$ が素因数分解そのものであること。`def_rational_log`）。
   あわせて $w_p(q)\ne0$ となる素数が有限個であること（台の有限性）も見る。
3. $L=1,2,3$ と 5 個の正の有理点について、代入 $Z_L(q)$ が配位ごとの和
   $\sum_{\sigma}q^{b(\sigma)}$ に一致し（Step 1）、各項が正で（Step 2）、
   値が正の有理数であること（Step 3–4）を確かめる。
   左辺は多項式への代入、右辺は配位の総当たりであり、作り方が独立である。
4. $\Phi_L(q)=\log Z_L(q)$ の指数ベクトルから $Z_L(q)$ を復元できることを確かめる
   （`def_finite_free_entropy`）。
5. 本文の具体例 $\Phi_2(1/2)=\ell_{353}-7\ell_2$ を確かめる（$353$ が素数であることも見る）。

### 計算の厳密性

すべて `ZZ` / `QQ` / `ZZ['x']` の厳密計算で行う。素因数分解は Sage の `factor`（整数の厳密な
素因数分解）を使う。**浮動小数点は使わない。**
本文がこの章で $\mathbb{R}$ へ脱出していないので、検証側にも脱出を持ち込まない
（$\log$ は素因数分解であって実対数ではない）。

## 実行

```sh
sage sagemath/check/free-entropy-definition/check.sage
```

## 実行ステータスと結果

| 項目 | 状態 |
| --- | --- |
| 実行 | 2026-08-08 実行（SageMath, `/usr/local/bin/sage`） |
| 結果 | 全アサーション成立（$L=1,2,3$、有理点 5 個、表示の全対） |

$q=1/2$ での出力:

| $L$ | $Z_L(1/2)$ | $\Phi_L(1/2)$ |
| --- | --- | --- |
| 1 | $2$ | $\ell_2$ |
| 2 | $353/128$ | $\ell_{353}-7\ell_2$ |
| 3 | $9859/2048$ | $\ell_{9859}-11\ell_2$ |

$q=1$ では $Z_L(1)=2^{L^2}$（係数の総和）なので $\Phi_L(1)=L^2\ell_2$ になる。
$L=2$ で $\Phi_2(1)=4\ell_2$、$L=3$ で $\Phi_3(1)=9\ell_2$ という出力はこれと合っている。

### 観察（主張としては使わない）

$\Phi_L(q)$ に現れる素数は $q$ ごとにばらばらで、大きさも揃わない
（例: $L=3$, $q=1/1000$ では 30 桁の素数が 1 つ現れる）。
$\Lambda$ の元としての帰属は保たれるが、素数の分布に規則性があるかどうかはここでは何も言えない。
