# SageMath Check: シフト行列の固有値は 1 の L 乗根である

## 対象

**対象ラベル**: `claim_shift_matrix_eigenvalue_root_of_unity`（structured-latex 側の安定識別子）

- 本文: `structured-latex/content/main-text.ts` の章「固有値の代数性」の主張 1 件
- 併せて引く定義: `def_shift_matrix`（シフト行列 $U$）・`def_qbar_matrix_eval`（成分ごとの評価
  $\mathrm{Ev}_{\xi}$）・`def_qbar_eigenvalue` と `def_qbar_eigenvector`（固有値と固有ベクトル）・
  `def_root_of_unity_set`（1 の冪根の全体 $\mu_L$）・`def_qbar_vector_smul`（スカラー倍）・
  `def_qbar_zero_vector`（零ベクトル）
- 併せて引く主張: `theorem_shift_matrix_order`（$U^{L}=I$）・`claim_qbar_matrix_eval_pow`・
  `claim_qbar_matrix_eval_identity`・`claim_qbar_eigenvector_pow`・`claim_qbar_identity_action`・
  `claim_qbar_smul_eq_zero`

### 何を確定させるための検証か

シフト行列の固有値の同定である。$U^{L}=I$ を $\mathrm{Ev}_{\xi}$ で $\overline{\mathbb{Q}}$ の
行列の等式へ運び、固有ベクトルへ $L$ 乗を作用させて $z^{L}\odot v=v$ を出し、
$(z^{L}+(-1))\odot v=o_L$ と $v\ne o_L$ から $z^{L}=1$ を取り出す。**行列式の理論を経由していない**
（非自明な核を持つ行列の行列式が零元であることを立てずに済ませている）。

確かめるのは次の 8 で、2 から 5 は人手証明の 3 つの鎖と最後の段に対応する。

1. 添字集合とシフト行列。$R_L$ が $2^{L}$ 元で、$U_{\tau,\tau'}$ が $\tau'=S(\tau)$ のとき $1$、
   そうでないとき $0$ であること。
2. 第 1 の鎖の 3 段。$\bigl(\mathrm{Ev}_{\xi}(U)\bigr)^{L}=\mathrm{Ev}_{\xi}(U^{L})
   =\mathrm{Ev}_{\xi}(I)=I^{\overline{\mathbb{Q}}}_L$。あわせて $\mathrm{Ev}_{\xi}(U)$ が
   $\xi$ の取り方によらないこと（成分が定数多項式であることの帰結）。
3. 第 2 の鎖の 3 段。固有ベクトル $v$ について
   $z^{L}\odot v=\bigl(\mathrm{Ev}_{\xi}(U)\bigr)^{L}\cdot v=I^{\overline{\mathbb{Q}}}_L\cdot v=v$。
4. 第 3 の鎖（各点の計算）。$\bigl(z^{L}+(-1)\bigr)\odot v$ が零ベクトルであること。
5. 最後の段。$z^{L}+(-1)=0$、すなわち $z^{L}=1$ であること。
6. 主張そのもの。$\mathrm{Ev}_{\xi}(U)$ の固有値がすべて $\mu_L$ に属すること。
7. 主張が空虚でないこと。相異なる固有値がちょうど $L$ 個現れ、それが 1 の $L$ 乗根の全体
   $\{\zeta_L^{m}\mid m=0,\dots,L-1\}$ に一致すること。
8. 仮定が効いていること。1 の $L$ 乗根でない代数的数（$2$ と $\sqrt2$）については
   $\mathrm{Ev}_{\xi}(U)-zI$ の核が $0$ 次元であり、固有値になっていないこと。

### 計算をどこで行っているか（$\overline{\mathbb{Q}}$ の扱い）

整係数多項式環は `ZZ['x']`、代数的数の全体は `QQbar`（厳密な代数的数の体）で表した。
代入する点 $\xi$ には $0$・$1$・$2$・$-1/3$・$\sqrt2$・$\sqrt{-1}$ の 6 個を使い、
固有値と固有ベクトルは `eigenvectors_right()` の厳密計算で取っている。
**浮動小数点は使っていない**。実数体にも複素数体にも入っていない。

## 走らせた範囲

- $L=1,\dots,5$（$R_L$ の元の個数はそれぞれ 2・4・8・16・32）、$\xi$ は 6 個。
  固有ベクトルは各 $L$ で $2^{L}$ 本（固有空間の基底）を確かめた。

$L=6$ を回していないのは、$64$ 行 $64$ 列の行列の固有ベクトルを `QQbar` で取る計算が重く、
かつこの主張の証明が $L$ に依存しないためである（証明が使うのは $U^{L}=I$ と冪の保存だけで、
軌道の形にも $L$ の約数構造にも触れていない）。

## 実行

```sh
sage sagemath/check/shift-matrix-eigenvalue-root-of-unity/check.sage
```

## 結果

**2026-08-11 実行。すべて通過。**

```
== シフト行列の固有値は 1 の L 乗根である ==
L=1: R_L は 2 元。xi 6 個で Ev_xi(U) が一致し、固有値 1 個（相異なるもの 1 個）すべてが mu_L に属し、固有ベクトル 2 本で鎖の各段が成立した
L=2: R_L は 4 元。xi 6 個で Ev_xi(U) が一致し、固有値 2 個（相異なるもの 2 個）すべてが mu_L に属し、固有ベクトル 4 本で鎖の各段が成立した
L=3: R_L は 8 元。xi 6 個で Ev_xi(U) が一致し、固有値 3 個（相異なるもの 3 個）すべてが mu_L に属し、固有ベクトル 8 本で鎖の各段が成立した
L=4: R_L は 16 元。xi 6 個で Ev_xi(U) が一致し、固有値 4 個（相異なるもの 4 個）すべてが mu_L に属し、固有ベクトル 16 本で鎖の各段が成立した
L=5: R_L は 32 元。xi 6 個で Ev_xi(U) が一致し、固有値 5 個（相異なるもの 5 個）すべてが mu_L に属し、固有ベクトル 32 本で鎖の各段が成立した
すべて通過
```

## 四層のどこまで済んでいるか

**四層すべて**（記述・SageMath・Lean 具体版・Lean 必要十分版）。
Lean は `lean/Ising2DLambda/AlgebraicEigenvalue/ShiftMatrixEigenvalueRootOfUnity.lean`
（具体版 `shiftMatrix_eigenvalue_rootOfUnity`。第 1 の鎖は補題
`qbarMatrixEval_shiftMatrix_pow_L`）と
`lean/Ising2DLambda/NecSuf/AlgebraicEigenvalue/EigenvaluePowEqOne.lean`
（必要十分版 `eigenvalue_pow_eq_one_necSuf`）と
`lean/Ising2DLambda/AlgebraicEigenvalue/ShiftMatrixEigenvalueRootOfUnityFromNecSuf.lean`（導出）である
（2026-08-11 に `lake build` と sorry 検査を通した）。

必要十分版が示したのは、この段が要求するのが**12 の等式だけ**であり、
**指数がそこに現れない**ことである（具体版の $z^{L}$ は 1 つの元として扱えば足り、
それが冪であることも $L$ が何であることも使わない）。行列であること（`M` は勝手な型で
作用は勝手な写像）、積の可換性・結合則、一般の元の加法逆元、型の代数構造、
添字の型の有限性・相等の決定可能性、値が代数的数であることは、いずれも使っていない
（mathlib から何も import していない）。
