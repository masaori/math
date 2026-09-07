/-
# 全スピン反転行列の固有値 -1 の固有ベクトル全体

対応する人手本文は `structured-latex/content/004_transfer_matrix.ts` の
`transfer_matrix_004_definition_eigenspace_odd_of_epsilon`
（ラベル **`def_odd_eigenvectors_of_epsilon`**）。

本文と同じく、抽象線型写像を経由せず、具体的な複素行列 `epsilon M` の
数ベクトルへの作用だけで定義する。部分空間であることは後続の別単位で扱う。
-/
import Ising2D.Part004.Definition000_TransferMatrixSymbols

namespace Ising2D

open Matrix

/-- **人手本文 `def_odd_eigenvectors_of_epsilon`**:
全スピン反転行列を左から掛けると符号が反転する複素数ベクトルの集合 `𝓕⁽⁻⁾`。 -/
def oddEigenvectors (M : ℕ) (_hM : 1 ≤ M) : Set (Conf M → ℂ) :=
  {f | epsilon M *ᵥ f = -f}

end Ising2D
