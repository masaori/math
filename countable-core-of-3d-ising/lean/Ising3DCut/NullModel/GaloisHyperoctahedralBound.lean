/-
人手証明の主張「Galois 群は逆数対の置換群に埋め込まれる」
（ラベル `claim_galois_hyperoctahedral_bound`）の具体版。

人手証明とこのファイルの対応:

  非固定根上の逆数写像は対合である                 `reciprocalRoot_involution`
  非固定根上の逆数写像には不動点がない             `reciprocalRoot_ne_self`
  分解体の自己同型は相異なる非固定根を置換する     `rootAction`
  自己同型は逆数写像と可換である                   `rootAction_reciprocal`
  根への作用は忠実であり、逆数対を保つ置換へ埋込む `galoisGroup_embeds_in_pairPermutations`

`hclosed` は有理係数多項式の根が Galois 自己同型で根へ移る段、`hfaithful` は
分解体が全根で生成されるため全根を固定する自己同型が恒等写像になる段に対応する。
住処: 有限次代数拡大の元、有限集合、有限置換群のみ。ℝ / ℂ は現れない。
-/
import Mathlib.FieldTheory.Galois.Basic

namespace Ising3DCut.NullModel

noncomputable section

variable {K : Type*} [Field K]

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
def rootAction (R : Finset K) (G : Subgroup (K ≃+* K))
    (hclosed : ∀ g : G, ∀ a ∈ R, g.1 a ∈ R) : G →* Equiv.Perm (NonfixedRoots R) where
  toFun g :=
    { toFun := fun a => ⟨g.1 a.1, hclosed g a.1 a.2⟩
      invFun := fun a => ⟨(g⁻¹).1 a.1, hclosed (g⁻¹) a.1 a.2⟩
      left_inv := by intro a; apply Subtype.ext; simp
      right_inv := by intro a; apply Subtype.ext; simp }
  map_one' := by ext a; rfl
  map_mul' := by intro g h; ext a; rfl

/-- 体の自己同型は逆数と可換するので、根の逆数対を逆数対へ送る。 -/
theorem rootAction_reciprocal (R : Finset K) (G : Subgroup (K ≃+* K))
    (hclosed : ∀ g : G, ∀ a ∈ R, g.1 a ∈ R)
    (hinv : ∀ a ∈ R, a⁻¹ ∈ R) (g : G) (a : NonfixedRoots R) :
    rootAction R G hclosed g (reciprocalRoot R hinv a) =
      reciprocalRoot R hinv (rootAction R G hclosed g a) := by
  apply Subtype.ext
  simp [rootAction, reciprocalRoot]

/-- `claim_galois_hyperoctahedral_bound` の具体版。

Galois 群は非固定根への忠実な置換として埋め込まれ、その像の全要素は逆数写像と可換する。
したがって像は逆数二元対を保つ置換群、すなわち超八面体群の部分群である。
-/
theorem galoisGroup_embeds_in_pairPermutations
    (R : Finset K) (G : Subgroup (K ≃+* K))
    (hclosed : ∀ g : G, ∀ a ∈ R, g.1 a ∈ R)
    (hinv : ∀ a ∈ R, a⁻¹ ∈ R)
    (hfaithful : ∀ g h : G, (∀ a : NonfixedRoots R, g.1 a.1 = h.1 a.1) → g = h) :
    ∃ φ : G →* Equiv.Perm (NonfixedRoots R),
      Function.Injective φ ∧
        ∀ g a, φ g (reciprocalRoot R hinv a) = reciprocalRoot R hinv (φ g a) := by
  refine ⟨rootAction R G hclosed, ?_, ?_⟩
  · intro g h hgh
    apply hfaithful g h
    intro a
    exact congrArg Subtype.val (DFunLike.congr_fun hgh a)
  · exact rootAction_reciprocal R G hclosed hinv

end

end Ising3DCut.NullModel
