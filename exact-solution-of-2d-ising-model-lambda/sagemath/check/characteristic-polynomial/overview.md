# SageMath Check: 特性行列と特性多項式

## 対象

**対象ラベル**: `def_second_matrix` / `def_second_determinant` / `def_indeterminate_element` /
`def_characteristic_matrix` / `def_characteristic_polynomial`（structured-latex 側の安定識別子）

- 本文: `structured-latex/content/main-text.ts` の章「固有値の代数性」の定義 5 件
  （$\mathbb{Z}[x][t]$ を成分とする行列・その行列式 $\mathrm{det}_t$・不定元 $t$ 自身が定める元・
  特性行列 $\mathrm{ch}(A)$・特性多項式 $\chi_A$）
- 併せて使う定義: `def_constant_polynomial`（$\kappa$）、`def_second_constant_embedding`（$\iota$）、
  `def_permutation_sign`（符号）

### 何を確定させるための検証か

本文は、転送行列の固有値が代数的であることへ進む足場として、特性多項式
$\chi_A=\mathrm{det}_t(\mathrm{ch}(A))$ を定義した。この検証はその定義そのものを固定する。

1. `def_indeterminate_element`。$t$ の係数が本文の 2 つの等式どおりであること
   （$\mathrm{cf}_1(t)=\kappa(1)$、$k\ne1$ で $\mathrm{cf}_k(t)=\kappa(0)$）。
2. `def_characteristic_matrix`。本文は符号の反転を $\mathbb{Z}[x]$ の中で先に済ませる書き方
   （$t+\iota(-A_{\tau,\tau})$）を採り、$\mathbb{Z}[x][t]$ の引き算を使わない。この書き方が、
   引き算で書いた $tI-A$ と同じ元であることを確かめる（書き方の違いが値の違いになっていないこと）。
3. `def_second_determinant` / `def_characteristic_polynomial`。本文の $\mathrm{det}_t$ が
   SageMath 自身の `Matrix.determinant()` と一致すること。Sage の行列式は置換にわたる和ではなく
   分数自由なアルゴリズムであり作り方が独立なので、符号の向きや
   $B_{\tau,\varphi(\tau)}$ と $B_{\varphi(\tau),\tau}$ の取り違えを検出できる。
   あわせて積の添字の並べ方を逆順にしても値が変わらないことを見る。

## 走らせた範囲（打ち切りを隠さない）

- $L=1,2,3$。各 $L$ で置換は全列挙する（$L=3$ では 40320 個。標本ではない）。
- 行列 $A$ は 3 種類に限る。転送行列 $T$、成分がすべて異なる $x$ の冪である行列、対角行列。
  **行列の全体は無限集合なので総当たりではない。** 成分がすべて異なる行列を入れたのは、
  $T$ が対称な成分を多く持ち、添字の順序を取り違えても値が変わらない場合があるためである。

厳密計算のみ（$\mathbb{Z}$、$\mathbb{Z}[x]$、$\mathbb{Z}[x][t]$）。浮動小数点は使わない。
本文がこの範囲で $\mathbb{R}$ へ脱出していないので、検証側にも脱出を持ち込まない。

## 実行

```sh
sage sagemath/check/characteristic-polynomial/check.sage
```

## 結果

**2026-08-22 実行。すべてのアサーションが成立した。**

```text
OK: 不定元 t の係数が本文の 2 つの等式どおりである（cf_1 = kappa(1)、他は kappa(0)）
OK: L = 1。特性行列の成分が tI - A どおりであり、特性多項式が Sage の行列式と一致し、積の添字の順序によらない
OK: L = 2。（同上）
OK: L = 3。（同上）
すべてのアサーションが成立した（行列は 3 種類に限った標本。置換は全列挙。厳密計算のみ）
```

失敗の記録は消さない。この検証では失敗は出ていない。

### 記録

- 2026-08-22 まで、この検証は「特性多項式がモニックな次数 $2^L$ の元である」ことと、その人手証明の
  途中の見積もり（恒等置換の項・恒等でない置換の項・その総和の次数）も扱っていた。依存関係の集計で
  その主張を本文のどこも引いていないことが分かったため、本文から次数・モニック性の一連を削除し、
  この検証もそれに合わせて縮めた。
