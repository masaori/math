# SageMath Check: 転送行列はシフト行列の各固有空間をそれ自身へ写す

## 対象

**対象ラベル**: `claim_qbar_transfer_preserves_shift_eigenspace`
（structured-latex 側の安定識別子）

- 本文: `structured-latex/content/main-text.ts` の章「固有値の代数性」の主張 1 件
- 併せて引く定義・主張: `def_qbar_matrix`・`def_qbar_vector`・`def_qbar_matrix_product`・
  `def_qbar_matrix_action`・`def_qbar_vector_smul`・`def_qbar_zero_vector`・
  `def_qbar_eigenspace`・`def_shift_matrix`・`def_transfer_matrix`・`def_qbar_matrix_eval`・
  `claim_qbar_commuting_preserves_eigenspace`・`claim_qbar_shift_transfer_commute`

### 何を確定させるための検証か

転送行列をシフト行列の固有空間へ分ける（対角化する）ための組み立ての段である。
可換な行列が固有空間を保つこと（`claim_qbar_commuting_preserves_eigenspace`）と、
評価で運んだ 2 つの行列が可換であること（`claim_qbar_shift_transfer_commute`）は
既に示してあるので、この段はその 2 つを $A=\mathrm{Ev}_{\xi}(U)$、$B=\mathrm{Ev}_{\xi}(T)$ へ
当てはめるだけである。**新しい論法は無い。**

したがってここで確かめるのは、当てはめの入力が実際に成り立つことと、当てはめた結論が
成り立つことである。確かめるのは次の 7 である。

1. 添字集合と 2 つの行列。$R_L$ が $2^{L}$ 個の元をもち、$U$ と $T$ の成分が定義どおりであること。
2. 当てはめの入力その 1。$\mathrm{Ev}_{\xi}(U)\,\mathrm{Ev}_{\xi}(T)=\mathrm{Ev}_{\xi}(T)\,\mathrm{Ev}_{\xi}(U)$。
3. 当てはめの入力その 2。各軌道から作った $v$ が $E_{\mathrm{Ev}_{\xi}(U)}(z)$ に属し、
   零ベクトルでないこと（主張が空虚でないこと）。
4. 主張そのもの。$\mathrm{Ev}_{\xi}(U)\cdot(\mathrm{Ev}_{\xi}(T)\cdot v)=z\odot(\mathrm{Ev}_{\xi}(T)\cdot v)$。
5. **固有空間が実際に閉じていること。** 軌道から作った 1 本だけでなく、同じ固有値に属する
   元どうしの和とスカラー倍で作った元についても、転送行列の像がその固有空間に留まること
   （固有空間が和とスカラー倍で閉じることは `claim_qbar_eigenspace_add` /
   `claim_qbar_eigenspace_smul` で示してあり、その上でこの主張が使えることの確認である）。
6. **可換性が効いていること。** $\mathrm{Ev}_{\xi}(U)$ と可換でない行列に取り替えると結論が
   実際に破れること（$L\ge2$ で確かめている。$L=1$ では $R_L$ が 2 元で
   $\mathrm{Ev}_{\xi}(U)$ が対合になり、可換でない行列単位が結論を破らない場合がある）。
7. $v=o_L$（零ベクトル）の場合も主張が成り立つこと。本文がこの主張から $v\ne o_L$ を
   落としている（固有ベクトルではなく固有空間について述べている）ことに対応する。

### 計算をどこで行っているか（$\overline{\mathbb{Q}}$ の扱い）

整係数多項式環は `ZZ['x']`、代数的数の全体は SageMath の `QQbar`（厳密な代数的数の体）で
表した。固有値は `QQbar.zeta(e)` が与える 1 の原始 $e$ 乗根の逆元である。
**浮動小数点は使っていない**。実数体にも複素数体にも入っていない。

## 走らせた範囲

- $L=1,2,3,4$（$R_L$ の元の個数はそれぞれ 2・4・8・16）。
- 代入する点 $\xi$ は 4 個（$2$・$-1/3$・$\sqrt2$・$\sqrt{-1}$）。
  転送行列の成分は $x$ の冪なので、シフト行列と違い値は $\xi$ に依存する。
- 固有ベクトルは各軌道から 1 本ずつ作り、すべての軌道について主張を確かめた。
  さらに、同じ固有値に属する元の組ごとに $v_i+3v_j$ を作って確かめた。

$L=5$ 以降を回していないのは、この段が組み立てだけであり（証明も $R_L$ が有限であることしか
使っていない）、$L$ を増やしても新しい場合が現れないためである。

## 実行

```sh
sage sagemath/check/qbar-transfer-preserves-shift-eigenspace/check.sage
```

## 結果

**2026-08-11 実行。すべて通過。**

```
== 転送行列はシフト行列の各固有空間をそれ自身へ写す ==
L=1: R_L は 2 元。xi 4 個 × 軌道 2 個の 8 通りで主張が成り立ち、和とスカラー倍で作った 16 通りでも固有空間に留まる。可換でない行列では結論が破れる（L>=2）。v = o_L の場合も成り立つ
L=2: R_L は 4 元。xi 4 個 × 軌道 3 個の 12 通りで主張が成り立ち、和とスカラー倍で作った 20 通りでも固有空間に留まる。可換でない行列では結論が破れる（L>=2）。v = o_L の場合も成り立つ
L=3: R_L は 8 元。xi 4 個 × 軌道 4 個の 16 通りで主張が成り立ち、和とスカラー倍で作った 32 通りでも固有空間に留まる。可換でない行列では結論が破れる（L>=2）。v = o_L の場合も成り立つ
L=4: R_L は 16 元。xi 4 個 × 軌道 6 個の 24 通りで主張が成り立ち、和とスカラー倍で作った 56 通りでも固有空間に留まる。可換でない行列では結論が破れる（L>=2）。v = o_L の場合も成り立つ
すべて通過
```
