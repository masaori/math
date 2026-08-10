# SageMath Check: 成分ごとの評価は単位行列を単位行列へ写す

## 対象

**対象ラベル**: `claim_qbar_matrix_eval_identity`（structured-latex 側の安定識別子）

- 本文: `structured-latex/content/main-text.ts` の章「固有値の代数性」の主張 1 件
- 併せて引く定義: `def_qbar_matrix_eval`（成分ごとの評価 $\mathrm{Ev}_{\xi}$）・
  `def_identity_matrix` と `def_constant_polynomial`（$\mathbb{Z}[x]$ の単位行列と $\kappa$）・
  `def_qbar_identity_matrix`（$\overline{\mathbb{Q}}$ の単位行列）・
  `def_partition_polynomial`（代入の約束）

### 何を確定させるための検証か

$U^{L}=I$（`theorem_shift_matrix_order`）は $\mathrm{Mat}_{R_L}(\mathbb{Z}[x])$ での等式である。
固有値を論じる場所は $\mathrm{Mat}_{R_L}(\overline{\mathbb{Q}})$ なので、この等式を
$\mathrm{Ev}_{\xi}$ で運ぶ必要がある。運ぶには 2 つの段が要る——$\mathrm{Ev}_{\xi}$ が冪を保つこと
（次のセクション。`claim_qbar_matrix_eval_product` からの帰納法）と、
**$\mathrm{Ev}_{\xi}$ が単位行列を単位行列へ写すこと**（この主張）である。
2 つの単位行列は成分の型が違う別の対象なので、等式として結ばなければ同一視になる。

確かめるのは次の 12 で、2 から 9 は人手証明の 2 つの場合それぞれの 4 段に 1 対 1 で対応する。

1. 添字集合。行配位の全体 $R_L$ が $2^{L}$ 個の元をもつこと。
2. $\tau=\tau'$ の第 1 段。$\mathrm{Ev}_{\xi}$ の定義（成分ごとの代入）。
3. $\tau=\tau'$ の第 2 段。$\mathbb{Z}[x]$ の単位行列の対角成分が $\kappa(1)$ であること
   （あわせてそれが $\mathbb{Z}[x]$ の単位元であること）。
4. $\tau=\tau'$ の第 3 段。代入が $\mathbb{Z}[x]$ の単位元を $\overline{\mathbb{Q}}$ の単位元へ送ること。
5. $\tau=\tau'$ の第 4 段。$\overline{\mathbb{Q}}$ の単位行列の対角成分が $1$ であること。
6. $\tau\ne\tau'$ の第 1 段。$\mathrm{Ev}_{\xi}$ の定義。
7. $\tau\ne\tau'$ の第 2 段。$\mathbb{Z}[x]$ の単位行列の非対角成分が $\kappa(0)$ であること
   （あわせてそれが $\mathbb{Z}[x]$ の零元であること）。
8. $\tau\ne\tau'$ の第 3 段。代入が零元を零元へ送ること。
9. $\tau\ne\tau'$ の第 4 段。$\overline{\mathbb{Q}}$ の単位行列の非対角成分が $0$ であること。
10. 主張そのもの。$\mathrm{Ev}_{\xi}(I)=I^{\overline{\mathbb{Q}}}_L$ が全成分で成り立つこと。
11. 主張が空虚でないこと。$\mathrm{Ev}_{\xi}(I)$ が零行列でないこと。
12. 型の区別。評価の前の成分が $\mathbb{Z}[x]$ の元、後の成分が $\overline{\mathbb{Q}}$ の元であること。

### 計算をどこで行っているか（$\overline{\mathbb{Q}}$ の扱い）

整係数多項式環は SageMath の `ZZ['x']`、代数的数の全体は `QQbar`（厳密な代数的数の体）で表した。
代入する $\xi$ には有理数のほか $\sqrt2$・$-\sqrt3$・$\sqrt{-1}$・$\sqrt[3]{5}$ を混ぜてある。
**浮動小数点は使っていない**（`ZZ` / `QQ` / `QQbar` の厳密計算だけ）。実数体にも複素数体にも入っていない。

## 走らせた範囲

- $L=1,2,3$（$R_L$ の元の個数はそれぞれ 2・4・8）、$\xi$ は 7 個。全成分について確かめた。

$L=4$ 以降を回していないのは、この主張が $L$ に依存せず、添字の 2 元が等しいか否かの場合分けしか
使っていないためである（$L$ を増やしても新しい場合が現れない）。

## 実行

```sh
sage sagemath/check/qbar-matrix-eval-identity/check.sage
```

## 結果

**2026-08-11 実行。すべて通過。**

```
== 成分ごとの評価は単位行列を単位行列へ写す ==
L=1: R_L は 2 元。7 個の ξ について 2 つの場合の 4 段すべてと Ev_ξ(I) = I^Qbar_L が成り立ち、値は零行列でない
L=2: R_L は 4 元。7 個の ξ について 2 つの場合の 4 段すべてと Ev_ξ(I) = I^Qbar_L が成り立ち、値は零行列でない
L=3: R_L は 8 元。7 個の ξ について 2 つの場合の 4 段すべてと Ev_ξ(I) = I^Qbar_L が成り立ち、値は零行列でない
すべて通過
```

## 四層のどこまで済んでいるか

**四層すべて**（記述・SageMath・Lean 具体版・Lean 必要十分版）。
Lean は `lean/Ising2DLambda/AlgebraicEigenvalue/QbarMatrixEval.lean`（具体版
`qbarMatrixEval_identity`）、
`lean/Ising2DLambda/NecSuf/AlgebraicEigenvalue/QbarMatrixEval.lean`（必要十分版
`matEval_identity_necSuf`）、
`lean/Ising2DLambda/AlgebraicEigenvalue/QbarMatrixEvalFromNecSuf.lean`
（具体版が必要十分版の特殊化であること）である（2026-08-11 に `lake build` と sorry 検査を通した）。
