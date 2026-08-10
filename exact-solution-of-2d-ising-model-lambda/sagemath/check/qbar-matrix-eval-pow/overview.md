# SageMath Check: 成分ごとの評価は行列の冪を保つ

## 対象

**対象ラベル**: `claim_qbar_matrix_eval_pow`（structured-latex 側の安定識別子）

- 本文: `structured-latex/content/main-text.ts` の章「固有値の代数性」の主張 1 件
- 併せて引く定義: `def_matrix_over_row_configs`（$\mathbb{Z}[x]$ の行列と、その積・冪
  $A^{1}:=A$、$A^{k+1}:=A^{k}A$）・`def_qbar_matrix_eval`（成分ごとの代入 $\mathrm{Ev}_{\xi}$）・
  `def_qbar_matrix_product`（$\overline{\mathbb{Q}}$ の行列の積）・
  `def_qbar_matrix_power`（$A^{0}:=I^{\overline{\mathbb{Q}}}_L$、$A^{k+1}:=A\,A^{k}$）・
  `def_qbar_identity_matrix`・`def_row_configuration`（添字集合 $R_L$）
- 併せて引く主張: `claim_qbar_matrix_eval_product`（評価が積を保つこと。一歩で使う）・
  `claim_qbar_matrix_pow_succ_right`（冪が右から掛けても得られること。一歩の最後で使う）・
  `claim_qbar_identity_matrix_unit`（単位元。出発点で使う）

### 何を確定させるための検証か

$U^{L}=I$（`theorem_shift_matrix_order`）は $\mathrm{Mat}_{R_L}(\mathbb{Z}[x])$ の等式である。
シフト行列の固有値を論じるには、これを $\mathrm{Ev}_{\xi}$ で
$\mathrm{Mat}_{R_L}(\overline{\mathbb{Q}})$ の等式へ運ぶ必要があり、そのために要るのが本主張である。

2 つの冪は別の演算であることに注意する。$\mathbb{Z}[x]$ の側は $A^{1}:=A$ から始めて
右から掛け（$k\ge1$ でだけ定めてある）、$\overline{\mathbb{Q}}$ の側は
$A^{0}:=I^{\overline{\mathbb{Q}}}_L$ から始めて左から掛ける。出発点も一歩の向きも違うので、
帰納法の一歩で向きを揃える段（`claim_qbar_matrix_pow_succ_right`）が要る。

確かめるのは次の 12 で、2 から 9 は人手証明の帰納法（出発点 4 段・一歩 4 段）に対応する。

1. 添字集合。行配位の全体 $R_L$ が $2^{L}$ 個の元をもつこと。
2. 出発点の第 1 段。$\mathrm{Ev}_{\xi}(A^{1})=\mathrm{Ev}_{\xi}(A)$（$\mathbb{Z}[x]$ の冪の定義）。
3. 出発点の第 2 段。$\mathrm{Ev}_{\xi}(A)=\mathrm{Ev}_{\xi}(A)\,I^{\overline{\mathbb{Q}}}_L$（単位元の右から掛ける側）。
4. 出発点の第 3 段。$\mathrm{Ev}_{\xi}(A)\,I^{\overline{\mathbb{Q}}}_L=\mathrm{Ev}_{\xi}(A)\,(\mathrm{Ev}_{\xi}(A))^{0}$。
5. 出発点の第 4 段。$\mathrm{Ev}_{\xi}(A)\,(\mathrm{Ev}_{\xi}(A))^{0}=(\mathrm{Ev}_{\xi}(A))^{1}$。
6. 一歩の第 1 段。$\mathrm{Ev}_{\xi}(A^{k+1})=\mathrm{Ev}_{\xi}(A^{k}A)$（$\mathbb{Z}[x]$ の冪の定義）。
7. 一歩の第 2 段。$\mathrm{Ev}_{\xi}(A^{k}A)=\mathrm{Ev}_{\xi}(A^{k})\,\mathrm{Ev}_{\xi}(A)$（評価が積を保つこと）。
8. 一歩の第 3 段。帰納法の仮定 $\mathrm{Ev}_{\xi}(A^{k})=(\mathrm{Ev}_{\xi}(A))^{k}$ を当てること。
9. 一歩の第 4 段。$(\mathrm{Ev}_{\xi}(A))^{k}\,\mathrm{Ev}_{\xi}(A)=(\mathrm{Ev}_{\xi}(A))^{k+1}$（右から掛ける形の冪）。
10. 主張そのもの。$\mathrm{Ev}_{\xi}(A^{k})=(\mathrm{Ev}_{\xi}(A))^{k}$ が全成分で成り立つこと。
11. 主張が空虚でないこと。$A^{k}$ に定数でない多項式の成分があり、
    $(\mathrm{Ev}_{\xi}(A))^{k}$ が零行列でないこと。
12. 向きの違いが結果に効いていないこと。$\overline{\mathbb{Q}}$ の側を右から掛けて作った冪とも
    一致すること（`claim_qbar_matrix_pow_succ_right` の内容の再確認）。

### 計算をどこで行っているか（$\overline{\mathbb{Q}}$ の扱い）

多項式は `ZZ['x']`（整係数多項式環）、代数的数の全体は `QQbar`（厳密な代数的数の体）で表した。
代入する $\xi$ には $2$・$1/3$・$\sqrt2$・$\sqrt{-1}$ を使い、成分の多項式には定数・1 次・2 次を混ぜてある。
行列は乱数ではなく添字の順番から決まる形で作っており、実行するたび同じものになる。
**浮動小数点は使っていない**（`ZZ` / `QQ` / `QQbar` の厳密計算だけ）。実数体にも複素数体にも入っていない。

## 走らせた範囲

- $L=1,2,3$（$R_L$ の元の個数はそれぞれ 2・4・8）、$\xi$ は 4 個、$k=1,\dots,4$。全成分で 8 段すべてを確かめた。

$L=4$ 以降・$k=5$ 以降を回していないのは、この主張が $L$ にも $k$ にも $\xi$ にも依存せず、
帰納法の一歩が「評価が積を保つこと」と「冪が右から掛けても得られること」しか使っていないためである
（増やしても新しい場合は現れない）。

## 実行

```sh
sage sagemath/check/qbar-matrix-eval-pow/check.sage
```

## 結果

**2026-08-11 実行。すべて通過。**

```
== 成分ごとの評価は行列の冪を保つ ==
L=1: R_L は 2 元。ξ は 4 個、k=1,...,4 の全成分で出発点の 4 段・一歩の 4 段と Ev_ξ(A^k) = (Ev_ξ(A))^k が成り立ち、A^k には定数でない成分がある
L=2: R_L は 4 元。ξ は 4 個、k=1,...,4 の全成分で出発点の 4 段・一歩の 4 段と Ev_ξ(A^k) = (Ev_ξ(A))^k が成り立ち、A^k には定数でない成分がある
L=3: R_L は 8 元。ξ は 4 個、k=1,...,4 の全成分で出発点の 4 段・一歩の 4 段と Ev_ξ(A^k) = (Ev_ξ(A))^k が成り立ち、A^k には定数でない成分がある
すべて通過
```

## 四層のどこまで済んでいるか

**四層すべて**（記述・SageMath・Lean 具体版・Lean 必要十分版）。
Lean は `lean/Ising2DLambda/AlgebraicEigenvalue/QbarMatrixEvalPow.lean`（具体版
`qbarMatrixEval_pow`）と
`lean/Ising2DLambda/NecSuf/AlgebraicEigenvalue/EvalPow.lean`（必要十分版 `eval_pow_necSuf`）と
`lean/Ising2DLambda/AlgebraicEigenvalue/QbarMatrixEvalPowFromNecSuf.lean`（導出）である
（2026-08-11 に `lake build` と sorry 検査を通した）。

必要十分版が示したのは、この段が要求するのが**写像が積を保つこと 1 本と、2 つの冪の再帰の式 4 本と、
単位元を右から掛ける等式 1 本、および目標側の冪が右から掛けた形にも書けること 1 本の
合計 7 つだけ**であり、加法も零元も分配則も積の可換性も、型の代数構造も、添字の型の有限性も、
値が代数的数であることも、写像が環準同型であることも使っていないことである
（mathlib から何も import していない）。
