/-
定義「軌道を保つ置換の、軌道への制限」と主張「軌道への制限はその軌道の上の全単射である」
「制限の全体が一致する軌道を保つ置換は一致する」の必要十分版。

具体版（`Ising2DLambda.AlgebraicEigenvalue.OrbitRestriction`）の証明が実際に使っているのは
次だけである。証明手順は具体版と同じ（同じ単射性・同じ逆像の取り方・同じ点ごとの比較）。

  主張                    使っている性質
  restrictionOf           その集合が置換の像で閉じていること（`O.image φ = O`）だけ。
                          **その集合が軌道であることを一切使っていない。**
  restriction_bijective   上に加えて置換が単射であること（`Equiv.Perm` なので自動）。
  eq_of_agree_on_cover    集合の族が全体を覆うことだけ。

削れなかった仮定と、その理由。

1. `O.image φ = O`（`restrictionOf` と `restriction_bijective`）。制限が O から O への
   写像として定まること（行き先が O に収まること）と、全射性の両方に要る。
   人手証明が `claim_orbit_preserving_image` から出している段にあたる。
   包含 `O.image φ ⊆ O` だけへ弱めると写像としては定まるが**全射性が出ない**
   （反例: ι を有限にしなければ、像が真に小さい部分集合になる）。
2. `DecidableEq ι`。`Finset.image` を書くために要る。
3. 覆うこと `∀ i, ∃ O ∈ 𝒪, i ∈ O`（`eq_of_agree_on_cover`）。
   **軌道どうしが互いに素であることは使っていない。** 人手証明もこの段では
   「どの τ も自分の軌道に属する」ことしか使っていない（互いに素であることが要るのは、
   逆向きの構成——各軌道の上の置換の組から置換を貼り合わせること——の側である）。
   また ι の有限性も要らない。

具体版との差で言えば、行配位であること・巡回シフト `S` があること・軌道であること・
`Fintype ι` はいずれも使っていない。すなわちこの 3 つの主張は「置換で閉じた部分集合」と
「全体を覆う族」についての言明であって、軌道の理論には属さない。

mathlib の群作用の軌道の一般論・`Equiv.Perm.subtypePerm` の既製定理は引いていない
（`subtypePerm` を引くと「像で閉じているから制限が定まる」という人手証明の段が
既製の構成の性質へ置き換わる）。

住処: ここに ℝ / ℂ は現れない（添字は一般の型、個数は ℕ）。
-/
import Mathlib.Data.Finset.Image
import Mathlib.Logic.Equiv.Defs

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

variable {ι : Type*} [DecidableEq ι]

/-- 人手証明の定義「軌道を保つ置換の、軌道への制限」`φ↾_O`。

行き先が `O` に収まることは定めるだけでは言えないので、仮定 `h : O.image φ = O` から出す
（人手証明が `claim_orbit_preserving_image` を引いている段にあたる）。
ここで `O` が軌道であることは**使っていない**。 -/
def restrictionOf (φ : Equiv.Perm ι) {O : Finset ι} (h : O.image φ = O)
    (i : {i : ι // i ∈ O}) : {i : ι // i ∈ O} :=
  ⟨φ i.1, by
    have hmem := Finset.mem_image_of_mem φ i.2
    rwa [h] at hmem⟩

@[simp]
theorem restrictionOf_val (φ : Equiv.Perm ι) {O : Finset ι} (h : O.image φ = O)
    (i : {i : ι // i ∈ O}) : (restrictionOf φ h i).1 = φ i.1 := rfl

/-- 人手証明の主張「軌道への制限はその軌道の上の全単射である」。

証明は人手証明どおり、単射性と全射性を別々に示す。
単射性は `φ` の単射性から、全射性は `O.image φ = O` から逆像を 1 つ取ることによる。 -/
theorem restriction_bijective (φ : Equiv.Perm ι) {O : Finset ι} (h : O.image φ = O) :
    Function.Bijective (restrictionOf φ h) := by
  constructor
  · -- 単射性: φ↾_O(i₁) = φ↾_O(i₂) → φ(i₁) = φ(i₂) → i₁ = i₂
    intro i₁ i₂ hi
    have h₁ : φ i₁.1 = φ i₂.1 := congrArg Subtype.val hi
    exact Subtype.ext (φ.injective h₁)
  · -- 全射性: i' ∈ O = O.image φ なので φ(i₃) = i' を満たす i₃ ∈ O が取れる
    intro i'
    have hmem : i'.1 ∈ O.image φ := by rw [h]; exact i'.2
    obtain ⟨i₃, hi₃O, hi₃⟩ := Finset.mem_image.mp hmem
    exact ⟨⟨i₃, hi₃O⟩, Subtype.ext hi₃⟩

/-- 人手証明の主張「制限の全体が一致する軌道を保つ置換は一致する」の本体。

使っているのは**族が全体を覆うことだけ**である（互いに素であることも、
族の元が軌道であることも、`ι` の有限性も使っていない）。 -/
theorem eq_of_agree_on_cover {φ ψ : Equiv.Perm ι} (𝒪 : Set (Finset ι))
    (hcover : ∀ i : ι, ∃ O ∈ 𝒪, i ∈ O)
    (h : ∀ O ∈ 𝒪, ∀ i ∈ O, φ i = ψ i) : φ = ψ := by
  apply Equiv.ext
  intro i
  obtain ⟨O, hO𝒪, hiO⟩ := hcover i
  exact h O hO𝒪 i hiO

/-- 制限の相等から点ごとの相等が出ること（上の補題へ渡すための橋）。

人手証明の式変形 `φ(τ) = (φ↾_O)(τ) = (ψ↾_O)(τ) = ψ(τ)` の 3 段そのものである。 -/
theorem apply_eq_of_restriction_eq {φ ψ : Equiv.Perm ι} {O : Finset ι}
    (hφ : O.image φ = O) (hψ : O.image ψ = O)
    (heq : restrictionOf φ hφ = restrictionOf ψ hψ) {i : ι} (hi : i ∈ O) : φ i = ψ i :=
  calc φ i = (restrictionOf φ hφ ⟨i, hi⟩).1 := rfl
    _ = (restrictionOf ψ hψ ⟨i, hi⟩).1 := by rw [heq]
    _ = ψ i := rfl

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
