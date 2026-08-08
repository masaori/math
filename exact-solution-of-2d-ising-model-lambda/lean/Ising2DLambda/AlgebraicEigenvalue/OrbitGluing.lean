/-
章「固有値の代数性」の「軌道ごとの置換の組の貼り合わせ」の具体版
（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは定義 2 件
（`def_orbit_permutation_family` / `def_orbit_gluing`）と主張 3 件
（`claim_orbit_gluing_bijective` / `claim_orbit_gluing_orbit_preserving` /
`claim_orbit_gluing_restriction`）に対応する。

  人手証明                                   このファイル
  組 α ∈ 𝔄_L                                OrbitFamily + OrbitFamilyBijective
  gl(α) : R_L → R_L                          glueFun
  τ ∈ O ∈ 𝒪_L ならば O(τ) = O                rowShiftOrbit_eq_of_mem_orbitSet
  gl(α) は全単射                             glueFun_bijective
  gl(α) ∈ 𝔖^𝒪_L                             gluePerm_orbitPreserving
  gl(α)↾_O = α(O)                            orbitRestriction_gluePerm

組の型について。人手証明の 𝔄_L は 𝒪_L の各元 O へ O の上の全単射を対応させる組だが、
ここでは対応を Finset 全体で定めた関数 `OrbitFamily` として持ち、全単射であることは
軌道についてだけ要求する（`OrbitFamilyBijective`）。貼り合わせが触るのは O(τ) の成分だけなので、
軌道でない Finset における値は結果に一切効かない。

mathlib の `Equiv.Perm.subtypePerm` と群作用の軌道の一般論は引いていない
（引くと「各行配位の属する軌道の上の写像を当てる」という人手証明の定め方が
既製の構成へ置き換わる）。使ったのは `Equiv.ofBijective`（自分で示した全単射性を
置換として包むだけ）と `Subtype` の基本補題だけである。

住処: 人手証明のこれらのブロックは ℕ を宣言している。
ここに ℝ / ℂ は現れない（添字は行配位）。
-/
import Ising2DLambda.AlgebraicEigenvalue.OrbitRestriction

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 人手証明の定義「軌道ごとの置換の組」`𝔄_L` の台。

各 `O` へ `O` から `O` への写像を 1 つ対応させる。全単射であることは
`OrbitFamilyBijective` で軌道についてだけ要求する。 -/
def OrbitFamily (L : ℕ) : Type :=
  ∀ O : Finset (RowConfig L), {τ : RowConfig L // τ ∈ O} → {τ : RowConfig L // τ ∈ O}

/-- 人手証明の定義「軌道ごとの置換の組」の全単射性の条件。 -/
def OrbitFamilyBijective (α : OrbitFamily L) : Prop :=
  ∀ O ∈ rowShiftOrbitSet L, Function.Bijective (α O)

/-- 人手証明が定義の中で述べている一意性「τ ∈ O ∈ 𝒪_L ならば O(τ) = O」。

`claim_row_config_orbit_mem_eq`（`rowShiftOrbit_eq_of_mem`）から出す。 -/
theorem rowShiftOrbit_eq_of_mem_orbitSet {O : Finset (RowConfig L)}
    (hO : O ∈ rowShiftOrbitSet L) {τ : RowConfig L} (hτ : τ ∈ O) :
    rowShiftOrbit L τ = O := by
  obtain ⟨τ₀, rfl⟩ := mem_rowShiftOrbitSet.mp hO
  exact rowShiftOrbit_eq_of_mem τ₀ hτ

/-- 人手証明の定義「軌道ごとの置換の組の貼り合わせ」`gl(α)(τ) = (α(O(τ)))(τ)`。

行き先が `R_L` に収まることは、値が `O(τ) ⊆ R_L` の元であることによる
（型としては `RowConfig L` の元を取り出すだけである）。 -/
noncomputable def glueFun (α : OrbitFamily L) (τ : RowConfig L) : RowConfig L :=
  (α (rowShiftOrbit L τ) ⟨τ, self_mem_rowShiftOrbit τ⟩).1

/-- 人手証明の「gl(α)(τ) ∈ O(τ)」（主張「貼り合わせは軌道を保つ」の 2 段の式変形）。 -/
theorem glueFun_mem_orbit (α : OrbitFamily L) (τ : RowConfig L) :
    glueFun α τ ∈ rowShiftOrbit L τ :=
  (α (rowShiftOrbit L τ) ⟨τ, self_mem_rowShiftOrbit τ⟩).2

/-- 人手証明の主張「貼り合わせの各軌道への制限はもとの組に一致する」の本体
（式変形 `gl(α)(τ) = (α(O(τ)))(τ) = (α(O))(τ)`）。 -/
theorem glueFun_apply_of_mem (α : OrbitFamily L) {O : Finset (RowConfig L)}
    (hO : O ∈ rowShiftOrbitSet L) {τ : RowConfig L} (hτ : τ ∈ O) :
    glueFun α τ = (α O ⟨τ, hτ⟩).1 := by
  have h : rowShiftOrbit L τ = O := rowShiftOrbit_eq_of_mem_orbitSet hO hτ
  subst h
  rfl

/-- 人手証明の主張「貼り合わせは行配位の全体の上の全単射である」。

証明は人手証明どおり、単射性と全射性を別々に示す。単射性では、行き先が一致することから
`claim_row_config_orbit_disjoint_or_eq` で `O(τ₁) = O(τ₂)` を出し、そのうえで
組の単射性を当てる。全射性は組の全射性から `τ₄` を 1 つ取る。 -/
theorem glueFun_bijective {α : OrbitFamily L} (hbij : OrbitFamilyBijective α) :
    Function.Bijective (glueFun α) := by
  constructor
  · -- 単射性
    intro τ₁ τ₂ hτ
    -- τ₃ := gl(α)(τ₁) は O(τ₁) にも O(τ₂) にも属する
    have hv₁ : glueFun α τ₁ ∈ rowShiftOrbit L τ₁ := glueFun_mem_orbit α τ₁
    have hv₂ : glueFun α τ₁ ∈ rowShiftOrbit L τ₂ := hτ ▸ glueFun_mem_orbit α τ₂
    -- 交わりが空でないので 2 つの軌道は一致する
    have horb : rowShiftOrbit L τ₁ = rowShiftOrbit L τ₂ :=
      rowShiftOrbit_eq_of_inter_nonempty τ₁ τ₂ ⟨glueFun α τ₁, Finset.mem_inter.mpr ⟨hv₁, hv₂⟩⟩
    have hO : rowShiftOrbit L τ₁ ∈ rowShiftOrbitSet L := mem_rowShiftOrbitSet.mpr ⟨τ₁, rfl⟩
    have hτ₂ : τ₂ ∈ rowShiftOrbit L τ₁ := horb ▸ self_mem_rowShiftOrbit τ₂
    have e₁ : glueFun α τ₁ = (α (rowShiftOrbit L τ₁) ⟨τ₁, self_mem_rowShiftOrbit τ₁⟩).1 :=
      glueFun_apply_of_mem α hO (self_mem_rowShiftOrbit τ₁)
    have e₂ : glueFun α τ₂ = (α (rowShiftOrbit L τ₁) ⟨τ₂, hτ₂⟩).1 :=
      glueFun_apply_of_mem α hO hτ₂
    have hval : α (rowShiftOrbit L τ₁) ⟨τ₁, self_mem_rowShiftOrbit τ₁⟩
        = α (rowShiftOrbit L τ₁) ⟨τ₂, hτ₂⟩ :=
      Subtype.ext (by rw [← e₁, ← e₂, hτ])
    exact congrArg Subtype.val ((hbij _ hO).1 hval)
  · -- 全射性
    intro τ'
    have hO : rowShiftOrbit L τ' ∈ rowShiftOrbitSet L := mem_rowShiftOrbitSet.mpr ⟨τ', rfl⟩
    obtain ⟨τ₄, hτ₄⟩ := (hbij _ hO).2 ⟨τ', self_mem_rowShiftOrbit τ'⟩
    refine ⟨τ₄.1, ?_⟩
    have e : glueFun α τ₄.1 = (α (rowShiftOrbit L τ') ⟨τ₄.1, τ₄.2⟩).1 :=
      glueFun_apply_of_mem α hO τ₄.2
    rw [e, Subtype.coe_eta, hτ₄]

/-- 貼り合わせを置換として包んだもの（全単射性は上で自分で示したものを使う）。 -/
noncomputable def gluePerm {α : OrbitFamily L} (hbij : OrbitFamilyBijective α) :
    Equiv.Perm (RowConfig L) :=
  Equiv.ofBijective (glueFun α) (glueFun_bijective hbij)

@[simp]
theorem gluePerm_apply {α : OrbitFamily L} (hbij : OrbitFamilyBijective α)
    (τ : RowConfig L) : gluePerm hbij τ = glueFun α τ := rfl

/-- 人手証明の主張「貼り合わせは軌道を保つ置換である」。 -/
theorem gluePerm_orbitPreserving {α : OrbitFamily L} (hbij : OrbitFamilyBijective α) :
    OrbitPreserving L (gluePerm hbij) :=
  fun τ => glueFun_mem_orbit α τ

/-- 人手証明の主張「貼り合わせの各軌道への制限はもとの組に一致する」。 -/
theorem orbitRestriction_gluePerm {α : OrbitFamily L} (hbij : OrbitFamilyBijective α)
    {O : Finset (RowConfig L)} (hO : O ∈ rowShiftOrbitSet L) :
    orbitRestriction (gluePerm_orbitPreserving hbij) hO = α O := by
  funext τ
  refine Subtype.ext ?_
  show glueFun α τ.1 = (α O τ).1
  rw [glueFun_apply_of_mem α hO τ.2, Subtype.coe_eta]

end Ising2DLambda.AlgebraicEigenvalue
