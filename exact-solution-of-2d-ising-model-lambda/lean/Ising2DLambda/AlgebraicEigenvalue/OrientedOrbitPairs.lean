/-
章「固有値の代数性」の「またぐ転倒対の全体の個数の偶数性」の具体版
（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは定義 1 件
（`def_oriented_orbit_pairs`）と主張 3 件
（`claim_oriented_orbit_pairs_cross_disjoint` / `claim_cross_orbit_inversion_pairs_union` /
`claim_cross_orbit_inversion_pairs_even`）に対応する。

  人手証明                                        このファイル
  D_L                                             orientedOrbitPairs
  D_L の元の 2 成分は相異なる                      ne_of_mem_orientedOrbitPairs
  (O,O') と (O',O) は同時には D_L に属さない       swap_not_mem_orientedOrbitPairs
  相異なる軌道の順序対の一方は D_L に属する        mem_orientedOrbitPairs_or_swap
  J_φ(O_1,O_1') ∩ J_φ(O_2,O_2') = ∅               crossInversions_disjoint
  Inv^≠(φ) = ∪_{(O,O') ∈ D_L} J_φ(O,O')           crossOrbitInversionPairs_eq_biUnion
  |Inv^≠(φ)| = 2 Σ |F \ F_φ|                      card_crossOrbitInversionPairs_eq_two_mul

`μ` の持ち方について 1 つ断っておく。人手証明の `μ(X)` は空でない `X` にだけ定まるので、
具体版でも `rowConfigMin` は `X.Nonempty` の証明を引数に取る。`D_L` は `q` だけを見る
`filter` で作るため、条件の中で「2 成分が空でないこと」を存在量化の形で書いてある。
`Finset.Nonempty` は Prop なので、どの証明を渡しても `rowConfigMin` は同じ元を指す
（Lean の証明の定義的無関係性による。だから `mem_orientedOrbitPairs_iff` が `rfl` 級で通る）。
**空のときに値を返す全域版（junk 値）を作っていない。** 作ると人手証明の
「`X` が空のときは `μ(X)` は定まらない」と食い違うからである。

mathlib の群作用の軌道の一般論・`Equiv.Perm.sign` は引いていない。使ったのは
`Finset.card_biUnion`（人手証明の「互いに素な族の合併の個数は個数の和」）と
有限和の基本補題だけである。

住処: 人手証明のこれらのブロックは ℕ を宣言している。
ここに ℝ / ℂ は現れない（元は行配位、個数は ℕ）。
-/
import Ising2DLambda.AlgebraicEigenvalue.RowConfigMin
import Ising2DLambda.AlgebraicEigenvalue.InversionOrbitDecomposition

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 軌道は空でない（`claim_row_config_orbit_partition` の第 1 の条件）。 -/
theorem nonempty_of_mem_rowShiftOrbitSet {O : Finset (RowConfig L)}
    (hO : O ∈ rowShiftOrbitSet L) : O.Nonempty := by
  obtain ⟨τ, rfl⟩ := mem_rowShiftOrbitSet.mp hO
  exact rowShiftOrbit_nonempty τ

/-- 人手証明の定義「最小元で向きを付けた軌道の順序対の全体」
`D_L = { (O,O') ∈ 𝒪_L × 𝒪_L | μ(O) ≺ μ(O') }`。

`μ` は空でない集合にだけ定まるので、条件の中で 2 成分が空でないことを存在量化で書く
（軌道はどれも空でないので、これは条件を弱めていない）。 -/
noncomputable def orientedOrbitPairs (L : ℕ) [NeZero L] :
    Finset (Finset (RowConfig L) × Finset (RowConfig L)) :=
  open Classical in
  ((rowShiftOrbitSet L) ×ˢ (rowShiftOrbitSet L)).filter fun q =>
    ∃ (h₁ : q.1.Nonempty) (h₂ : q.2.Nonempty),
      rowConfigLess L (rowConfigMin L h₁) (rowConfigMin L h₂)

lemma mem_orientedOrbitPairs {q : Finset (RowConfig L) × Finset (RowConfig L)} :
    q ∈ orientedOrbitPairs L
      ↔ (q.1 ∈ rowShiftOrbitSet L ∧ q.2 ∈ rowShiftOrbitSet L)
        ∧ ∃ (h₁ : q.1.Nonempty) (h₂ : q.2.Nonempty),
            rowConfigLess L (rowConfigMin L h₁) (rowConfigMin L h₂) := by
  classical
  simp [orientedOrbitPairs, Finset.mem_filter, Finset.mem_product]

/-- 軌道の対については、`D_L` への帰属は最小元の比較そのものである
（空でないことの証明はどれを渡しても同じ元を指す）。 -/
lemma mem_orientedOrbitPairs_iff {O O' : Finset (RowConfig L)}
    (hO : O ∈ rowShiftOrbitSet L) (hO' : O' ∈ rowShiftOrbitSet L) :
    (O, O') ∈ orientedOrbitPairs L
      ↔ rowConfigLess L (rowConfigMin L (nonempty_of_mem_rowShiftOrbitSet hO))
          (rowConfigMin L (nonempty_of_mem_rowShiftOrbitSet hO')) := by
  classical
  rw [mem_orientedOrbitPairs]
  constructor
  · rintro ⟨-, h₁, h₂, h⟩
    exact h
  · intro h
    exact ⟨⟨hO, hO'⟩, _, _, h⟩

/-- 人手証明の「`(O,O')` と `(O',O)` は同時には `D_L` に属さない」（非対称性）。 -/
theorem swap_not_mem_orientedOrbitPairs {q : Finset (RowConfig L) × Finset (RowConfig L)}
    (hq : q ∈ orientedOrbitPairs L) : (q.2, q.1) ∉ orientedOrbitPairs L := by
  classical
  obtain ⟨-, h₁, h₂, h⟩ := mem_orientedOrbitPairs.mp hq
  intro hcon
  obtain ⟨-, h₁', h₂', h'⟩ := mem_orientedOrbitPairs.mp hcon
  exact not_rowConfigLess_of_rowConfigLess h h'

/-- 人手証明が定義の中で示している「`D_L` の元の 2 成分は相異なる」。

`μ(O) ≺ μ(O)` は三分律（`claim_row_config_order_linear`）が禁じている。
ここでは非対称性の形（`swap_not_mem_orientedOrbitPairs`）に当てて出す。 -/
theorem ne_of_mem_orientedOrbitPairs {q : Finset (RowConfig L) × Finset (RowConfig L)}
    (hq : q ∈ orientedOrbitPairs L) : q.1 ≠ q.2 := by
  intro hcon
  -- q.1 = q.2 なら (q.2, q.1) は q そのものなので、非対称性に反する。
  have hswap : (q.2, q.1) = q := Prod.ext hcon.symm hcon
  exact swap_not_mem_orientedOrbitPairs hq (hswap ▸ hq)

/-- 人手証明の「相異なる 2 つの軌道の順序対は、一方が `D_L` に属する」。

`claim_orbit_min_ne`（相異なる軌道の最小元は相異なる）と三分律による。 -/
theorem mem_orientedOrbitPairs_or_swap {O O' : Finset (RowConfig L)}
    (hO : O ∈ rowShiftOrbitSet L) (hO' : O' ∈ rowShiftOrbitSet L) (hne : O ≠ O') :
    (O, O') ∈ orientedOrbitPairs L ∨ (O', O) ∈ orientedOrbitPairs L := by
  classical
  have hminne : rowConfigMin L (nonempty_of_mem_rowShiftOrbitSet hO)
      ≠ rowConfigMin L (nonempty_of_mem_rowShiftOrbitSet hO') :=
    rowConfigMin_orbit_ne hO hO' hne _ _
  rcases rowConfigLess_or_rowConfigLess hminne with h | h
  · exact Or.inl ((mem_orientedOrbitPairs_iff hO hO').mpr h)
  · exact Or.inr ((mem_orientedOrbitPairs_iff hO' hO).mpr h)

/-- `𝒪_L` の元に属する点の軌道はその元である（`claim_row_config_orbit_mem_eq`）。 -/
theorem rowShiftOrbit_eq_of_mem_orbitSet {O : Finset (RowConfig L)}
    (hO : O ∈ rowShiftOrbitSet L) {τ : RowConfig L} (hτ : τ ∈ O) : rowShiftOrbit L τ = O := by
  obtain ⟨τ₀, rfl⟩ := mem_rowShiftOrbitSet.mp hO
  exact rowShiftOrbit_eq_of_mem τ₀ hτ

variable {φ : Equiv.Perm (RowConfig L)}

/-- `J_φ(O,O')` の元から、2 成分の軌道を読み取る（人手証明の第 1 段）。 -/
theorem orbit_pair_of_mem_crossInversions {q : Finset (RowConfig L) × Finset (RowConfig L)}
    (hq1 : q.1 ∈ rowShiftOrbitSet L) (hq2 : q.2 ∈ rowShiftOrbitSet L)
    {p : RowConfig L × RowConfig L} (hp : p ∈ crossInversions L φ q.1 q.2) :
    (rowShiftOrbit L p.1, rowShiftOrbit L p.2) = q
      ∨ (rowShiftOrbit L p.1, rowShiftOrbit L p.2) = (q.2, q.1) := by
  rcases (mem_crossInversions.mp hp).2.1 with ⟨h1, h2⟩ | ⟨h1, h2⟩
  · exact Or.inl (Prod.ext (rowShiftOrbit_eq_of_mem_orbitSet hq1 h1)
      (rowShiftOrbit_eq_of_mem_orbitSet hq2 h2))
  · exact Or.inr (Prod.ext (rowShiftOrbit_eq_of_mem_orbitSet hq2 h1)
      (rowShiftOrbit_eq_of_mem_orbitSet hq1 h2))

/-- 人手証明の主張「向きを付けた相異なる軌道の対が与えるまたがる転倒対は交わらない」。 -/
theorem crossInversions_disjoint {q₁ q₂ : Finset (RowConfig L) × Finset (RowConfig L)}
    (h₁ : q₁ ∈ orientedOrbitPairs L) (h₂ : q₂ ∈ orientedOrbitPairs L) (hne : q₁ ≠ q₂) :
    Disjoint (crossInversions L φ q₁.1 q₁.2) (crossInversions L φ q₂.1 q₂.2) := by
  classical
  obtain ⟨⟨hq₁1, hq₁2⟩, -⟩ := mem_orientedOrbitPairs.mp h₁
  obtain ⟨⟨hq₂1, hq₂2⟩, -⟩ := mem_orientedOrbitPairs.mp h₂
  refine Finset.disjoint_left.mpr ?_
  intro p hp₁ hp₂
  -- 人手証明の 2 つの場合を、両方の対について取る。
  rcases orbit_pair_of_mem_crossInversions hq₁1 hq₁2 hp₁ with e₁ | e₁ <;>
    rcases orbit_pair_of_mem_crossInversions hq₂1 hq₂2 hp₂ with e₂ | e₂
  · exact hne (e₁ ▸ e₂ ▸ rfl)
  · -- q₁ = (q₂.2, q₂.1)。これは q₂ ∈ D_L と両立しない。
    exact swap_not_mem_orientedOrbitPairs h₂ (by rw [← e₂, e₁]; exact h₁)
  · exact swap_not_mem_orientedOrbitPairs h₁ (by rw [← e₁, e₂]; exact h₂)
  · exact hne (by
      have h : (q₁.2, q₁.1) = (q₂.2, q₂.1) := by rw [← e₁, e₂]
      exact Prod.ext (congrArg Prod.snd h) (congrArg Prod.fst h))

/-- 人手証明の主張「またぐ転倒対の全体は、向きを付けた軌道の対にわたる合併である」。

人手証明どおり両包含で示す（個数ではなく集合の等号）。 -/
theorem crossOrbitInversionPairs_eq_biUnion (L : ℕ) [NeZero L] (φ : Equiv.Perm (RowConfig L)) :
    crossOrbitInversionPairs L φ
      = (orientedOrbitPairs L).biUnion fun q => crossInversions L φ q.1 q.2 := by
  classical
  ext p
  simp only [crossOrbitInversionPairs, Finset.mem_filter, mem_inversionPairs,
    Finset.mem_biUnion]
  constructor
  · -- 左辺 ⊂ 右辺。O := O(p.1)、O' := O(p.2) を取り、最小元の比較で向きを決める。
    rintro ⟨⟨hlt, hinv⟩, hneorb⟩
    have hO : rowShiftOrbit L p.1 ∈ rowShiftOrbitSet L := mem_rowShiftOrbitSet.mpr ⟨p.1, rfl⟩
    have hO' : rowShiftOrbit L p.2 ∈ rowShiftOrbitSet L := mem_rowShiftOrbitSet.mpr ⟨p.2, rfl⟩
    rcases mem_orientedOrbitPairs_or_swap hO hO' hneorb with hD | hD
    · exact ⟨(rowShiftOrbit L p.1, rowShiftOrbit L p.2), hD,
        mem_crossInversions.mpr ⟨hlt,
          Or.inl ⟨self_mem_rowShiftOrbit p.1, self_mem_rowShiftOrbit p.2⟩, hinv⟩⟩
    · exact ⟨(rowShiftOrbit L p.2, rowShiftOrbit L p.1), hD,
        mem_crossInversions.mpr ⟨hlt,
          Or.inr ⟨self_mem_rowShiftOrbit p.1, self_mem_rowShiftOrbit p.2⟩, hinv⟩⟩
  · -- 右辺 ⊂ 左辺。2 成分の軌道は q の 2 成分であり、それらは相異なる。
    rintro ⟨q, hq, hp⟩
    obtain ⟨⟨hq1, hq2⟩, -⟩ := mem_orientedOrbitPairs.mp hq
    obtain ⟨hlt, -, hinv⟩ := mem_crossInversions.mp hp
    refine ⟨⟨hlt, hinv⟩, ?_⟩
    have hqne : q.1 ≠ q.2 := ne_of_mem_orientedOrbitPairs hq
    rcases orbit_pair_of_mem_crossInversions hq1 hq2 hp with e | e
    · intro hcon
      exact hqne (by
        have h1 : rowShiftOrbit L p.1 = q.1 := congrArg Prod.fst e
        have h2 : rowShiftOrbit L p.2 = q.2 := congrArg Prod.snd e
        rw [← h1, ← h2, hcon])
    · intro hcon
      exact hqne (by
        have h1 : rowShiftOrbit L p.1 = q.2 := congrArg Prod.fst e
        have h2 : rowShiftOrbit L p.2 = q.1 := congrArg Prod.snd e
        rw [← h1, ← h2, hcon])

/-- 人手証明の主張「またぐ転倒対の全体の個数は偶数である」。

人手証明の 4 段（合併・互いに素・対ごとの偶数性・有限和の分配則）をそのまま辿る。 -/
theorem card_crossOrbitInversionPairs_eq_two_mul (hφ : OrbitPreserving L φ) :
    (crossOrbitInversionPairs L φ).card
      = 2 * ∑ q ∈ orientedOrbitPairs L,
          (crossOrderedPairs L q.1 q.2 \ crossOrderedPairsImage L φ q.1 q.2).card := by
  classical
  rw [crossOrbitInversionPairs_eq_biUnion L φ,
    Finset.card_biUnion (fun q₁ h₁ q₂ h₂ hne => crossInversions_disjoint h₁ h₂ hne)]
  -- 有限和の分配則（2 * x = x + x として和を 2 本に割る）。
  rw [two_mul, ← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl ?_
  intro q hq
  obtain ⟨⟨hq1, hq2⟩, -⟩ := mem_orientedOrbitPairs.mp hq
  rw [← two_mul]
  exact card_crossInversions_eq_two_mul hφ hq1 hq2 (ne_of_mem_orientedOrbitPairs hq)

end Ising2DLambda.AlgebraicEigenvalue
