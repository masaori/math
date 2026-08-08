# SageMath Check: シフト行列の特性多項式の消えない項の同定

## 対象

**対象ラベル**: `claim_shift_char_matrix_entry_zero` / `claim_shift_char_term_zero` /
`def_orbit_preserving_permutation` / `claim_fixed_or_shift_preserves_orbit` /
`claim_orbit_preserving_image`（structured-latex 側の安定識別子）

- 本文: `structured-latex/content/main-text.ts` の章「固有値の代数性」の主張 2 件
  （特性行列の成分が対角と $\tau'=S(\tau)$ を除いて零元であること・
  それ以外の値を取る置換の項が零元であること）・定義 1 件（軌道を保つ置換 $\mathfrak{S}^{\mathcal{O}}_L$）・
  主張 2 件（各行配位をそれ自身かその像へ送る置換は軌道を保つ・軌道を保つ置換は各軌道をそれ自身へ写す）
- 併せて使う定義・主張: `def_row_configuration` / `def_column_translation` / `def_row_config_shift` /
  `def_row_config_shift_iterate` / `claim_row_config_shift_period` / `def_row_config_orbit` /
  `claim_row_config_orbit_mem_eq` / `def_row_config_orbit_set` / `def_shift_matrix` /
  `def_permutation_sign` / `def_second_determinant` / `def_characteristic_matrix` /
  `def_characteristic_polynomial` / `def_second_constant_embedding` / `def_constant_polynomial`

### 何を確定させるための検証か

シフト行列 $U$ の特性多項式 $\chi_U=\mathrm{det}_t(\mathrm{ch}(U))$ は、定義上 $|R_L|!$ 個の
置換にわたる和である。本文はそのうち零元でない項を持ちうるものが「各行配位を同じ軌道の中へ送る置換」
だけであることを示す。これは次のセクションで $\chi_U$ を軌道ごとの因子 $t^{|O|}-1$ の積へ
分解するための足場である。

1. `claim_shift_char_matrix_entry_zero`。$\tau'\ne\tau$ かつ $\tau'\ne S(\tau)$ ならば
   $\mathrm{ch}(U)_{\tau,\tau'}=\iota(\kappa(0))$。行配位の全対を総当たりする。
   あわせて**残りの成分（対角と $\tau'=S(\tau)$）が零元でないこと**も見る。
   すべての成分が零元でも主張自体は成り立ってしまい、主張が空になるからである。
2. `claim_shift_char_term_zero`。$\varphi(\tau_1)$ が $\tau_1$ でも $S(\tau_1)$ でもない
   $\tau_1$ を持つ置換 $\varphi$ の項が零元であること。$\mathfrak{S}_L$ の全置換を走る。
   あわせて、条件を満たさない置換の項に**零元でないものが実際にある**ことも見る。
3. `def_orbit_preserving_permutation` と `claim_fixed_or_shift_preserves_orbit`。
   各 $\tau$ を $\tau$ か $S(\tau)$ へ送る置換が軌道を保つこと。全置換を走る。
4. `claim_orbit_preserving_image`。軌道を保つ置換 $\varphi$ と軌道 $O$ について
   $\varphi(O)=O$ であること。**最終の等号だけを見ない。** 人手証明の 2 段、すなわち
   (a) 包含 $\varphi(O)\subset O$ と (b) 単射性から出る $|\varphi(O)|=|O|$ を別々に確かめる。
   等号だけを見ると、包含を出す議論が誤っていても個数が合ってしまう場合を見逃す。
5. 1〜3 を合わせた形。$\chi_U$ の和を「軌道を保つ置換の項だけ」に絞っても値が変わらないこと。
   さらに、本文の $\chi_U$ が Sage 自身の行列式で作った $\det(tI-U)$ と一致すること。
   作り方が独立（Sage の行列式は置換にわたる和ではない）なので、置換の走らせ方や符号の向きの
   取り違えを検出できる。

### 主張が空でないことの確認

- $L=3$ では全 40320 置換のうち 40316 個が「消える項」に当たり、残る 4 個の項はいずれも
  零元ではない。すなわち主張は「全部消える」という空虚な内容ではない。
- 軌道を保つ置換は、$L=3$ で 36 個ある。一方「各 $\tau$ を $\tau$ か $S(\tau)$ へ送る置換」は 4 個であり、
  両者は一致しない。本文の主張が一方向（後者ならば前者）であることと整合する。
- $L\ge2$ では大きさ 2 以上の軌道が実際にあるので、$\varphi(O)=O$ は 1 元集合の上の自明な等式ではない。

### 参考（まだ証明していないこと）

次のセクションの目標である $\chi_U=\prod_{O\in\mathcal{O}_L}\bigl(t^{|O|}-1\bigr)$ が、
走らせた $L$ で実際に成り立つことも記録してある（`check_target`）。
**これは検証であって証明ではない。** 本文にはまだこの等式は無い。

### 走らせた範囲（打ち切りを隠さない）

| $L$ | 行配位 $\lvert R_L\rvert$ | 置換 $\lvert\mathfrak{S}_L\rvert$ | 消える項 | 軌道を保つ置換 | 軌道の大きさ |
|---|---|---|---|---|---|
| 1 | 2 | 2 | 1 | 1 | 1, 1 |
| 2 | 4 | 24 | 22 | 2 | 1, 1, 2 |
| 3 | 8 | 40320 | 40316 | 36 | 1, 1, 3, 3 |
| 4 | 16 | — | — | — | — |

成分についての 1 は $L=1,2,3,4$ で行配位の全対を総当たりしている。
置換を走る 2〜5 は $L=1,2,3$ に限った。置換の個数が $(2^{L})!$ であり、$L=4$ では $16!$ となって
総当たりできないためである（表の $L=4$ の欄が空なのはそのためで、通らなかったからではない）。
$L$ の全体は無限集合なので、$L$ は有限個の値に限っている。

### 計算の厳密性

すべて `ZZ` / `ZZ[x]` / `ZZ[x][t]` の厳密計算で行う。**浮動小数点は使わない。**
本文がこの範囲で $\mathbb{R}$ へ脱出していないので、検証側にも脱出を持ち込まない。

## 実行結果

| 実行日 | 結果 |
|---|---|
| 2026-08-09 | すべて通過（成分は $L=1,\dots,4$、置換を走るものは $L=1,2,3$） |

```
sage sagemath/check/shift-matrix-characteristic-term/check.sage
```
