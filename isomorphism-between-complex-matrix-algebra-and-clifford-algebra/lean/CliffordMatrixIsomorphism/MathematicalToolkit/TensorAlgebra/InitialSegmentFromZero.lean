/-
節「テンソル代数」の主張 `claim_numbering_of_initial_segment_from_zero`：{0,…,N} の番号付け e(s) := s - 1。

  本文のラベル                                   このファイル
  claim_numbering_of_initial_segment_from_zero   UpTo（{0,…,N}）・upToNumbering（e）・upToNumbering_isNumbering・
                                                 isFiniteSet_upTo

{0,…,N} は ℕ の部分型 `UpTo N` で表す。このファイルは ℂ を含まないので、具体版と必要十分版が同じものを引く。
-/
import CliffordMatrixIsomorphism.MathematicalToolkit.FiniteSetSum.Numbering

namespace CliffordMatrixIsomorphism

/-- {0,…,N}。 -/
abbrev UpTo (N : ℕ) := {i : ℕ // i ≤ N}

/-- 本文 `claim_numbering_of_initial_segment_from_zero` の写像 e : {1,…,N+1} → {0,…,N}、e(s) := s - 1。
1 ≤ s ≤ N + 1 なら 0 ≤ s - 1 ≤ N なので、値は {0,…,N} に入る。 -/
def upToNumbering (N : ℕ) : Idx (N + 1) → UpTo N :=
  fun s => ⟨s.1 - 1, by have := s.2.2; omega⟩

/-- 本文 `claim_numbering_of_initial_segment_from_zero`：(N + 1, e) は {0,…,N} の番号付けである。
（単射）e(s) = e(t) なら s = e(s) + 1 = e(t) + 1 = t。（全射）i について s := i + 1 は e(s) = i を満たす。 -/
theorem upToNumbering_isNumbering (N : ℕ) : IsNumbering (N + 1) (upToNumbering N) where
  injective s t h := by
    have h' : s.1 - 1 = t.1 - 1 := congrArg Subtype.val h
    have hs := s.2.1
    have ht := t.2.1
    exact Subtype.ext (by omega)
  surjective i := ⟨⟨i.1 + 1, by omega, by have := i.2; omega⟩,
    Subtype.ext (by show i.1 + 1 - 1 = i.1; omega)⟩

/-- 本文 `claim_numbering_of_initial_segment_from_zero`：{0,…,N} は有限集合である。 -/
theorem isFiniteSet_upTo (N : ℕ) : IsFiniteSet (UpTo N) :=
  ⟨N + 1, upToNumbering N, upToNumbering_isNumbering N⟩

end CliffordMatrixIsomorphism
