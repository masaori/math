# `<tensor_basis>`（テンソル冪の基底）の必要十分版

対応する人手証明:
`parts/002_線型空間の一般論/000_theorem_テンソル積の基底は基底のテンソル積.typ` (`<tensor_basis>`)

| | ファイル | 主な宣言 |
| --- | --- | --- |
| 具体版（本文が実際に使う形） | `Ising2D/Representation.lean` | `Ising2D.matrixUnitBasis`（`E_{IJ}` の族） |
| 具体版（抽象テンソル積での表現） | `Ising2D/Part002/Theorem000_TensorBasis.lean` | `Ising2D.tensorPowBasis` / `Ising2D.matTensorPowBasis` |
| **必要十分版** | `Ising2D/NecSuf/TensorPowerBasis.lean` | `NecSuf.matrix_eq_sum_smul_single` / `NecSuf.sum_smul_single_apply` / `NecSuf.linearIndependent_single` / `NecSuf.matrixUnitBasis` / `NecSuf.basisOfLinearEquiv` |
| 対応づけ（導出） | `Ising2D/Part002/Theorem000_TensorBasisFromNecSuf.lean` | `Ising2D.EBasis` / `EBasis_apply` / `coe_EBasis_eq_matrixUnitBasis` / `matrix_eq_sum_E` / `kroneckerTensorPowBasis` |

## この主張が本文で使われる形（一次情報）

本文は抽象テンソル積を使わず `Mat(2,ℂ)^{⊗M}` を Kronecker 表現で扱う（README 2 節）。
`<tensor_basis>` が引かれるのは
`parts/002_線型空間の一般論/003_lemma_全行列と可換な行列はスカラー.typ` Step 1 の
「`cal(E) = { E_{IJ} : I,J ∈ {1,2}^M }` は基底である」の 1 箇所だけであり、
人手証明がそこで使う論法は **成分比較**——
「任意の行列 `A` は `A = Σ_{IJ} A_{IJ} E_{IJ}` と書け、係数は成分そのものだから一意」——である。

## 経緯（自戒として残す）

最初に書いた必要十分版は、mathlib の `Basis.piTensorProduct` / `Matrix.stdBasis` / `Basis.map` への
**別名定義だけ**で、証明が一切無かった。これは README 4 節の要件 3
（既製定理への丸投げ・別名定義は必要十分版と認めない）に反する。
旧称「抽象版」に引きずられ、**抽象的な概念を持ち込んで同じ主張を出し直す**形になっていた。
現在の版は人手証明と同じ成分比較の論法で書き直してある。

## 何が効いているか（証明が実際に使った仮定がすべて）

- 係数が**可換環**であること（線型独立性を係数の一意性から言うため）。
- 添字型が**有限**で**等号判定可能**であること。
- 行列の**成分ごとの計算**（`Matrix.single` の値と有限和の成分）。

## 何が効いていないか

- **複素数であること・体であること**。任意の可換環でよい。
- **次元が `2^M` であること・添字が `{1,2}^M` の形であること**。任意の有限型でよい。
- **`2 × 2` であること**。証明に `2` は 1 度も現れない。
- **テンソル積の一般論**。本文が使う「`E_{IJ}` の族が基底」の証明にテンソル積は現れない。
  すなわち人手証明が `<tensor_basis>`（テンソル積の定理）を根拠として引いているのは
  **必要以上に強い根拠**であり、成分比較だけで足りる。
- **線型代数の既製定理**。`Basis.mk` に渡す 2 条件（張ること・独立であること）を直接証明している。

## 副産物

- 抽象テンソル冪側の基底 `matTensorPowBasis` を ℂ-代数同型 `tensorPowAlgEquiv` で
  Kronecker 表現へ移した基底 `Ising2D.kroneckerTensorPowBasis`。移送に使うのは
  「基底は線型同型で移せる」`NecSuf.basisOfLinearEquiv` の 1 つだけ。
- mathlib の `Matrix.stdBasis` と同じ族であることの検算
  （`NecSuf.coe_matrixUnitBasis_eq_stdBasis`）。論法の差し替えではなく一致の確認である。
