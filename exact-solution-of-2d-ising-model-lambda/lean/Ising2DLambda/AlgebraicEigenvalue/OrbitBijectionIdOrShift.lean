/-
章「固有値の代数性」の「巡回シフトは軌道を保つ置換である」と
「各行配位をそれ自身かその像へ送る軌道の上の全単射は、恒等写像か巡回シフトの制限である」の
具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは主張 2 件
（`claim_shift_orbit_preserving` / `claim_orbit_bijection_id_or_shift`）に対応する。

  人手証明                                        このファイル
  S ∈ 𝔖^𝒪_L                                      rowShift_orbitPreserving
  S↾_O ∈ 𝔅_O                                     shiftOrbitRestriction
  F = { τ ∈ O | ψ(τ) = τ }                        Fixed
  F が 1 つ前の行配位について閉じること             証明中の hclosed
  j ≤ e で S^[e-j](τ₀) ∈ F（j についての帰納法）   証明中の hind
  k = e q + r へ直して F = O を出す                証明中の hFO
  結論（ψ = id_O または ψ = S↾_O）                 orbitBij_eq_id_or_shift

`ψ` は `O` の上の全単射（部分型の上の `Equiv`）だが、人手証明が `ψ(τ)` と `S(τ)` を
同じ場所で比べているので、比較は `ambientOf O ψ`（軌道の外では恒等な ambient の写像）を
通して行う。`ambientOf` は前のセクション（`OrbitFamilySum.lean`）で置いたものである。

mathlib の巡回群・軌道の一般論（`Equiv.Perm.cycleOf` など）は引いていない
（引くと「動かさない行配位の全体が 1 つ前について閉じている」という人手証明の議論が消える）。

住処: 人手証明のこれらのブロックは ℕ を宣言している。
ここに ℝ / ℂ は現れない（現れるのは行配位とその部分集合、その上の写像、および自然数だけ）。
-/
import Ising2DLambda.AlgebraicEigenvalue.ShiftCharOrbitProduct

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 人手証明の主張「巡回シフトは軌道を保つ置換である」。

証明は人手証明どおり `S(τ) = S(S^[0](τ)) = S^[1](τ)` の 2 段で `S(τ) ∈ O(τ)` を出す。 -/
theorem rowShift_orbitPreserving : OrbitPreserving L (rowShiftEquiv L) := by
  intro τ
  refine mem_rowShiftOrbit.mpr ⟨1, ?_⟩
  -- S(τ) = S(S^[0](τ)) = S^[1](τ)
  rfl

/-- 人手証明の `S↾_O`（巡回シフトの軌道への制限。`𝔅_O` の元）。

`claim_orbit_restriction_bijective`（`orbitRestriction_bijective`）で全単射性が出るので、
前のセクションの `restrictionFamily` をそのまま当てればよい。 -/
noncomputable def shiftOrbitRestriction (O : OrbitIndex L) :
    {τ : RowConfig L // τ ∈ O.1} ≃ {τ : RowConfig L // τ ∈ O.1} :=
  restrictionFamily rowShift_orbitPreserving O

@[simp]
theorem shiftOrbitRestriction_val (O : OrbitIndex L) (τ : {τ : RowConfig L // τ ∈ O.1}) :
    (shiftOrbitRestriction O τ).1 = rowShift L τ.1 := rfl

/-- 人手証明が証明の中だけで使う `F = { τ ∈ O | ψ(τ) = τ }`（`ψ` が動かさない行配位の全体）。

Finset ではなく述語として置く（帰納法で現れる行配位ごとに所属の証明を持ち回さないため）。
**これで人手証明との 1 対 1 対応は保たれている。** 述語 `Fixed O ψ` は集合 `F` の所属条件
`t ∈ O ∧ ψ(t) = t` をそのまま書いたものであり、人手証明は `F` を集合として使っていない
（元の個数を数えず、像も取らず、`F = ∅` か否かと `F = O` を所属だけで論じている）。
したがって Finset として持ち直す必要はない。 -/
def Fixed (O : Finset (RowConfig L))
    (ψ : {τ : RowConfig L // τ ∈ O} ≃ {τ : RowConfig L // τ ∈ O}) (t : RowConfig L) : Prop :=
  t ∈ O ∧ ambientOf O ψ t = t

/-- 人手証明の主張「各行配位をそれ自身かその像へ送る軌道の上の全単射は、
恒等写像か巡回シフトの制限である」。

証明は人手証明どおり `F = ∅` か否かで場合分けする。 -/
theorem orbitBij_eq_id_or_shift {O : Finset (RowConfig L)} (hO : O ∈ rowShiftOrbitSet L)
    (ψ : {τ : RowConfig L // τ ∈ O} ≃ {τ : RowConfig L // τ ∈ O})
    (h : ∀ τ : {τ : RowConfig L // τ ∈ O}, (ψ τ).1 = τ.1 ∨ (ψ τ).1 = rowShift L τ.1) :
    ψ = Equiv.refl {τ : RowConfig L // τ ∈ O} ∨ ψ = shiftOrbitRestriction ⟨O, hO⟩ := by
  classical
  -- 仮定を ambient の写像 `ambientOf O ψ` の言葉へ書き直す
  have hg : ∀ t : RowConfig L, ∀ ht : t ∈ O,
      ambientOf O ψ t = t ∨ ambientOf O ψ t = rowShift L t := by
    intro t ht
    have hval := h ⟨t, ht⟩
    rw [ambientOf_apply O ψ ht]
    exact hval
  -- `ambientOf O ψ` は O の上で単射である（ψ が単射であることによる）
  have hginj : ∀ t₁ : RowConfig L, ∀ ht₁ : t₁ ∈ O, ∀ t₂ : RowConfig L, ∀ ht₂ : t₂ ∈ O,
      ambientOf O ψ t₁ = ambientOf O ψ t₂ → t₁ = t₂ := by
    intro t₁ ht₁ t₂ ht₂ heq
    rw [ambientOf_apply O ψ ht₁, ambientOf_apply O ψ ht₂] at heq
    have : ψ ⟨t₁, ht₁⟩ = ψ ⟨t₂, ht₂⟩ := Subtype.ext heq
    exact congrArg Subtype.val (ψ.injective this)
  by_cases hempty : ∀ t : RowConfig L, ¬ Fixed O ψ t
  · -- F = ∅ の場合。仮定の第 1 の場合が起こらないので ψ = S↾_O
    right
    refine Equiv.ext fun τ => Subtype.ext ?_
    rw [shiftOrbitRestriction_val]
    rcases h τ with h1 | h2
    · refine absurd (show Fixed O ψ τ.1 from ⟨τ.2, ?_⟩) (hempty τ.1)
      rw [ambientOf_apply O ψ τ.2]
      exact h1
    · exact h2
  · -- F ≠ ∅ の場合。F = O を示して ψ = id_O を出す
    left
    push_neg at hempty
    obtain ⟨t₀, ht₀⟩ := hempty
    set e := rowShiftMinimalPeriod L t₀ with hedef
    have hepos : 1 ≤ e := rowShiftMinimalPeriod_pos t₀
    -- O(t₀) = O（t₀ ∈ O と、軌道の元の軌道がもとの軌道に等しいこと）
    have hOorb : rowShiftOrbit L t₀ = O := by
      obtain ⟨t₁, ht₁⟩ := mem_rowShiftOrbitSet.mp hO
      have hmem : t₀ ∈ rowShiftOrbit L t₁ := by rw [ht₁]; exact ht₀.1
      rw [rowShiftOrbit_eq_of_mem t₁ hmem, ht₁]
    -- F は 1 つ前の行配位について閉じている
    have hclosed : ∀ t : RowConfig L, Fixed O ψ t → ∀ t' : RowConfig L, t' ∈ O →
        rowShift L t' = t → Fixed O ψ t' := by
      intro t ht t' ht'O hstep
      refine ⟨ht'O, ?_⟩
      rcases hg t' ht'O with h1 | h2
      · exact h1
      · -- ψ(t') = S(t') = t = ψ(t) なので単射性から t' = t、したがって ψ(t') = t'
        have hgt : ambientOf O ψ t' = ambientOf O ψ t := by rw [h2, hstep, ht.2]
        have ht't : t' = t := hginj t' ht'O t ht.1 hgt
        rw [h2, hstep, ← ht't]
    -- j ≤ e のとき S^[e-j](t₀) ∈ F（j についての帰納法）
    have hind : ∀ j : ℕ, j ≤ e → Fixed O ψ (rowShiftIterate L (e - j) t₀) := by
      intro j
      induction j with
      | zero =>
        intro _
        -- e - 0 = e、S^[e](t₀) = t₀
        have : rowShiftIterate L (e - 0) t₀ = t₀ := by
          rw [Nat.sub_zero, hedef, rowShiftIterate_minimalPeriod t₀]
        rw [this]
        exact ht₀
      | succ j ih =>
        intro hj1
        have hj : j ≤ e := by omega
        -- τ' = S^[e-j-1](t₀) は O の元である（O(t₀) = O による）
        have ht'O : rowShiftIterate L (e - j - 1) t₀ ∈ O := by
          rw [← hOorb]
          exact mem_rowShiftOrbit.mpr ⟨e - j - 1, rfl⟩
        -- S(τ') = S^[(e-j-1)+1](t₀) = S^[e-j](t₀) = τ
        have hsucc : e - j - 1 + 1 = e - j := by omega
        have hstep : rowShift L (rowShiftIterate L (e - j - 1) t₀)
            = rowShiftIterate L (e - j) t₀ := by
          calc rowShift L (rowShiftIterate L (e - j - 1) t₀)
              = rowShiftIterate L (e - j - 1 + 1) t₀ := rfl
            _ = rowShiftIterate L (e - j) t₀ := by rw [hsucc]
        have hj1eq : e - (j + 1) = e - j - 1 := by omega
        rw [hj1eq]
        exact hclosed _ (ih hj) _ ht'O hstep
    -- F = O（任意の t ∈ O を t = S^[r](t₀)（r < e）の形へ直す）
    have hFO : ∀ t : RowConfig L, t ∈ O → Fixed O ψ t := by
      intro t ht
      have hmem : t ∈ rowShiftOrbit L t₀ := by rw [hOorb]; exact ht
      obtain ⟨k, hk⟩ := mem_rowShiftOrbit.mp hmem
      have hdm : e * (k / e) + k % e = k := Nat.div_add_mod k e
      have hrlt : k % e < e := Nat.mod_lt _ (by omega)
      have hcomm : k = k % e + e * (k / e) := by omega
      have hperiod : rowShiftIterate L e t₀ = t₀ := by
        rw [hedef]; exact rowShiftIterate_minimalPeriod t₀
      have hstep : rowShiftIterate L k t₀ = rowShiftIterate L (k % e) t₀ := by
        calc rowShiftIterate L k t₀
            = rowShiftIterate L (k % e + e * (k / e)) t₀ := by rw [← hcomm]
          _ = rowShiftIterate L (k % e) (rowShiftIterate L (e * (k / e)) t₀) :=
              rowShiftIterate_add _ _ _
          _ = rowShiftIterate L (k % e) t₀ := by
              rw [rowShiftIterate_mul t₀ hperiod (k / e)]
      have hback : e - (e - k % e) = k % e := by omega
      have hteq : t = rowShiftIterate L (e - (e - k % e)) t₀ := by
        rw [hback, hk, hstep]
      rw [hteq]
      exact hind (e - k % e) (by omega)
    -- したがって任意の τ ∈ O について ψ(τ) = τ
    refine Equiv.ext fun τ => Subtype.ext ?_
    have hfix := (hFO τ.1 τ.2).2
    rw [ambientOf_apply O ψ τ.2] at hfix
    exact hfix

end Ising2DLambda.AlgebraicEigenvalue
