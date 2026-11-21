/-
節「テンソル代数」の、つなげた組の主張で使う番号の書き直しの必要十分版。具体版 `MathematicalToolkit/TensorAlgebra/IndexShift.lean` と
同じ def を、必要十分版の名前空間に置く。ℂ を含まないので、形は具体版と同じである。
-/
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.FiniteSetSum.Numbering

namespace CliffordMatrixIsomorphism.NecSuf

/-- 本文の「r ∈ {1,…,k} は {1,…,k+l} の元でもある」：同じ番号 r を {1,…,k+l} の元として書く。 -/
def Idx.inFirst {k : ℕ} (l : ℕ) (r : Idx k) : Idx (k + l) :=
  ⟨r.1, r.2.1, by have := r.2.2; omega⟩

/-- 本文の「k + r ∈ {1,…,k+l}」：r ∈ {1,…,l} から番号 k + r の {1,…,k+l} の元を作る。 -/
def Idx.inSecond (k : ℕ) {l : ℕ} (r : Idx l) : Idx (k + l) :=
  ⟨k + r.1, by have := r.2.1; omega, by have := r.2.2; omega⟩

end CliffordMatrixIsomorphism.NecSuf
