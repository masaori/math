/-
節「テンソル代数」の、つなげた組の主張で使う番号の書き直し。本文の「r ∈ {1,…,k} は {1,…,k+l} の元でもある」と
「k + r ∈ {1,…,k+l}」を、同じ番号の自然数を `Idx (k + l)` の元として書く写像に名前を付けたもの。

このファイルは ℂ を含まないので、具体版（`Concatenation.lean`）と必要十分版
（`NecSuf/MathematicalToolkit/TensorAlgebra/Concatenation.lean`）が同じものを引く。
-/
import CliffordMatrixIsomorphism.MathematicalToolkit.FiniteSetSum.Numbering

namespace CliffordMatrixIsomorphism

/-- 本文の「r ∈ {1,…,k} は {1,…,k+l} の元でもある」：同じ番号 r を {1,…,k+l} の元として書く。 -/
def Idx.inFirst {k : ℕ} (l : ℕ) (r : Idx k) : Idx (k + l) :=
  ⟨r.1, r.2.1, by have := r.2.2; omega⟩

/-- 本文の「k + r ∈ {1,…,k+l}」：r ∈ {1,…,l} から番号 k + r の {1,…,k+l} の元を作る。 -/
def Idx.inSecond (k : ℕ) {l : ℕ} (r : Idx l) : Idx (k + l) :=
  ⟨k + r.1, by have := r.2.1; omega, by have := r.2.2; omega⟩

end CliffordMatrixIsomorphism
