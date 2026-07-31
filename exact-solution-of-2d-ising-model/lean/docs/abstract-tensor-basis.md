# `<tensor_basis>`（テンソル冪の基底）の抽象版

対応する人手証明:
`parts/002_線型空間の一般論/000_theorem_テンソル積の基底は基底のテンソル積.typ` (`<tensor_basis>`)

| | ファイル | 主な宣言 |
| --- | --- | --- |
| 具体版 | `Ising2D/Part002/Theorem000_TensorBasis.lean` | `Ising2D.tensorPowBasis` / `Ising2D.matTensorPowBasis` |
| 具体版（本文が実際に使う形） | `Ising2D/Representation.lean` | `Ising2D.matrixUnitBasis`（`E_{IJ}` の族） |
| **抽象版** | `Ising2D/Abstract/TensorPowerBasis.lean` | `Abstract.piTensorBasis` / `Abstract.tensorPowBasisOfBasis` / `Abstract.basisOfLinearEquiv` / `Abstract.matrixUnitBasis` |
| 対応づけ（導出） | `Ising2D/Part002/Theorem000_TensorBasisAbstract.lean` | `tensorPowBasis_eq_abstract` / `matTensorPowBasis_eq_abstract` / `matrixUnitBasis_eq_abstract` / `kroneckerTensorPowBasis` |

## 何が具体で何が抽象かの判断（一次情報）

本文は抽象テンソル積を使わず `Mat(2,ℂ)^{⊗M}` を Kronecker 表現で扱う（README 2 節）。
`<tensor_basis>` が本文で引かれるのは
`parts/002_線型空間の一般論/003_lemma_全行列と可換な行列はスカラー.typ` Step 1 の
「`cal(E) = { E_{IJ} : I,J ∈ {1,2}^M }` は基底である」の 1 箇所だけである
（`Theorem000_TensorBasis.lean` 冒頭のコメントにも同じことが書かれている）。
したがって「人手証明と 1 対 1 に対応する具体版」は **行列単位の族が基底であること**
（`Ising2D.matrixUnitBasis`）であり、抽象テンソル積による `tensorPowBasis` は
その見た目に近い別表現という位置づけになる。

## 抽象版で判明した「効いていたもの」

- 因子ごとに基底があること（`Basis (κ i) K (V i)`）。
- テンソル積を取る**因子の添字が有限**で等号判定可能であること。
- 係数が可換半環であること。
- 「基底は線型同型で移せる」こと（表現の取り替えに使う唯一の事実）。
- 行列単位の場合は、**添字型が有限で等号判定可能**であること。

## 抽象版で判明した「効いていなかったもの」

- **因子が全部同じ加群であること**。人手証明はテンソル**冪**で述べるが、
  証明は各因子が別々の加群でも通る（`Abstract.piTensorBasis`）。
  冪の場合（`Abstract.tensorPowBasisOfBasis`）は全因子を同じにしただけの特殊化。
- **係数が体であること**。可換半環で足りる（ℂ であることは効かない）。
- **加群が有限次元であること／基底の添字集合が有限であること**。
  有限性が要るのは因子の個数だけで、各因子の基底の添字集合は無限でよい。
- **`2 × 2` であること**。行列単位の基底は任意の有限添字型で成り立つ。
- **本文が実際に使う「`E_{IJ}` の族が基底」にはテンソル積の一般論が要らない。**
  必要なのは「行列単位が行列環の基底」＋「基底は線型同型で移せる」の 2 つだけで、
  `Ising2D.matrixUnitBasis = Abstract.matrixUnitBasis ℂ (Conf M)` は `rfl` で一致する。
  すなわち **具体版は過剰な構造を要求していない**（テンソル積経由の正当化は不要だった）。

## 副産物

抽象テンソル冪側の基底 `matTensorPowBasis` を ℂ-代数同型 `tensorPowAlgEquiv` で
Kronecker 表現へ移した基底 `Ising2D.kroneckerTensorPowBasis` を作り、その像が
各サイトに行列単位を載せた積 `siteProd` であることを示した
（人手証明 Step 3 後半の `σ_1^{a_1} ⋯ σ_M^{a_M} = e_1 ⊗ ⋯ ⊗ e_M` に対応）。
移送に使ったのは `Abstract.basisOfLinearEquiv` の 1 つだけである。
