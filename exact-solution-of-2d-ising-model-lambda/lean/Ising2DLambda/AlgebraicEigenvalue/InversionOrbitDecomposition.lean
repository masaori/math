/-
章「固有値の代数性」の「転倒数の軌道ごとの分解」の具体版
（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは定義 3 件
（`def_inversion_pairs` / `def_orbit_inversion_count` / `def_cross_orbit_inversion_pairs`）と
主張 2 件（`claim_orbit_inner_inversion_pairs` /
`claim_inversion_count_orbit_decomposition`）に対応する。

  人手証明                                    このファイル
  Inv(φ)                                      inversionPairs
  inv(φ) = |Inv(φ)|                           inversionCount_eq_card_inversionPairs
  inv_O(ψ)                                    orbitInversionCount
  Inv^≠(φ)                                    crossOrbitInversionPairs
  Inv^=(φ)（証明の中だけの記号）               sameOrbitInversionPairs
  A(O)                                        innerInversionPairs
  軌道の中の転倒対 = 制限の転倒対（集合の等号） card_innerInversionPairs の第 1 段
  |A(O)| = inv_O(φ↾_O)                        card_innerInversionPairs
  inv(φ) = Σ_O inv_O(φ↾_O) + |Inv^≠(φ)|       inversionCount_orbit_decomposition

`inv_O(ψ)` の持ち方について 1 つ断っておく。人手証明の `ψ` は `O` から `O` への全単射だが、
ここでは `O` の上で値を取る ambient の写像として受ける（`orbitInversionCount` の `g`）。
理由は、**人手証明の主張が集合の等号だから**である。部分型 `{τ // τ ∈ O}` の上の写像として
持つと、両辺が別々の型の Finset になり、人手証明が「同じ集合である」と言っているところが
「個数を一致させる 1 対 1 対応」に変わってしまう。`g` の `O` の外での値が結果に効かないことは
`orbitInversionCount_congr` で別に示してある（この持ち方が値を漏らしていないことの検査）。

mathlib の `Equiv.Perm.sign` と群作用の軌道の一般論は引いていない。
使ったのは `Finset.card_filter_add_card_filter_not`（人手証明の「述語で 2 つに分ける」）と
`Finset.card_biUnion`（人手証明の「互いに素な族の合併の個数は個数の和」）だけである。

住処: 人手証明のこれらのブロックは ℕ を宣言している。
ここに ℝ / ℂ は現れない（添字は行配位、個数は ℕ）。
-/
import Ising2DLambda.AlgebraicEigenvalue.CrossOrbitInversions
import Mathlib.Algebra.BigOperators.Group.Finset.Basic

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 人手証明の定義「置換の転倒対の全体」`Inv(φ) = { (τ,τ') ∈ P_L | φ(τ') ≺ φ(τ) }`。 -/
noncomputable def inversionPairs (L : ℕ) [NeZero L] (φ : Equiv.Perm (RowConfig L)) :
    Finset (RowConfig L × RowConfig L) :=
  (orderedPairs L).filter fun p => rowConfigLess L (φ p.2) (φ p.1)

/-- 人手証明が定義の中で書いている `inv(φ) = |Inv(φ)|`。定義の書き換えなので `rfl`。 -/
theorem inversionCount_eq_card_inversionPairs (φ : Equiv.Perm (RowConfig L)) :
    inversionCount L φ = (inversionPairs L φ).card := rfl

/-- 人手証明の定義「軌道の上の全単射の転倒数」`inv_O(ψ)`。

台は `F(O,O)`（`crossOrderedPairs L O O`）、順序は `R_L` の上の `≺` をそのまま使う。
`ψ` は `g` の `O` への制限として受ける（ファイル冒頭の断り書きを見よ）。 -/
noncomputable def orbitInversionCount (L : ℕ) [NeZero L] (O : Finset (RowConfig L))
    (g : RowConfig L → RowConfig L) : ℕ :=
  ((crossOrderedPairs L O O).filter fun p => rowConfigLess L (g p.2) (g p.1)).card

/-- `inv_O(ψ)` は `g` の `O` の中での値だけで決まる（ambient の写像として持ったことが
値を漏らしていないことの検査）。人手証明の `ψ : O → O` が well-defined であることに対応する。 -/
theorem orbitInversionCount_congr {O : Finset (RowConfig L)} {g g' : RowConfig L → RowConfig L}
    (h : ∀ τ ∈ O, g τ = g' τ) : orbitInversionCount L O g = orbitInversionCount L O g' := by
  classical
  unfold orbitInversionCount
  congr 1
  apply Finset.filter_congr
  intro p hp
  rw [mem_crossOrderedPairs] at hp
  rw [h p.1 hp.1.1, h p.2 hp.1.2]

/-- 人手証明の `φ↾_O` を、`orbitInversionCount` へ渡せる形（ambient の写像）にしたもの。

`O` の中では `orbitRestriction`（部分型の上の制限）の値をそのまま取り、外では `φ` の値を取る。
外での値は `orbitInversionCount` の台 `F(O,O) ⊂ O × O` に効かない
（`orbitInversionCount_congr`）。 -/
noncomputable def orbitRestrictionAmbient {φ : Equiv.Perm (RowConfig L)}
    (hφ : OrbitPreserving L φ) {O : Finset (RowConfig L)} (hO : O ∈ rowShiftOrbitSet L)
    (τ : RowConfig L) : RowConfig L :=
  open Classical in
  if h : τ ∈ O then (orbitRestriction hφ hO ⟨τ, h⟩).1 else φ τ

/-- 人手証明の証明の最初の段「制限は値を変えず、定義域と終域だけを `O` へ取り替えた写像である」。 -/
theorem orbitRestrictionAmbient_eq {φ : Equiv.Perm (RowConfig L)} (hφ : OrbitPreserving L φ)
    {O : Finset (RowConfig L)} (hO : O ∈ rowShiftOrbitSet L) {τ : RowConfig L} (hτ : τ ∈ O) :
    orbitRestrictionAmbient hφ hO τ = φ τ := by
  classical
  simp [orbitRestrictionAmbient, hτ, orbitRestriction_val]

/-- 人手証明の定義「軌道をまたぐ転倒対の全体」`Inv^≠(φ)`。 -/
noncomputable def crossOrbitInversionPairs (L : ℕ) [NeZero L] (φ : Equiv.Perm (RowConfig L)) :
    Finset (RowConfig L × RowConfig L) :=
  open Classical in
  (inversionPairs L φ).filter fun p => rowShiftOrbit L p.1 ≠ rowShiftOrbit L p.2

/-- 人手証明の `Inv^=(φ)`（証明の中だけで使う記号）。 -/
noncomputable def sameOrbitInversionPairs (L : ℕ) [NeZero L] (φ : Equiv.Perm (RowConfig L)) :
    Finset (RowConfig L × RowConfig L) :=
  open Classical in
  (inversionPairs L φ).filter fun p => rowShiftOrbit L p.1 = rowShiftOrbit L p.2

/-- 人手証明の `A(O)`。 -/
noncomputable def innerInversionPairs (L : ℕ) [NeZero L] (φ : Equiv.Perm (RowConfig L))
    (O : Finset (RowConfig L)) : Finset (RowConfig L × RowConfig L) :=
  (inversionPairs L φ).filter fun p => p.1 ∈ O ∧ p.2 ∈ O

variable {φ : Equiv.Perm (RowConfig L)}

lemma mem_inversionPairs {p : RowConfig L × RowConfig L} :
    p ∈ inversionPairs L φ ↔ rowConfigLess L p.1 p.2 ∧ rowConfigLess L (φ p.2) (φ p.1) := by
  simp [inversionPairs, Finset.mem_filter, mem_orderedPairs]

/-- 人手証明の主張「1 つの軌道の中の転倒対の個数は、制限の転倒数である」。

人手証明どおり、まず**集合の等号**を示し、個数はそこから取る。 -/
theorem card_innerInversionPairs (hφ : OrbitPreserving L φ) {O : Finset (RowConfig L)}
    (hO : O ∈ rowShiftOrbitSet L) :
    (innerInversionPairs L φ O).card
      = orbitInversionCount L O (orbitRestrictionAmbient hφ hO) := by
  classical
  -- 人手証明の最初の段: 制限は値を変えない。
  have hval : orbitInversionCount L O (orbitRestrictionAmbient hφ hO)
      = orbitInversionCount L O φ :=
    orbitInversionCount_congr fun τ hτ => orbitRestrictionAmbient_eq hφ hO hτ
  -- 人手証明の式変形（Inv の定義 → P_L の定義 → O ⊂ R_L → F(O,O) の定義）。集合の等号である。
  have hset : innerInversionPairs L φ O
      = (crossOrderedPairs L O O).filter fun p => rowConfigLess L (φ p.2) (φ p.1) := by
    ext p
    simp only [innerInversionPairs, Finset.mem_filter, mem_inversionPairs,
      mem_crossOrderedPairs]
    tauto
  rw [hval, orbitInversionCount, ← hset]

/-- 人手証明の Step 1。 -/
theorem card_same_add_card_cross (L : ℕ) [NeZero L] (φ : Equiv.Perm (RowConfig L)) :
    (sameOrbitInversionPairs L φ).card + (crossOrbitInversionPairs L φ).card
      = (inversionPairs L φ).card := by
  classical
  rw [sameOrbitInversionPairs, crossOrbitInversionPairs]
  exact Finset.card_filter_add_card_filter_not (s := inversionPairs L φ)
    (p := fun p => rowShiftOrbit L p.1 = rowShiftOrbit L p.2)

/-- 人手証明の Step 2 の 2 つの包含。 -/
theorem sameOrbitInversionPairs_eq_biUnion (L : ℕ) [NeZero L] (φ : Equiv.Perm (RowConfig L)) :
    sameOrbitInversionPairs L φ
      = (rowShiftOrbitSet L).biUnion (innerInversionPairs L φ) := by
  classical
  ext p
  simp only [sameOrbitInversionPairs, innerInversionPairs, Finset.mem_filter,
    Finset.mem_biUnion]
  constructor
  · -- ⊂: O := O(p.1) を取る。τ ∈ O(τ) と、O(p.1) = O(p.2) を使う。
    rintro ⟨hinv, hsame⟩
    exact ⟨rowShiftOrbit L p.1, mem_rowShiftOrbitSet.mpr ⟨p.1, rfl⟩, hinv,
      self_mem_rowShiftOrbit p.1, hsame ▸ self_mem_rowShiftOrbit p.2⟩
  · -- ⊃: 「軌道の元の軌道はもとの軌道に等しい」を 2 度当てる。
    rintro ⟨O, hO, hinv, h1, h2⟩
    obtain ⟨τ, hτ⟩ := mem_rowShiftOrbitSet.mp hO
    subst hτ
    exact ⟨hinv, (rowShiftOrbit_eq_of_mem τ h1).trans (rowShiftOrbit_eq_of_mem τ h2).symm⟩

/-- 人手証明の Step 2 の「A(O) たちは互いに素である」。

「相異なる 2 つの軌道は互いに素」（`claim_row_config_orbit_partition`）による。 -/
theorem innerInversionPairs_disjoint (L : ℕ) [NeZero L] (φ : Equiv.Perm (RowConfig L)) :
    ∀ O₁ ∈ rowShiftOrbitSet L, ∀ O₂ ∈ rowShiftOrbitSet L, O₁ ≠ O₂ →
      Disjoint (innerInversionPairs L φ O₁) (innerInversionPairs L φ O₂) := by
  classical
  intro O₁ hO₁ O₂ hO₂ hne
  refine Finset.disjoint_left.mpr ?_
  intro p hp₁ hp₂
  simp only [innerInversionPairs, Finset.mem_filter] at hp₁ hp₂
  -- p.1 が O₁ ∩ O₂ に属するので、2 つの軌道は一致してしまう。
  exact disjoint_of_ne_of_mem_orbitSet hO₁ hO₂ hne hp₁.2.1 hp₂.2.1

/-- 人手証明の主張「転倒数は、軌道ごとの転倒数の和と、またぐ転倒対の個数の和である」。 -/
theorem inversionCount_orbit_decomposition (hφ : OrbitPreserving L φ) :
    inversionCount L φ
      = (∑ O ∈ (rowShiftOrbitSet L).attach,
          orbitInversionCount L O.1 (orbitRestrictionAmbient hφ O.2))
        + (crossOrbitInversionPairs L φ).card := by
  classical
  have hsplit := card_same_add_card_cross L φ
  have hsame : (sameOrbitInversionPairs L φ).card
      = ∑ O ∈ (rowShiftOrbitSet L).attach, (innerInversionPairs L φ O.1).card := by
    rw [sameOrbitInversionPairs_eq_biUnion L φ,
      Finset.card_biUnion (innerInversionPairs_disjoint L φ), ← Finset.sum_attach]
  have hterm : ∀ O ∈ (rowShiftOrbitSet L).attach,
      (innerInversionPairs L φ O.1).card
        = orbitInversionCount L O.1 (orbitRestrictionAmbient hφ O.2) := by
    intro O _
    exact card_innerInversionPairs hφ O.2
  rw [Finset.sum_congr rfl hterm] at hsame
  rw [inversionCount_eq_card_inversionPairs]
  omega

end Ising2DLambda.AlgebraicEigenvalue
