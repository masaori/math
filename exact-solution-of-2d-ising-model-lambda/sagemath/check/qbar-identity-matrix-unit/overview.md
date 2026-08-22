# SageMath Check: 代数的数を成分とする単位行列は積の単位元である

## 対象

**対象ラベル**: `claim_qbar_identity_matrix_unit`（structured-latex 側の安定識別子）

- 本文: `structured-latex/content/main-text.ts` の章「固有値の代数性」の主張 1 件
- 併せて引く定義: `def_qbar_matrix`（$\mathrm{Mat}_{R_L}(\overline{\mathbb{Q}})$）・
  `def_qbar_matrix_product`（成分ごとの有限和で定める積）・
  `def_qbar_identity_matrix`（$I^{\overline{\mathbb{Q}}}_L$）・`def_row_configuration`（添字集合 $R_L$）

### 何を確定させるための検証か

$U^{L}=I$（`theorem_shift_matrix_order`）を $\mathrm{Ev}_{\xi}$ で
$\mathrm{Mat}_{R_L}(\overline{\mathbb{Q}})$ へ運ぶには、$\mathrm{Ev}_{\xi}$ が行列の冪を保つことが要る。
2 つの冪は定め方が違う（$\mathbb{Z}[x]$ 側は $A^{1}:=A$ から右へ、$\overline{\mathbb{Q}}$ 側は
$A^{0}:=I^{\overline{\mathbb{Q}}}_L$ から左へ）ので、向きを合わせる段
$A^{k+1}=A^{k}A$ が要る。その帰納法の出発点で使うのが**この単位元の主張**であり、
一歩で使うのが結合則（`claim_qbar_matrix_product_assoc`）である。

既にある `claim_qbar_identity_action` は行列 1 つと列ベクトル 1 つについての主張なので、
行列 2 つについての等式はそれとは別に要る（とくに右から掛ける側は作用としては書けない）。

確かめるのは次の 14 で、2 から 11 は人手証明の 2 本の 7 段の鎖に対応する。

1. 添字集合。行配位の全体 $R_L$ が $2^{L}$ 個の元をもつこと。
2. 左から掛ける側の第 1 段。積の定義。
3. 左から掛ける側の第 2 段。有限和から $\tau'=\tau$ の 1 項を分けること。
4. 左から掛ける側の第 3 段。単位行列の定義（対角では $1$、対角の外では $0$）。
5. 左から掛ける側の第 4・5 段。単位元との積・零元との積。
6. 左から掛ける側の第 6・7 段。零元だけの有限和が零元であること・零元を足しても変わらないこと。
7. 右から掛ける側の第 1 段。積の定義。
8. 右から掛ける側の第 2 段。有限和から $\tau'=\tau''$ の 1 項を分けること。
9. 右から掛ける側の第 3 段。単位行列の定義（第 2 添字が第 1 添字に等しいときだけ $1$）。
10. 右から掛ける側の第 4・5 段。$a\cdot1=a$ と $a\cdot0=0$（左から掛ける側の 2 本とは別の等式である）。
11. 右から掛ける側の第 6・7 段。
12. 主張そのもの。$I^{\overline{\mathbb{Q}}}_LA=A$ と $AI^{\overline{\mathbb{Q}}}_L=A$ が全成分で成り立つこと。
13. 主張が空虚でないこと。$A$ も単位行列も零行列でないこと。
14. 積の可換性を使っていないこと。成分を非可換環（2 次上三角行列、$\mathbb{Z}$ 係数）に
    取り替えても 2 つの等式が成り立つこと。

### 計算をどこで行っているか（$\overline{\mathbb{Q}}$ の扱い）

代数的数の全体は `QQbar`（厳密な代数的数の体）で表した。成分に使う値には有理数のほか
$\sqrt2$・$-\sqrt3$・$\sqrt{-1}$・$\sqrt[3]{5}$ を混ぜてある。行列は乱数ではなく添字の順番から
決まる形で作っており、実行するたび同じものになる。
**浮動小数点は使っていない**（`ZZ` / `QQ` / `QQbar` の厳密計算だけ）。実数体にも複素数体にも入っていない。

## 走らせた範囲

- $L=1,2,3$（$R_L$ の元の個数はそれぞれ 2・4・8）。全成分について 2 本の鎖の 7 段すべてを確かめた。
- 非可換な成分での確認も $L=1,2,3$。

$L=4$ 以降を回していないのは、この主張が $L$ に依存せず、有限和から 1 項を分ける書き換えしか
使っていないためである（$L$ を増やしても新しい場合は現れない）。

## 実行

```sh
sage sagemath/check/qbar-identity-matrix-unit/check.sage
```

## 結果

**2026-08-11 実行。すべて通過。**

```
== 代数的数を成分とする単位行列は積の単位元である ==
L=1: R_L は 2 元。全成分で 2 本の鎖の 7 段すべてと I A = A・A I = A が成り立ち、A も単位行列も零行列でない
L=2: R_L は 4 元。全成分で 2 本の鎖の 7 段すべてと I A = A・A I = A が成り立ち、A も単位行列も零行列でない
L=3: R_L は 8 元。全成分で 2 本の鎖の 7 段すべてと I A = A・A I = A が成り立ち、A も単位行列も零行列でない
L=1: 成分を非可換環（2 次上三角行列）に取っても I A = A・A I = A が成り立つ（この段が積の可換性を使っていないこと）
L=2: 成分を非可換環（2 次上三角行列）に取っても I A = A・A I = A が成り立つ（この段が積の可換性を使っていないこと）
L=3: 成分を非可換環（2 次上三角行列）に取っても I A = A・A I = A が成り立つ（この段が積の可換性を使っていないこと）
すべて通過
```

## 四層のどこまで済んでいるか

**四層すべて**（記述・SageMath・Lean 具体版・Lean 必要十分版）。
Lean は `lean/Ising2DLambda/AlgebraicEigenvalue/QbarIdentityMatrixUnit.lean`（具体版
`qbarIdentityMatrix_mul`・`qbarMatrix_mul_qbarIdentityMatrix`）と
`lean/Ising2DLambda/NecSuf/AlgebraicEigenvalue/QbarIdentityActionRight.lean`（右から掛ける側の
必要十分版 `identity_action_right_necSuf`）と
`lean/Ising2DLambda/AlgebraicEigenvalue/QbarIdentityMatrixUnitFromNecSuf.lean`（導出）である
（2026-08-11 に `lake build` と sorry 検査を通した）。

**左から掛ける側の必要十分版は新しく書いていない。** 要るものは既にある
`Ising2DLambda.NecSuf.AlgebraicEigenvalue.identity_action_necSuf`
（`claim_qbar_identity_action` の必要十分版）そのもので、列ベクトルを $A$ の第 $\tau''$ 列と
取ればこの等式になる。右から掛ける側は、単位行列の成分が掛かる向きも場合分けの条件の向きも
違うため、$a\cdot1=a$ と $a\cdot0=0$ を仮定に取る別の必要十分版を書いた
（積の可換性を仮定しない以上、左の版から得ることはできない）。

### 記録

- 2026-08-22 に本文の側を一般化した。この節の線型代数は、行配位の全体ではなく
  **空でない有限集合 $\mathcal{J}$** を添字集合として述べてある。この検証は $\mathcal{J}=R_L$
  （行配位の全体）に取った場合を小さい $L$ で総当たりに固定するものであり、**一般の
  $\mathcal{J}$ についての標本**である。行配位であることを使う性質は本文でも使っていない。
