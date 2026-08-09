# SageMath Check: シフト行列の特性多項式を、軌道を保つ置換にわたる和へ絞ること

## 対象

**対象ラベル**: `claim_non_orbit_preserving_term_zero` /
`claim_shift_char_sum_orbit_preserving`（structured-latex 側の安定識別子）

- 本文: `structured-latex/content/main-text.ts` の章「固有値の代数性」の主張 2 件
  （軌道を保たない置換の項が零元であること、および
  $\chi_U=\sum_{\varphi\in\mathfrak{S}^{\mathcal{O}}_L}\prod_{O}W_{O}(\mathrm{ch}(U),\varphi\!\restriction_O)$）
- 併せて使う定義・主張: `def_permutation_sign` / `def_constant_polynomial` /
  `def_second_constant_embedding` / `def_second_matrix` / `def_second_determinant` /
  `def_characteristic_matrix` / `def_characteristic_polynomial` / `def_shift_matrix` /
  `def_row_config_shift` / `def_row_config_order` / `def_row_config_orbit` /
  `def_row_config_orbit_set` / `def_orbit_preserving_permutation` /
  `claim_fixed_or_shift_preserves_orbit` / `claim_shift_char_term_zero` /
  `def_orbit_restriction` / `def_orbit_permutation_sign` / `def_orbit_term_factor` /
  `claim_orbit_term_factorization`

### 何を確定させるための検証か

$\chi_U$ を軌道ごとの因子の積へ組み替える道筋の最初の段である。行列式の定義の和は
$\mathfrak{S}_L$ の全体（$L=3$ で 40320 個）にわたるが、シフト行列の特性行列は成分の
大半が零元なので、残るのは軌道を保つ置換の項だけ（同 36 個）である。ここでその絞り込みを行い、
あわせて各項を前セクションの分解 $\prod_{O}W_{O}$ で書き換える。

1. `claim_non_orbit_preserving_term_zero`。$\mathfrak{S}_L$ の**全ての元**について
   「$\mathfrak{S}^{\mathcal{O}}_L$ に属さないならば項が零元である」を確かめる。
   あわせて、本文の証明が経由する対偶の段（$\varphi(\tau_1)\ne\tau_1$ かつ
   $\varphi(\tau_1)\ne S(\tau_1)$ を満たす $\tau_1$ が実際に取れること）も別に確かめる。
   **別に見る理由**: 最終の含意だけを見ると、結論が別の理由で成り立っていて
   本文の道筋（対偶）が実は使えない場合を見逃す。
2. `claim_shift_char_sum_orbit_preserving`。本文の式変形の 3 つの段を**別々に**確かめる。
   最終の等式だけを見ると、複数の段が同時に誤っていて辻褄が合う場合を見逃す。
   - $\chi_U=\mathrm{det}_t(\mathrm{ch}(U))=\sum_{\varphi\in\mathfrak{S}_L}\iota(\kappa(\mathrm{sgn}\varphi))\prod_\tau\mathrm{ch}(U)_{\tau,\varphi(\tau)}$
     （定義。和は $\mathfrak{S}_L$ の全体で取る）
   - 和を $\mathfrak{S}^{\mathcal{O}}_L$ へ狭めても値が変わらないこと
   - 各項を $\prod_{O}W_{O}(\mathrm{ch}(U),\varphi\!\restriction_O)$ へ置き換えても値が変わらないこと

### 主張が空でないことの確認（走らせた L ごとに記録する）

2026-08-09 の実行では次のとおりであった。

| $L$ | $\lvert\mathfrak{S}_L\rvert$ | $\lvert\mathfrak{S}^{\mathcal{O}}_L\rvert$ | 軌道を保たない置換（項が零元） | 零元でない項 |
|---|---|---|---|---|
| 1 | 2 個 | 1 個 | 1 個 | 1 個 |
| 2 | 24 個 | 2 個 | 22 個 | 2 個 |
| 3 | 40320 個 | 36 個 | 40284 個 | 4 個 |

走らせたすべての $L$ で、軌道を保たない置換が実際に存在し（上の 1 が空虚でない）、
零元でない項も存在する（上の 2 が $0=0$ を見ているだけではない）。
$L=3$ では $\mathfrak{S}^{\mathcal{O}}_L$ の 36 項のうち零元でないのは 4 項だけである。

### 独立な経路との突き合わせ（検証であって証明ではない）

次のセクション以降で示す $\chi_U=\prod_{O}(t^{\lvert O\rvert}-1)$ とも突き合わせている。
$L=1,2,3$ でいずれも一致した（軌道の大きさはそれぞれ $1,1$ / $1,1,2$ / $1,1,3,3$）。
**これは検証であって証明ではない。** ここで見ているのは、上の和が形だけ合っているのではなく、
値としても期待どおりであることの裏取りである。

### 走らせた範囲（打ち切りを隠さない）

| 主張 | 走らせた範囲 |
|---|---|
| 軌道を保たない置換の項が零元であること | $L=1,2,3$。$\mathfrak{S}_L$ の全ての元 |
| $\chi_U$ の和の絞り込みとその 3 段 | $L=1,2,3$ |

$L=3$ までに限ったのは、$\mathfrak{S}^{\mathcal{O}}_L$ を $\mathfrak{S}_L$ の全列挙から
絞って作っているためである（$L=4$ では $16!$ 通りになる）。軌道ごとの置換から組み立てれば
$L=4$ も回せるが、その組み立てが成り立つことは前のセクションの主張なので、
ここで前提にすると検証が循環する。この主張は $\mathfrak{S}_L$ の外の項が零元であることが
中身なので、そもそも $\mathfrak{S}_L$ の全列挙を避けられない。

### 計算の厳密性

有限集合の元の比較と数え上げ、整数 $-1$ の冪、および $\mathbb{Z}[x][t]$ の有限和と有限積だけである。
**浮動小数点は使わない。** 本文がこの範囲で $\mathbb{R}$ へ脱出していないので、
検証側にも脱出を持ち込まない。

## 実行結果

| 実行日 | 結果 |
|---|---|
| 2026-08-09 | すべて通過（軌道を保たない置換の項の消滅・対偶の段・$\chi_U$ の和の絞り込みとその 3 段・$\prod_O(t^{\lvert O\rvert}-1)$ との一致） |

```
sage sagemath/check/shift-char-sum/check.sage
```
