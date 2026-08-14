/-
人手証明の主張「Galois 群は逆数対の置換群に埋め込まれる」
（ラベル `claim_galois_hyperoctahedral_bound`）の具体版。

人手証明とこのファイルの対応:

  非固定根上の逆数写像は対合である                 `reciprocalRoot_involution`
  非固定根上の逆数写像には不動点がない             `reciprocalRoot_ne_self`
  分解体の自己同型は相異なる非固定根を置換する     `rootAction`
  自己同型は逆数写像と可換である                   `rootAction_reciprocal`
  根への作用は忠実であり、逆数対を保つ置換へ埋込む `galoisGroup_embeds_in_pairPermutations`

`hclosed` は有理係数多項式の根が Galois 自己同型で根へ移る段、`hgenerated` は
有理な固定根を除いた根が分解体を生成する段に対応する。忠実性は `hgenerated` から
`rootAction_injective_of_adjoin_eq_top` で証明し、仮定には置かない。
住処: 有限次代数拡大の元、有限集合、有限置換群のみ。ℝ / ℂ は現れない。
-/
import Mathlib.FieldTheory.Galois.Basic

namespace Ising3DCut.NullModel

noncomputable section

variable {F K : Type*} [Field F] [Field K] [Algebra F K]

/-- 相異なる非固定根を表す有限集合。 -/
abbrev NonfixedRoots (R : Finset K) := {a : K // a ∈ R}

/-- 非固定根の逆数。`hinv` は回文性から得る根集合の逆数閉性に対応する。 -/
def reciprocalRoot (R : Finset K) (hinv : ∀ a ∈ R, a⁻¹ ∈ R) :
    NonfixedRoots R → NonfixedRoots R :=
  fun a => ⟨a.1⁻¹, hinv a.1 a.2⟩

/-- 逆数を二回取ると元の非零根へ戻る。 -/
theorem reciprocalRoot_involution (R : Finset K)
    (hinv : ∀ a ∈ R, a⁻¹ ∈ R) (a : NonfixedRoots R) :
    reciprocalRoot R hinv (reciprocalRoot R hinv a) = a := by
  apply Subtype.ext
  exact inv_inv a.1

/-- `+1,-1` を除いた根では逆数写像に不動点がない。 -/
theorem reciprocalRoot_ne_self (R : Finset K) (hinv : ∀ a ∈ R, a⁻¹ ∈ R)
    (hnonfixed : ∀ a ∈ R, a⁻¹ ≠ a) (a : NonfixedRoots R) :
    reciprocalRoot R hinv a ≠ a := by
  intro h
  exact hnonfixed a.1 a.2 (congrArg Subtype.val h)

/-- 分解体の自己同型が相異なる非固定根へ及ぼす置換作用。 -/
def rootAction (R : Finset K) (G : Subgroup (K ≃ₐ[F] K))
    (hclosed : ∀ g : G, ∀ a ∈ R, g.1 a ∈ R) : G →* Equiv.Perm (NonfixedRoots R) where
  toFun g :=
    { toFun := fun a => ⟨g.1 a.1, hclosed g a.1 a.2⟩
      invFun := fun a => ⟨(g⁻¹).1 a.1, hclosed (g⁻¹) a.1 a.2⟩
      left_inv := by intro a; apply Subtype.ext; simp
      right_inv := by intro a; apply Subtype.ext; simp }
  map_one' := by ext a; rfl
  map_mul' := by intro g h; ext a; rfl

/-- 体の自己同型は逆数と可換するので、根の逆数対を逆数対へ送る。 -/
theorem rootAction_reciprocal (R : Finset K) (G : Subgroup (K ≃ₐ[F] K))
    (hclosed : ∀ g : G, ∀ a ∈ R, g.1 a ∈ R)
    (hinv : ∀ a ∈ R, a⁻¹ ∈ R) (g : G) (a : NonfixedRoots R) :
    rootAction R G hclosed g (reciprocalRoot R hinv a) =
      reciprocalRoot R hinv (rootAction R G hclosed g a) := by
  apply Subtype.ext
  simp [rootAction, reciprocalRoot]

/-- 分解体が対象の根で生成されるなら、根への作用は忠実である。

人手証明の「全根を固定する自己同型は、根で生成される分解体の全元を固定する」に対応する。
生成元、有理係数、加法、乗法の順に、生成される部分代数の全元で二つの自己同型が一致する
ことを示す。 -/
theorem rootAction_injective_of_adjoin_eq_top
    (R : Finset K) (G : Subgroup (K ≃ₐ[F] K))
    (hclosed : ∀ g : G, ∀ a ∈ R, g.1 a ∈ R)
    (hgenerated : Algebra.adjoin F (R : Set K) = ⊤) :
    Function.Injective (rootAction R G hclosed) := by
  intro g h hgh
  apply Subtype.ext
  apply AlgEquiv.ext
  intro x
  have hx : x ∈ Algebra.adjoin F (R : Set K) := by
    rw [hgenerated]
    simp
  apply Algebra.adjoin_induction (R := F) (A := K) (p := fun y _ => g.1 y = h.1 y)
  · intro y hy
    let a : NonfixedRoots R := ⟨y, hy⟩
    exact congrArg Subtype.val (DFunLike.congr_fun hgh a)
  · intro c
    exact (g.1.commutes c).trans (h.1.commutes c).symm
  · intro y z _ _ hy hz
    rw [map_add, map_add, hy, hz]
  · intro y z _ _ hy hz
    rw [map_mul, map_mul, hy, hz]
  · exact hx

/-- `claim_galois_hyperoctahedral_bound` の具体版。

Galois 群は非固定根への忠実な置換として埋め込まれ、その像の全要素は逆数写像と可換する。
したがって像は逆数二元対を保つ置換群、すなわち超八面体群の部分群である。
-/
theorem galoisGroup_embeds_in_pairPermutations
    (R : Finset K) (G : Subgroup (K ≃ₐ[F] K))
    (hclosed : ∀ g : G, ∀ a ∈ R, g.1 a ∈ R)
    (hinv : ∀ a ∈ R, a⁻¹ ∈ R)
    (hgenerated : Algebra.adjoin F (R : Set K) = ⊤) :
    ∃ φ : G →* Equiv.Perm (NonfixedRoots R),
      Function.Injective φ ∧
        ∀ g a, φ g (reciprocalRoot R hinv a) = reciprocalRoot R hinv (φ g a) := by
  refine ⟨rootAction R G hclosed, ?_, ?_⟩
  · exact rootAction_injective_of_adjoin_eq_top R G hclosed hgenerated
  · exact rootAction_reciprocal R G hclosed hinv

end

end Ising3DCut.NullModel
