/-
`claim_twisted_modes_complex_roots_bijection` の必要十分版。

具体版と同じ手順（候補 e_0, …, e_{L-1} が E に属すること、e_j = e_k から j - k = nL を経て
-L < j - k < L・n = 0・j = k を出すこと、E の元が L 個以下なので E = {e_k | k < L}・|E| = L、
写像の像が E に含まれ単射で定義域が L 個の元を持つので像が E に一致すること）を、
集合と写像だけで書く。仮定は次のとおりである。
  - mem: 各候補 e_k は E に属する（具体版では指数関数の加法法則による e_{L,c,k}^L = (-1)^c）。
  - period: e_j = e_k なら j - k = nL となる n ∈ ℤ がある（具体版では指数関数の周期性と ℂ の四則）。
    これを外すと候補が重なり、E の元の個数が L に届かない。
  - finite・ncardLe: E は有限で元は L 個以下（具体版では次数 L の多項式の相異なる根の個数の上界）。
    有限性を外すと Set.ncard が 0 を返し、E = {e_k} が従わない。
  - mapsTo・injOn・cardU: 写像 f は U を E へ送り、U の上で単射で、U は L 個の元を持つ
    （具体版では `claim_complex_realization_twisted_modes_are_complex_roots`・
    `claim_complex_realization_injective`・`claim_twisted_mode_sets_card`）。具体版が使う
    大域的な単射性は要らず、U の上の単射性で足りる。
γ・α に演算は要らない（複素数体の構造は mem・period・ncardLe の中にしか現れない）。
-/
import Mathlib.Data.Set.Card
import Mathlib.Data.Finset.Range
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

namespace Ising2DLambda.NecSuf.RealEscape

/-- 整数の段: 0 ≤ j, k < L かつ j - k = nL なら j = k。 -/
theorem natLt_eq_of_sub_eq_mul_necSuf (L j k : ℕ) (hjL : j < L) (hkL : k < L) (n : ℤ)
    (hZ : (j : ℤ) - k = n * L) : j = k := by
  have hlow : -(L : ℤ) < (j : ℤ) - k := by omega
  have hhigh : (j : ℤ) - k < L := by omega
  have hn0 : n = 0 := by
    rcases lt_trichotomy n 0 with h | h | h
    · have : n * (L : ℤ) ≤ -(L : ℤ) := by nlinarith
      omega
    · exact h
    · have : (L : ℤ) ≤ n * (L : ℤ) := by nlinarith
      omega
  rw [hn0, zero_mul] at hZ
  omega

/-- 候補の単射性: 周期性と整数の段から。 -/
theorem candidate_injOn_necSuf {γ : Type*} (L : ℕ) (e : ℕ → γ)
    (period : ∀ j k : ℕ, e j = e k → ∃ n : ℤ, (j : ℤ) - k = n * L) :
    Set.InjOn e (Finset.range L : Set ℕ) := by
  intro j hj k hk hjk
  obtain ⟨n, hZ⟩ := period j k hjk
  exact natLt_eq_of_sub_eq_mul_necSuf L j k (Finset.mem_range.mp hj) (Finset.mem_range.mp hk) n hZ

/-- E = {e_k | k < L} かつ |E| = L。 -/
theorem rootSet_eq_candidates_necSuf {γ : Type*} (L : ℕ) (e : ℕ → γ) (E : Set γ)
    (mem : ∀ k : ℕ, e k ∈ E)
    (period : ∀ j k : ℕ, e j = e k → ∃ n : ℤ, (j : ℤ) - k = n * L)
    (finite : E.Finite) (ncardLe : E.ncard ≤ L) :
    E = e '' (Finset.range L : Set ℕ) ∧ E.ncard = L := by
  have hcand : (e '' (Finset.range L : Set ℕ)).ncard = L := by
    rw [(candidate_injOn_necSuf L e period).ncard_image, Set.ncard_coe_finset, Finset.card_range]
  have hsub : e '' (Finset.range L : Set ℕ) ⊆ E := by
    rintro _ ⟨k, -, rfl⟩
    exact mem k
  have heq : E = e '' (Finset.range L : Set ℕ) :=
    (Set.eq_of_subset_of_ncard_le hsub (by rw [hcand]; exact ncardLe) finite).symm
  exact ⟨heq, by rw [heq, hcand]⟩

/-- 必要十分版: f|_U : U → E は全単射。 -/
theorem bijOn_rootSet_necSuf {α γ : Type*} (L : ℕ) (e : ℕ → γ) (E : Set γ)
    (mem : ∀ k : ℕ, e k ∈ E)
    (period : ∀ j k : ℕ, e j = e k → ∃ n : ℤ, (j : ℤ) - k = n * L)
    (finite : E.Finite) (ncardLe : E.ncard ≤ L)
    (f : α → γ) (U : Set α) (mapsTo : Set.MapsTo f U E) (injOn : Set.InjOn f U)
    (cardU : U.ncard = L) :
    Set.BijOn f U E := by
  obtain ⟨-, hE⟩ := rootSet_eq_candidates_necSuf L e E mem period finite ncardLe
  refine ⟨mapsTo, injOn, ?_⟩
  have himage : (f '' U).ncard = L := by rw [injOn.ncard_image, cardU]
  have heq : f '' U = E :=
    Set.eq_of_subset_of_ncard_le mapsTo.image_subset (by rw [hE, himage]) finite
  exact heq.symm.subset

end Ising2DLambda.NecSuf.RealEscape
