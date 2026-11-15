/-
「符号付き偶部分グラフ多項式の軌道ごとの明示積」（`claim_signed_even_subgraph_orbit_product`）の
証明のうち、明示積の平方が行列式に等しいこと（`(P^{a,b}_L)^2 = D^{a,b}_L`）の具体版。
定数項と一意性から `P^{a,b}_L = Q^{a,b}_L` を合成する段は別のファイルで行う。

本文と同じ順に次を示す。必要十分版を呼ばない。
- 軌道の集合 `𝔐 := {O(m) : m ∈ 𝒦}`、軌道の代表元、`Δ_O`、一元軌道の `F_O`、明示積 `P^{a,b}_L` の定義。
- `Δ_O` は元の選択に依らない（`claim_dispersion_inversion_invariant` の具体版を二度引く）。
- 二つの軌道が交われば一致する（逆元操作は互いに可換な対合）。
- 一元軌道では `F_O^2 = Δ_O`（`claim_dispersion_special_mode_squares` の具体版）。
- 平方の五行: 冪の法則、一元軌道の平方、軌道の元数と `Δ_O` の不変性、`𝔐` が `𝒦` の分割であること、
  `claim_dispersion_mode_product` の具体版。

住処は Qbar と Qbar[x]。実数体・複素数体は使わない。
-/
import Ising2DLambda.KacWard.DispersionModeProduct
import Ising2DLambda.KacWard.ModeInversionOrbitCardinality
import Ising2DLambda.KacWard.DispersionSpecialModeSquares

namespace Ising2DLambda.KacWard

open Polynomial
open Ising2DLambda.AlgebraicEigenvalue
open Classical

/-- 軌道の集合 `𝔐^{a,b}_L := {O(m) : m ∈ 𝒦}`（`𝒦 = 𝒰_a × 𝒲_b`）。 -/
noncomputable def modeInversionOrbits (L : ℕ) [NeZero L] (s : SpinStructure) :
    Finset (Finset (Qbar × Qbar)) :=
  Finset.univ.image (fun m : FourierModePair L s => modeInversionOrbit m.1.1 m.1.2)

/-- 軌道の代表元（本文の「任意の元 `m`」を一つ選んだもの）。空集合には使わない。 -/
noncomputable def orbitRepresentative (O : Finset (Qbar × Qbar)) : Qbar × Qbar :=
  if h : O.Nonempty then h.choose else (1, 1)

/-- `Δ_O := Δ(x; ϖ, ς)`（`(ϖ, ς)` は `O` の代表元）。 -/
noncomputable def orbitDispersion (O : Finset (Qbar × Qbar)) : QbarPoly :=
  dispersionPolynomial (orbitRepresentative O).1 (orbitRepresentative O).2

/-- 一元軌道 `O = {(ϖ, ς)}` の因子 `F_O`。 -/
noncomputable def oneElementOrbitFactor (O : Finset (Qbar × Qbar)) : QbarPoly :=
  if orbitRepresentative O = (1, 1) then 1 - 2 * X - X ^ 2
  else if orbitRepresentative O = (-1, -1) then 1 + 2 * X - X ^ 2
  else 1 + X ^ 2

/-- 明示積 `P^{a,b}_L := ∏_{|O|=1} F_O · ∏_{|O|=2} Δ_O · ∏_{|O|=4} Δ_O^2`。 -/
noncomputable def orbitExplicitProduct (L : ℕ) [NeZero L] (s : SpinStructure) : QbarPoly :=
  (∏ O ∈ (modeInversionOrbits L s).filter (fun O => O.card = 1), oneElementOrbitFactor O) *
    (∏ O ∈ (modeInversionOrbits L s).filter (fun O => O.card = 2), orbitDispersion O) *
    (∏ O ∈ (modeInversionOrbits L s).filter (fun O => O.card = 4), orbitDispersion O ^ 2)

/-- `(ϖ, ς) ∈ O(ϖ, ς)`。 -/
theorem mem_modeInversionOrbit_self (varpi varsigma : Qbar) :
    (varpi, varsigma) ∈ modeInversionOrbit varpi varsigma := by
  simp [modeInversionOrbit]

/-- `z ≠ 0` で `y ∈ {z, z⁻¹}` なら `{y, y⁻¹} = {z, z⁻¹}`（逆元操作は対合）。 -/
theorem inversionPair_eq_of_mem {z y : Qbar} (hz : z ≠ 0)
    (hy : y ∈ ({z, z⁻¹} : Finset Qbar)) :
    ({y, y⁻¹} : Finset Qbar) = {z, z⁻¹} := by
  simp only [Finset.mem_insert, Finset.mem_singleton] at hy
  rcases hy with rfl | rfl
  · rfl
  · rw [mode_inv_inv hz, Finset.pair_comm]

/-- 本文「逆元操作は互いに可換な対合なので、二つの軌道が交われば一致する」:
`p ∈ O(ϖ, ς)` なら `O(p) = O(ϖ, ς)`。 -/
theorem modeInversionOrbit_eq_of_mem {varpi varsigma : Qbar} (hvarpi : varpi ≠ 0)
    (hvarsigma : varsigma ≠ 0) {p : Qbar × Qbar}
    (hp : p ∈ modeInversionOrbit varpi varsigma) :
    modeInversionOrbit p.1 p.2 = modeInversionOrbit varpi varsigma := by
  rw [modeInversionOrbit_eq_product, Finset.mem_product] at hp
  rw [modeInversionOrbit_eq_product, modeInversionOrbit_eq_product,
    inversionPair_eq_of_mem hvarpi hp.1, inversionPair_eq_of_mem hvarsigma hp.2]

/-- モード集合の元の座標は零でない（`claim_dispersion_inversion_invariant` の証明の三行）。 -/
theorem fourierModePair_ne_zero {L : ℕ} [NeZero L] {s : SpinStructure} (m : FourierModePair L s) :
    m.1.1 ≠ 0 ∧ m.1.2 ≠ 0 :=
  ⟨twistedMode_ne_zero (Nat.one_le_iff_ne_zero.mpr (NeZero.ne L)) s.1 m.1.1 m.2.1,
    twistedMode_ne_zero (Nat.one_le_iff_ne_zero.mpr (NeZero.ne L)) s.2 m.1.2 m.2.2⟩

/-- `Δ` は軌道の上で一定である: `p ∈ O(m)` なら `Δ(x; p) = Δ(x; m)`
（`claim_dispersion_inversion_invariant` の具体版を `m` と `(ϖ⁻¹, ς)` に引く）。 -/
theorem dispersion_eq_of_mem_modeInversionOrbit {L : ℕ} [NeZero L] {s : SpinStructure}
    (m : FourierModePair L s) {p : Qbar × Qbar}
    (hp : p ∈ modeInversionOrbit m.1.1 m.1.2) :
    dispersionPolynomial p.1 p.2 = dispersionPolynomial m.1.1 m.1.2 := by
  have hL : 1 ≤ L := Nat.one_le_iff_ne_zero.mpr (NeZero.ne L)
  obtain ⟨hvarpiInv, -, hh, hv⟩ := dispersion_inversion_invariant hL s m.2.1 m.2.2
  obtain ⟨-, -, -, hv'⟩ := dispersion_inversion_invariant hL s hvarpiInv m.2.2
  simp only [modeInversionOrbit, Finset.mem_insert, Finset.mem_singleton] at hp
  rcases hp with rfl | rfl | rfl | rfl
  · rfl
  · exact hh
  · exact hv
  · exact hv'.trans hh

/-- `𝔐` の元は、ある `m ∈ 𝒦` の軌道である。 -/
theorem mem_modeInversionOrbits {L : ℕ} [NeZero L] {s : SpinStructure}
    {O : Finset (Qbar × Qbar)} (hO : O ∈ modeInversionOrbits L s) :
    ∃ m : FourierModePair L s, modeInversionOrbit m.1.1 m.1.2 = O := by
  simpa [modeInversionOrbits] using hO

/-- 本文「この多項式は元の選択に依らない」: `O ∈ 𝔐`、`m ∈ 𝒦` で `O = O(m)` なら `Δ_O = Δ(x; m)`。 -/
theorem orbitDispersion_eq {L : ℕ} [NeZero L] {s : SpinStructure} (m : FourierModePair L s) :
    orbitDispersion (modeInversionOrbit m.1.1 m.1.2) = dispersionPolynomial m.1.1 m.1.2 := by
  have hne : (modeInversionOrbit m.1.1 m.1.2).Nonempty :=
    ⟨_, mem_modeInversionOrbit_self m.1.1 m.1.2⟩
  have hrep : orbitRepresentative (modeInversionOrbit m.1.1 m.1.2) ∈
      modeInversionOrbit m.1.1 m.1.2 := by
    rw [orbitRepresentative, dif_pos hne]
    exact hne.choose_spec
  exact dispersion_eq_of_mem_modeInversionOrbit m hrep

/-- 一元軌道の平方: `O ∈ 𝔐`、`|O| = 1` なら `F_O^2 = Δ_O`
（`claim_mode_inversion_orbit_cardinality` で元は `{1, −1}^2` に属し、
`claim_dispersion_special_mode_squares` の具体版の四つの場合）。 -/
theorem oneElementOrbitFactor_sq {L : ℕ} [NeZero L] {s : SpinStructure}
    {O : Finset (Qbar × Qbar)} (hO : O ∈ modeInversionOrbits L s) (hcard : O.card = 1) :
    oneElementOrbitFactor O ^ 2 = orbitDispersion O := by
  have hL : 1 ≤ L := Nat.one_le_iff_ne_zero.mpr (NeZero.ne L)
  obtain ⟨m, rfl⟩ := mem_modeInversionOrbits hO
  obtain ⟨-, -, hone⟩ := mode_inversion_orbit_cardinality hL s m.2.1 m.2.2
  obtain ⟨hvarpi, hvarsigma⟩ := hone.mp hcard
  -- 一元軌道の代表元は `m` 自身
  have hne : (modeInversionOrbit m.1.1 m.1.2).Nonempty :=
    ⟨_, mem_modeInversionOrbit_self m.1.1 m.1.2⟩
  have hrep : orbitRepresentative (modeInversionOrbit m.1.1 m.1.2) = (m.1.1, m.1.2) := by
    have hmem : orbitRepresentative (modeInversionOrbit m.1.1 m.1.2) ∈
        modeInversionOrbit m.1.1 m.1.2 := by
      rw [orbitRepresentative, dif_pos hne]
      exact hne.choose_spec
    exact Finset.card_le_one.mp hcard.le _ hmem _ (mem_modeInversionOrbit_self m.1.1 m.1.2)
  obtain ⟨h11, h1m, hm1, hmm⟩ := dispersion_special_mode_squares
  unfold oneElementOrbitFactor orbitDispersion
  rw [hrep]
  rcases hvarpi with h1 | h1 <;> rcases hvarsigma with h2 | h2 <;>
    simp only [h1, h2, Prod.mk.injEq] <;> norm_num
  · exact h11.symm
  · exact h1m.symm
  · exact hm1.symm
  · exact hmm.symm

/-- `𝔐` は `𝒦` の分割である: `∏_{m ∈ 𝒦} Δ(x; m) = ∏_{O ∈ 𝔐} ∏_{p ∈ O} Δ(x; p)`。 -/
theorem prod_modes_eq_prod_orbits {L : ℕ} [NeZero L] (s : SpinStructure) :
    (∏ m : FourierModePair L s, dispersionPolynomial m.1.1 m.1.2) =
      ∏ O ∈ modeInversionOrbits L s, ∏ p ∈ O, dispersionPolynomial p.1 p.2 := by
  have hL : 1 ≤ L := Nat.one_le_iff_ne_zero.mpr (NeZero.ne L)
  -- `𝒦` を `Qbar × Qbar` の有限部分集合として書く（`Subtype.val` は単射）
  have himage : (∏ m : FourierModePair L s, dispersionPolynomial m.1.1 m.1.2) =
      ∏ p ∈ Finset.univ.image (fun m : FourierModePair L s => m.1),
        dispersionPolynomial p.1 p.2 := by
    exact (Finset.prod_image (f := fun p : Qbar × Qbar => dispersionPolynomial p.1 p.2)
      (s := Finset.univ) (g := fun m : FourierModePair L s => m.1)
      (fun a _ b _ h => Subtype.ext h)).symm
  -- 軌道の和集合は `𝒦` である
  have hunion : (modeInversionOrbits L s).biUnion id =
      Finset.univ.image (fun m : FourierModePair L s => m.1) := by
    ext p
    simp only [Finset.mem_biUnion, id, Finset.mem_image, Finset.mem_univ, true_and]
    constructor
    · rintro ⟨O, hO, hp⟩
      obtain ⟨m, rfl⟩ := mem_modeInversionOrbits hO
      obtain ⟨hmem, -, -⟩ := mode_inversion_orbit_cardinality hL s m.2.1 m.2.2
      exact ⟨⟨p, hmem p hp⟩, rfl⟩
    · rintro ⟨m, rfl⟩
      exact ⟨modeInversionOrbit m.1.1 m.1.2,
        Finset.mem_image_of_mem _ (Finset.mem_univ m), mem_modeInversionOrbit_self _ _⟩
  -- 異なる二つの軌道は交わらない
  have hdisj : Set.PairwiseDisjoint (↑(modeInversionOrbits L s) : Set (Finset (Qbar × Qbar))) id := by
    intro O hO O' hO' hne
    obtain ⟨m, rfl⟩ := mem_modeInversionOrbits hO
    obtain ⟨m', rfl⟩ := mem_modeInversionOrbits hO'
    rw [Function.onFun, Finset.disjoint_left]
    intro q hq hq'
    obtain ⟨h1, h2⟩ := fourierModePair_ne_zero m
    obtain ⟨h1', h2'⟩ := fourierModePair_ne_zero m'
    exact hne ((modeInversionOrbit_eq_of_mem h1 h2 hq).symm.trans
      (modeInversionOrbit_eq_of_mem h1' h2' hq'))
  rw [himage, ← hunion, Finset.prod_biUnion hdisj]
  rfl

/-- 軌道の元数と `Δ_O` の不変性: `O ∈ 𝔐` なら `∏_{p ∈ O} Δ(x; p) = Δ_O^{|O|}`。 -/
theorem prod_orbit_eq_pow {L : ℕ} [NeZero L] {s : SpinStructure}
    {O : Finset (Qbar × Qbar)} (hO : O ∈ modeInversionOrbits L s) :
    (∏ p ∈ O, dispersionPolynomial p.1 p.2) = orbitDispersion O ^ O.card := by
  obtain ⟨m, rfl⟩ := mem_modeInversionOrbits hO
  rw [orbitDispersion_eq m, ← Finset.prod_const]
  exact Finset.prod_congr rfl (fun p hp => dispersion_eq_of_mem_modeInversionOrbit m hp)

/-- 本文の第三行: 元数が一・二・四の軌道ごとにまとめた積は、軌道ごとの `Δ` の積に等しい。 -/
theorem prod_orbits_by_card {L : ℕ} [NeZero L] (s : SpinStructure) :
    (∏ O ∈ (modeInversionOrbits L s).filter (fun O => O.card = 1), orbitDispersion O) *
      (∏ O ∈ (modeInversionOrbits L s).filter (fun O => O.card = 2), orbitDispersion O ^ 2) *
      (∏ O ∈ (modeInversionOrbits L s).filter (fun O => O.card = 4), orbitDispersion O ^ 4) =
    ∏ O ∈ modeInversionOrbits L s, ∏ p ∈ O, dispersionPolynomial p.1 p.2 := by
  have hL : 1 ≤ L := Nat.one_le_iff_ne_zero.mpr (NeZero.ne L)
  set M := modeInversionOrbits L s
  -- `|O| ∈ {1, 2, 4}`（`claim_mode_inversion_orbit_cardinality`）
  have hcard : ∀ O ∈ M, O.card = 1 ∨ O.card = 2 ∨ O.card = 4 := by
    intro O hO
    obtain ⟨m, rfl⟩ := mem_modeInversionOrbits hO
    exact (mode_inversion_orbit_cardinality hL s m.2.1 m.2.2).2.1
  have hpow : (∏ O ∈ M, ∏ p ∈ O, dispersionPolynomial p.1 p.2) =
      ∏ O ∈ M, orbitDispersion O ^ O.card :=
    Finset.prod_congr rfl (fun O hO => prod_orbit_eq_pow hO)
  rw [hpow, ← Finset.prod_filter_mul_prod_filter_not M (fun O => O.card = 1),
    ← Finset.prod_filter_mul_prod_filter_not (M.filter (fun O => ¬ O.card = 1))
      (fun O => O.card = 2),
    Finset.filter_filter, Finset.filter_filter]
  have e1 : (∏ O ∈ M.filter (fun O => O.card = 1), orbitDispersion O ^ O.card) =
      ∏ O ∈ M.filter (fun O => O.card = 1), orbitDispersion O :=
    Finset.prod_congr rfl (fun O hO => by rw [(Finset.mem_filter.mp hO).2, pow_one])
  have f2 : M.filter (fun O => ¬ O.card = 1 ∧ O.card = 2) = M.filter (fun O => O.card = 2) :=
    Finset.filter_congr (fun O _ => by omega)
  have f4 : M.filter (fun O => ¬ O.card = 1 ∧ ¬ O.card = 2) = M.filter (fun O => O.card = 4) :=
    Finset.filter_congr (fun O hO => by have := hcard O hO; omega)
  have e2 : (∏ O ∈ M.filter (fun O => O.card = 2), orbitDispersion O ^ O.card) =
      ∏ O ∈ M.filter (fun O => O.card = 2), orbitDispersion O ^ 2 :=
    Finset.prod_congr rfl (fun O hO => by rw [(Finset.mem_filter.mp hO).2])
  have e4 : (∏ O ∈ M.filter (fun O => O.card = 4), orbitDispersion O ^ O.card) =
      ∏ O ∈ M.filter (fun O => O.card = 4), orbitDispersion O ^ 4 :=
    Finset.prod_congr rfl (fun O hO => by rw [(Finset.mem_filter.mp hO).2])
  rw [f2, f4, e1, e2, e4, mul_assoc]

/-- 本文の平方の五行: `(P^{a,b}_L)^2 = D^{a,b}_L(x)`。 -/
theorem orbitExplicitProduct_sq {L : ℕ} [NeZero L] (z : Qbar) (hz4 : z ^ 4 = -1)
    (s : SpinStructure) :
    orbitExplicitProduct L s ^ 2 = kacWardDeterminant (kacWardTransitionMatrix L z s) := by
  set M := modeInversionOrbits L s
  have hA : (∏ O ∈ M.filter (fun O => O.card = 1), oneElementOrbitFactor O) ^ 2 =
      ∏ O ∈ M.filter (fun O => O.card = 1), oneElementOrbitFactor O ^ 2 :=
    (Finset.prod_pow _ _ _).symm
  have hB : (∏ O ∈ M.filter (fun O => O.card = 2), orbitDispersion O) ^ 2 =
      ∏ O ∈ M.filter (fun O => O.card = 2), orbitDispersion O ^ 2 :=
    (Finset.prod_pow _ _ _).symm
  have hC : (∏ O ∈ M.filter (fun O => O.card = 4), orbitDispersion O ^ 2) ^ 2 =
      ∏ O ∈ M.filter (fun O => O.card = 4), orbitDispersion O ^ 4 := by
    rw [← Finset.prod_pow]
    exact Finset.prod_congr rfl (fun O _ => by rw [← pow_mul])
  have hF : (∏ O ∈ M.filter (fun O => O.card = 1), oneElementOrbitFactor O ^ 2) =
      ∏ O ∈ M.filter (fun O => O.card = 1), orbitDispersion O :=
    Finset.prod_congr rfl (fun O hO =>
      oneElementOrbitFactor_sq (Finset.mem_filter.mp hO).1 (Finset.mem_filter.mp hO).2)
  calc orbitExplicitProduct L s ^ 2
      = (∏ O ∈ M.filter (fun O => O.card = 1), oneElementOrbitFactor O ^ 2) *
          (∏ O ∈ M.filter (fun O => O.card = 2), orbitDispersion O ^ 2) *
          (∏ O ∈ M.filter (fun O => O.card = 4), orbitDispersion O ^ 4) := by
        -- 一行目: `Qbar[x]` の可換性と冪の法則
        rw [orbitExplicitProduct, mul_pow, mul_pow, hA, hB, hC]
    _ = (∏ O ∈ M.filter (fun O => O.card = 1), orbitDispersion O) *
          (∏ O ∈ M.filter (fun O => O.card = 2), orbitDispersion O ^ 2) *
          (∏ O ∈ M.filter (fun O => O.card = 4), orbitDispersion O ^ 4) := by
        -- 二行目: `claim_dispersion_special_mode_squares`
        rw [hF]
    _ = ∏ O ∈ M, ∏ p ∈ O, dispersionPolynomial p.1 p.2 :=
        -- 三行目: `claim_mode_inversion_orbit_cardinality` と `claim_dispersion_inversion_invariant`
        prod_orbits_by_card s
    _ = ∏ m : FourierModePair L s, dispersionPolynomial m.1.1 m.1.2 :=
        -- 四行目: `𝔐` は `𝒦` の分割
        (prod_modes_eq_prod_orbits s).symm
    _ = kacWardDeterminant (kacWardTransitionMatrix L z s) :=
        -- 五行目: `claim_dispersion_mode_product`
        (dispersion_mode_product z hz4 s).symm

end Ising2DLambda.KacWard
