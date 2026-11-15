/-
「有理点での四つの符号付き偶部分グラフ多項式の符号」（`claim_signed_even_subgraph_rational_sign`）の
モード `(1,1)` の所属の段の必要十分版。

具体版 `Ising2DLambda.KacWard.oneOne_mem_twistedModes_iff`・`modeInversionOrbit_one_one`・
`eq_one_one_of_one_one_mem_modeInversionOrbit`・`singleton_one_one_mem_modeInversionOrbits_iff`・
`orbitRepresentative_eq_one_one_iff`・`oneElementOrbits_filter_one_one` と同じ手順で示す。

各段が使うのは次だけである。
* 所属の三行（`one_one_mem_modes_iff_necSuf`）: 環 `K`（`−1` と `1^L = 1` のため）と `1 ≠ −1`。
  `1 ≠ −1` を外すと、標数 2 では `(1,1)` が四つ全てのモード集合に属し、同値が崩れる。
  乗法の可換性・逆元・順序は使わない。
* `O(1,1) = {(1,1)}` と `(1,1) ∈ O(ϖ,ς) ⇒ ϖ = ς = 1`: 可除環 `K` の `1⁻¹ = 1` と `(z⁻¹)⁻¹ = z` だけ
  （軌道の定義 `modeInversionOrbit` が可除環を要求するので可除環に置く）。
* `{p} ∈ 𝔐 ⟺ P`（`singleton_mem_orbits_iff_necSuf`）: 軌道の元はモードの点であること `hclosed`、
  `p` がモードの点であることと `P` の同値 `hp`、`p` の軌道が `{p}` であること `hfix`。
  `hclosed` を外すと、`{p}` が `p` を点に持たないモードの軌道として現れうる。
* 代表元の段（`rep_eq_iff_necSuf`・`one_element_filter_rep_necSuf`）: 代表元は軌道に属すること `hrep`、
  `p` を含む軌道は `{p}` であること `hsingle`。`hrep` を外すと、代表元が `p` でも軌道が `{p}` と限らない。
有限集合の元数の判定のため、点の型の等号の判定可能性を使う。

住処: 一般の代数系と有限集合。実数体・複素数体は現れない。
-/
import Ising2DLambda.NecSuf.KacWard.ModeInversionOrbitCardinality

namespace Ising2DLambda.NecSuf.KacWard

/-- 必要十分版（`1 = (−1)^a ⟺ a = 0`）: `1 ≠ −1` だけを使う。 -/
theorem one_eq_sign_iff_necSuf {K : Type*} [Ring K] (hne : (1 : K) ≠ -1) (a : Bool) :
    ((1 : K) = if a then -1 else 1) ↔ a = false := by
  cases a
  · simp
  · simp [hne]

/-- 必要十分版（所属の三行）: `(1^L = (−1)^a かつ 1^L = (−1)^b) ⟺ (a,b) = (0,0)`。 -/
theorem one_one_mem_modes_iff_necSuf {K : Type*} [Ring K] (hne : (1 : K) ≠ -1) (L : ℕ)
    (s : Bool × Bool) :
    ((1 : K) ^ L = (if s.1 then -1 else 1) ∧ (1 : K) ^ L = (if s.2 then -1 else 1)) ↔
      s = (false, false) := by
  calc ((1 : K) ^ L = (if s.1 then -1 else 1) ∧ (1 : K) ^ L = (if s.2 then -1 else 1))
      ↔ ((1 : K) = (if s.1 then -1 else 1) ∧ (1 : K) = (if s.2 then -1 else 1)) := by
        -- `1^L = 1`
        rw [one_pow]
    _ ↔ (s.1 = false ∧ s.2 = false) := by
        -- `(−1)^0 = 1`、`(−1)^1 = −1 ≠ 1`
        rw [one_eq_sign_iff_necSuf hne, one_eq_sign_iff_necSuf hne]
    _ ↔ s = (false, false) := by
        obtain ⟨a, b⟩ := s
        exact Prod.mk_inj.symm

/-- 必要十分版（`O(1,1) = {(1,1)}`）: `1⁻¹ = 1` だけを使う。 -/
theorem modeInversionOrbit_one_one_necSuf {K : Type*} [DivisionRing K] [DecidableEq K] :
    modeInversionOrbit (1 : K) 1 = {((1 : K), (1 : K))} := by
  simp [modeInversionOrbit, inv_one]

/-- 必要十分版（`1 ∈ {z, z⁻¹} ⇒ z = 1`）: `(z⁻¹)⁻¹ = z` と `1⁻¹ = 1` だけを使う。 -/
theorem eq_one_of_one_mem_pair_necSuf {K : Type*} [DivisionRing K] [DecidableEq K] {z : K}
    (h : (1 : K) ∈ ({z, z⁻¹} : Finset K)) : z = 1 := by
  simp only [Finset.mem_insert, Finset.mem_singleton] at h
  rcases h with h | h
  · exact h.symm
  · calc z = (z⁻¹)⁻¹ := (inv_inv z).symm
      _ = (1 : K)⁻¹ := by rw [← h]
      _ = 1 := inv_one

/-- 必要十分版（`(1,1) ∈ O(ϖ,ς) ⇒ ϖ = 1 かつ ς = 1`）。 -/
theorem eq_one_one_of_mem_orbit_necSuf {K : Type*} [DivisionRing K] [DecidableEq K]
    {varpi varsigma : K} (h : ((1 : K), (1 : K)) ∈ modeInversionOrbit varpi varsigma) :
    varpi = 1 ∧ varsigma = 1 := by
  simp only [modeInversionOrbit, Finset.mem_insert, Finset.mem_singleton, Prod.mk.injEq] at h
  have h1 : (1 : K) ∈ ({varpi, varpi⁻¹} : Finset K) := by
    rcases h with ⟨h, -⟩ | ⟨h, -⟩ | ⟨h, -⟩ | ⟨h, -⟩ <;> simp [h]
  have h2 : (1 : K) ∈ ({varsigma, varsigma⁻¹} : Finset K) := by
    rcases h with ⟨-, h⟩ | ⟨-, h⟩ | ⟨-, h⟩ | ⟨-, h⟩ <;> simp [h]
  exact ⟨eq_one_of_one_mem_pair_necSuf h1, eq_one_of_one_mem_pair_necSuf h2⟩

/-- 必要十分版（`{p} ∈ 𝔐 ⟺ P`）: 軌道の集合を `𝔐 := {orb m : m}` とする。 -/
theorem singleton_mem_orbits_iff_necSuf {κ α : Type*} [Fintype κ] [DecidableEq α]
    (val : κ → α) (orb : κ → Finset α) (p : α) (P : Prop)
    (hclosed : ∀ m, ∀ x ∈ orb m, ∃ m', val m' = x)
    (hp : (∃ m, val m = p) ↔ P) (hfix : ∀ m, val m = p → orb m = {p}) :
    ({p} : Finset α) ∈ Finset.univ.image orb ↔ P := by
  rw [← hp]
  constructor
  · intro h
    obtain ⟨m, -, hm⟩ := Finset.mem_image.mp h
    -- `p ∈ orb m` なので `p` はモードの点
    exact hclosed m p (hm ▸ Finset.mem_singleton_self p)
  · rintro ⟨m, hm⟩
    -- `p` のモードの軌道は `{p}`
    exact Finset.mem_image.mpr ⟨m, Finset.mem_univ m, hfix m hm⟩

/-- 必要十分版（代表元が `p` であることと `O = {p}` の同値）。 -/
theorem rep_eq_iff_necSuf {α : Type*} [DecidableEq α] (O : Finset α) (rep : Finset α → α) (p : α)
    (hrep : rep O ∈ O) (hsingle : p ∈ O → O = {p}) :
    rep O = p ↔ O = {p} := by
  constructor
  · intro h
    exact hsingle (h ▸ hrep)
  · intro h
    rw [h] at hrep ⊢
    exact Finset.mem_singleton.mp hrep

/-- 必要十分版（一元軌道のうち代表元が `p` のものの集合は、`P` なら `{{p}}`、そうでなければ空）。 -/
theorem one_element_filter_rep_necSuf {α : Type*} [DecidableEq α] (M : Finset (Finset α))
    (rep : Finset α → α) (p : α) (P : Prop) [Decidable P]
    (hrep : ∀ O ∈ M, rep O ∈ O) (hsingle : ∀ O ∈ M, p ∈ O → O = {p})
    (hmem : ({p} : Finset α) ∈ M ↔ P) :
    (M.filter (fun O => O.card = 1)).filter (fun O => rep O = p) = if P then {{p}} else ∅ := by
  ext O
  simp only [Finset.mem_filter]
  constructor
  · rintro ⟨⟨hO, -⟩, hr⟩
    have hO1 := (rep_eq_iff_necSuf O rep p (hrep O hO) (hsingle O hO)).mp hr
    have hP := hmem.mp (hO1 ▸ hO)
    rw [if_pos hP, hO1]
    exact Finset.mem_singleton_self _
  · intro h
    by_cases hP : P
    · rw [if_pos hP, Finset.mem_singleton] at h
      have hO : O ∈ M := h ▸ hmem.mpr hP
      exact ⟨⟨hO, h ▸ Finset.card_singleton _⟩,
        (rep_eq_iff_necSuf O rep p (hrep O hO) (hsingle O hO)).mpr h⟩
    · rw [if_neg hP] at h
      exact absurd h (Finset.notMem_empty O)

end Ising2DLambda.NecSuf.KacWard
