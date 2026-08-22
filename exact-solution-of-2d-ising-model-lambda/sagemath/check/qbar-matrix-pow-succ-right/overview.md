# SageMath Check: 代数的数を成分とする行列の冪は右から掛けても得られる

## 対象

**対象ラベル**: `claim_qbar_matrix_pow_succ_right`（structured-latex 側の安定識別子）

- 本文: `structured-latex/content/main-text.ts` の章「固有値の代数性」の主張 1 件
- 併せて引く定義: `def_qbar_matrix`（$\mathrm{Mat}_{R_L}(\overline{\mathbb{Q}})$）・
  `def_qbar_matrix_product`（成分ごとの有限和で定める積）・
  `def_qbar_identity_matrix`（$I^{\overline{\mathbb{Q}}}_L$）・
  `def_qbar_matrix_power`（$A^{0}:=I^{\overline{\mathbb{Q}}}_L$、$A^{k+1}:=A\,A^{k}$）・
  `def_row_configuration`（添字集合 $R_L$）
- 併せて引く主張: `claim_qbar_identity_matrix_unit`（単位元。出発点で使う）・
  `claim_qbar_matrix_product_assoc`（結合則。一歩で使う）

### 何を確定させるための検証か

$U^{L}=I$（`theorem_shift_matrix_order`）を $\mathrm{Ev}_{\xi}$ で
$\mathrm{Mat}_{R_L}(\overline{\mathbb{Q}})$ へ運ぶには、$\mathrm{Ev}_{\xi}$ が行列の冪を保つことが要る。
その帰納法の一歩で、2 つの冪の向きが合わない（$\mathbb{Z}[x]$ 側は $A^{1}:=A$ から右へ、
$\overline{\mathbb{Q}}$ 側は $A^{0}:=I^{\overline{\mathbb{Q}}}_L$ から左へ）。
向きを揃える段が本主張 $A^{k+1}=A^{k}A$ である。

確かめるのは次の 12 で、2 から 9 は人手証明の帰納法（出発点 5 段・一歩 4 段）に対応する。

1. 添字集合。行配位の全体 $R_L$ が $2^{L}$ 個の元をもつこと。
2. 出発点の第 1・2 段。$A^{0+1}=A\,A^{0}=A\,I^{\overline{\mathbb{Q}}}_L$（冪の定義）。
3. 出発点の第 3 段。$A\,I^{\overline{\mathbb{Q}}}_L=A$（単位元の右から掛ける側）。
4. 出発点の第 4 段。$A=I^{\overline{\mathbb{Q}}}_L\,A$（単位元の左から掛ける側。左右の 2 つがどちらも要る）。
5. 出発点の第 5 段。$I^{\overline{\mathbb{Q}}}_L\,A=A^{0}A$（冪の定義）。
6. 一歩の第 1 段。$A^{(k+1)+1}=A\,A^{k+1}$（冪の定義）。
7. 一歩の第 2 段。帰納法の仮定 $A^{k+1}=A^{k}A$ を当てること。
8. 一歩の第 3 段。$A(A^{k}A)=(A\,A^{k})A$（結合則）。
9. 一歩の第 4 段。$(A\,A^{k})A=A^{k+1}A$（冪の定義）。
10. 主張そのもの。$A^{k+1}=A^{k}A$ が全成分で成り立つこと。
11. 主張が空虚でないこと。$A^{k}$ が零行列でなく、$k\ge1$ では $A^{k+1}\ne A^{k}$ であること。
12. 積の可換性を使っていないこと。成分を非可換環（2 次上三角行列、$\mathbb{Z}$ 係数）に
    取り替えても等式が成り立つこと。

### 計算をどこで行っているか（$\overline{\mathbb{Q}}$ の扱い）

代数的数の全体は `QQbar`（厳密な代数的数の体）で表した。成分に使う値には有理数のほか
$\sqrt2$・$-\sqrt3$・$\sqrt{-1}$・$\sqrt[3]{5}$ を混ぜてある。行列は乱数ではなく添字の順番から
決まる形で作っており、実行するたび同じものになる。
**浮動小数点は使っていない**（`ZZ` / `QQ` / `QQbar` の厳密計算だけ）。実数体にも複素数体にも入っていない。

## 走らせた範囲

- $L=1,2,3$（$R_L$ の元の個数はそれぞれ 2・4・8）、$k=0,\dots,4$。全成分で 9 段すべてを確かめた。
- 非可換な成分での確認も $L=1,2,3$・$k=0,\dots,4$。

$L=4$ 以降・$k=5$ 以降を回していないのは、この主張が $L$ にも $k$ にも依存せず、
帰納法の一歩が単位元と結合則しか使っていないためである（増やしても新しい場合は現れない）。
$L=3$・$k=4$ でも `QQbar` の厳密計算は元の次数が上がって重く、実測で 5 分ほどかかる。

## 実行

```sh
sage sagemath/check/qbar-matrix-pow-succ-right/check.sage
```

## 結果

**2026-08-11 実行。すべて通過。**

```
== 代数的数を成分とする行列の冪は右から掛けても得られる ==
L=1: R_L は 2 元。k=0,...,4 の全成分で出発点の 5 段・一歩の 4 段と A^{k+1} = A^k A が成り立ち、A^k は零行列でない
L=2: R_L は 4 元。k=0,...,4 の全成分で出発点の 5 段・一歩の 4 段と A^{k+1} = A^k A が成り立ち、A^k は零行列でない
L=3: R_L は 8 元。k=0,...,4 の全成分で出発点の 5 段・一歩の 4 段と A^{k+1} = A^k A が成り立ち、A^k は零行列でない
L=1: 成分を非可換環（2 次上三角行列）に取っても k=0,...,4 で A^{k+1} = A^k A が成り立つ（この段が積の可換性を使っていないこと）
L=2: 成分を非可換環（2 次上三角行列）に取っても k=0,...,4 で A^{k+1} = A^k A が成り立つ（この段が積の可換性を使っていないこと）
L=3: 成分を非可換環（2 次上三角行列）に取っても k=0,...,4 で A^{k+1} = A^k A が成り立つ（この段が積の可換性を使っていないこと）
すべて通過
```

## 四層のどこまで済んでいるか

**四層すべて**（記述・SageMath・Lean 具体版・Lean 必要十分版）。
Lean は `lean/Ising2DLambda/AlgebraicEigenvalue/QbarMatrixPowSuccRight.lean`（具体版
`qbarMatrixPow_succ_right`）と
`lean/Ising2DLambda/NecSuf/AlgebraicEigenvalue/PowSuccRight.lean`（必要十分版
`pow_succ_right_necSuf`）と
`lean/Ising2DLambda/AlgebraicEigenvalue/QbarMatrixPowSuccRightFromNecSuf.lean`（導出）である
（2026-08-11 に `lake build` と sorry 検査を通した）。

必要十分版が示したのは、この段が要求するのが**2 本の再帰の式と、単位元の左右 2 つの等式と、
両端が $A$ の三つ組についての結合則の 5 つだけ**であり、加法も零元も分配則も積の可換性も、
一般の結合則も、型の代数構造も、添字の型の有限性も、値が代数的数であることも
使っていないことである（mathlib から何も import していない）。

### 記録

- 2026-08-22 に本文の側を一般化した。この節の線型代数は、行配位の全体ではなく
  **空でない有限集合 $\mathcal{J}$** を添字集合として述べてある。この検証は $\mathcal{J}=R_L$
  （行配位の全体）に取った場合を小さい $L$ で総当たりに固定するものであり、**一般の
  $\mathcal{J}$ についての標本**である。行配位であることを使う性質は本文でも使っていない。
