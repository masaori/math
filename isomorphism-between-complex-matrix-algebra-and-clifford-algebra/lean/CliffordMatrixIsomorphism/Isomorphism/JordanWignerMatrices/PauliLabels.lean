/-
節「系：複素行列版イジングの Jordan–Wigner 行列への接続」の後半が添字に使う、Pauli 行列の名前の集合 {x, y, z} と、
Jordan–Wigner 行列の因子の種類の集合 {y, z}。必要十分版は `NecSuf/Isomorphism/JordanWignerMatrices/PauliLabels.lean` に同じ形で置く。

  本文の箇所                                                                 このファイル
  def_site_pauli_matrices_indexed_by_numbers の a ∈ {x, y, z}                PauliLabel
  def_factors_of_jordan_wigner_matrices_indexed_by_numbers の b ∈ {y, z}     JordanWignerLabel・JordanWignerLabel.toPauliLabel

本文は σ^{b}_{m}（b ∈ {y, z}）を def_site_pauli_matrices_indexed_by_numbers の a := b の場合として書く。{y, z} は {x, y, z} の
部分集合なので、Lean では {y, z} の元を {x, y, z} の同じ名前の元へ送る写像 `JordanWignerLabel.toPauliLabel` に名前を付け、
この写像を通してだけ σ^{a}_{k} に渡す。
-/

namespace CliffordMatrixIsomorphism.Isomorphism

/-- 本文 `def_site_pauli_matrices_indexed_by_numbers` の a ∈ {x, y, z}。 -/
inductive PauliLabel
  | x
  | y
  | z

/-- 本文 `def_factors_of_jordan_wigner_matrices_indexed_by_numbers` の b ∈ {y, z}。 -/
inductive JordanWignerLabel
  | y
  | z

/-- 本文 `def_factors_of_jordan_wigner_matrices_indexed_by_numbers` の σ^{b}_{m} で、b ∈ {y, z} を
{x, y, z} の同じ名前の元として渡す写像。 -/
def JordanWignerLabel.toPauliLabel : JordanWignerLabel → PauliLabel
  | .y => .y
  | .z => .z

end CliffordMatrixIsomorphism.Isomorphism
