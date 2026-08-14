/-
章「冗長近傍からの独立性」の具体版。
人手証明の正本は structured-latex/content/redundant-neighbor.ts。

人手証明のブロックとこのファイルの対応:

  制限写像 ρ^T_S（`def_restriction_map`）        `restrict`（(ρ y)(u) := y(u) を u : ↥S でそのまま書く）
  冗長拡大 (T, f∘ρ^T_S)（`def_redundant_extension`） `extendRule`（f と restrict の合成）
  基準値延長写像 ι^T_S（`def_base_value_extension`）  `baseExtend`（u ∈ S か否かの場合分け。既定値は 0）
  ρ^T_S ∘ ι^T_S が恒等（同ブロックの後段）        `restrict_baseExtend`
  claim_no_dependency_on_redundant_element        `no_essentialDep_on_added_element`
  claim_dependency_transfer                        `essentialDep_transfer`
  claim_support_invariance                         `supp_extendRule`

人手証明は部分集合 S ⊆ T を扱う。ここでは T を有限型、S : Finset T とし、A^S を
「部分型 ↥S から A への写像」で表す。A^S と A^T の行き来は人手証明と同じく
restrict（ρ）と baseExtend（ι）の 2 本の写像だけを通し、同一視はしない。
本質的依存台の等号は、人手証明の「両辺とも T の部分集合として比較する」に合わせ、
supp f ⊆ S を包含写像で Finset T へ写した像との等号として述べる。

住処: 有限型のみ。ℝ / ℂ は現れない（人手証明と同じ）。
抽象度は人手証明に固定する。使う mathlib の補題は、人手証明が根拠に挙げる初等的事実
（写像の外延性、部分型の値の等号、有限集合の所属の場合分け）に限る。
-/
import CellularAutomata.EssentialDependency

namespace CellularAutomata.RedundantNeighbor

open CellularAutomata.EssentialDependency

variable {T : Type} [DecidableEq T] (S : Finset T)

/-- 制限写像 ρ^T_S : A^T → A^S（`def_restriction_map`）。(ρ y)(u) := y(u)。 -/
def restrict (y : T → State) : (↥S → State) :=
  fun u => y u.val

/-- 冗長拡大 (T, f∘ρ^T_S)（`def_redundant_extension`）。f へ渡されない添字 T∖S を持つ
    T 上の局所真理値表である。 -/
def extendRule (f : (↥S → State) → State) : (T → State) → State :=
  fun y => f (restrict S y)

/-- 基準値延長写像 ι^T_S : A^S → A^T（`def_base_value_extension`）。
    u ∈ S か否かの場合分けで定め、T∖S 上の値は 0 とする（値の選択に意味はない）。 -/
def baseExtend (x : ↥S → State) : (T → State) :=
  fun u => if h : u ∈ S then x ⟨u, h⟩ else State.zero

/-- ρ^T_S ∘ ι^T_S は A^S の恒等写像（`def_base_value_extension` の後段）。
    各 u ∈ S で (ρ(ι x))(u) = (ι x)(u) = x(u)（場合分けの上段）、写像の外延性による。 -/
theorem restrict_baseExtend (x : ↥S → State) : restrict S (baseExtend S x) = x := by
  funext u
  simp [restrict, baseExtend, u.property]

/-- `claim_no_dependency_on_redundant_element` の具体版。
    w ∈ T∖S のとき、冗長拡大は w に本質的に依存しない。
    人手証明と同じく、一点反転 φ_w が制限で消えること（各 u ∈ S で u ≠ w）を示し、
    `claim_flip_test_equivalence`（`essentialDep_iff_flip`）を (T, f∘ρ) へ適用する。 -/
theorem no_essentialDep_on_added_element (f : (↥S → State) → State)
    (w : T) (hw : w ∉ S) : ¬ EssentialDep (extendRule S f) w := by
  rw [essentialDep_iff_flip]
  rintro ⟨y, hne⟩
  apply hne
  -- ρ^T_S (φ_w y) = ρ^T_S y。各 u ∈ S は w ∉ S より u ≠ w なので、φ_w の場合分けの下段。
  have hrestrict : restrict S (flip w y) = restrict S y := by
    funext u
    exact flip_ne w y u.val (fun h : u.val = w => hw (h ▸ u.property))
  show extendRule S f y = extendRule S f (flip w y)
  unfold extendRule
  rw [hrestrict]

/-- `claim_dependency_transfer` の具体版。
    w ∈ S への本質的依存は、冗長拡大の前後で同値である。
    (⇐) は証人 (x, x') を ι^T_S で A^T へ延長し、(⇒) は証人 (y, y') を ρ^T_S で
    A^S へ制限する。人手証明と同じ順で書く。 -/
theorem essentialDep_transfer (f : (↥S → State) → State)
    (w : T) (hw : w ∈ S) :
    EssentialDep (extendRule S f) w ↔ EssentialDep f ⟨w, hw⟩ := by
  constructor
  · -- (⇒) 存在文を満たす y, y' ∈ A^T を取り、x := ρ y、x' := ρ y' と置く。
    rintro ⟨y, y', agree, hne⟩
    refine ⟨restrict S y, restrict S y', ?_, hne⟩
    -- 各 u ∈ S∖{w} は u ∈ T∖{w} なので、y と y' の一致が制限に移る。
    intro u hu
    have huw : u.val ≠ w := fun h => hu (Subtype.ext h)
    exact agree u.val huw
  · -- (⇐) 存在文を満たす x, x' ∈ A^S を取り、y := ι x、y' := ι x' と置く。
    rintro ⟨x, x', agree, hne⟩
    refine ⟨baseExtend S x, baseExtend S x', ?_, ?_⟩
    · -- 各 u ∈ T∖{w} で y(u) = y'(u)。u ∈ S なら場合分けの上段と x, x' の一致、
      -- u ∉ S なら場合分けの下段（両辺 0）。
      intro u hu
      by_cases hmem : u ∈ S
      · have : (⟨u, hmem⟩ : ↥S) ≠ ⟨w, hw⟩ := fun h => hu (congrArg Subtype.val h)
        simp [baseExtend, hmem, agree ⟨u, hmem⟩ this]
      · simp [baseExtend, hmem]
    · -- (f∘ρ)(ι x) = f(x) と (f∘ρ)(ι x') = f(x')（ρ∘ι が恒等であることによる）。
      show extendRule S f (baseExtend S x) ≠ extendRule S f (baseExtend S x')
      unfold extendRule
      rw [restrict_baseExtend, restrict_baseExtend]
      exact hne

variable [Fintype T]

/-- `claim_support_invariance` の具体版。
    supp(f∘ρ^T_S) = supp(f)（T の部分集合としての等号）。
    人手証明と同じく w ∈ T を場合分けする: w ∈ T∖S なら両辺とも w を含まず
    （`no_essentialDep_on_added_element` と supp f ⊆ S）、w ∈ S なら所属が
    `essentialDep_transfer` で同値になる。右辺は supp f ⊆ S を包含写像で
    T の部分集合へ写した像である。 -/
theorem supp_extendRule (f : (↥S → State) → State) :
    supp (extendRule S f) = (supp f).map (Function.Embedding.subtype (· ∈ S)) := by
  ext w
  rw [mem_supp_iff]
  constructor
  · intro hdep
    -- w ∈ S でなければ `no_essentialDep_on_added_element` に矛盾する。
    by_cases hw : w ∈ S
    · exact Finset.mem_map.mpr
        ⟨⟨w, hw⟩, (mem_supp_iff f ⟨w, hw⟩).mpr
          ((essentialDep_transfer S f w hw).mp hdep), rfl⟩
    · exact absurd hdep (no_essentialDep_on_added_element S f w hw)
  · intro hmem
    -- 右辺の元は ⟨w, hw⟩ ∈ supp f の像なので、依存を冗長拡大側へ移す。
    obtain ⟨u, hu, huw⟩ := Finset.mem_map.mp hmem
    have hw : w ∈ S := huw ▸ u.property
    have : (⟨w, hw⟩ : ↥S) ∈ supp f := by
      have : u = ⟨w, hw⟩ := Subtype.ext huw
      exact this ▸ hu
    exact (essentialDep_transfer S f w hw).mpr ((mem_supp_iff f ⟨w, hw⟩).mp this)

end CellularAutomata.RedundantNeighbor
