/-
章「固有値の代数性」の定義「軌道の上の互換の反復合成」と、主張
「互換の反復合成は軌道の上の全単射である」の具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは定義 1 件
（`def_orbit_transposition_composite`）と主張 1 件
（`claim_orbit_transposition_composite_bijective`）に対応する。

  人手証明                                          このファイル
  定義の前段（τ₀ ∈ O ならば S^[k](τ₀) ∈ O）         rowShiftIterate_mem_of_mem_orbitSet
  Ψ^{O,τ₀}_k（k についての再帰）                    orbitTranspositionComposite
  証明の準備（全単射 2 つの合成は全単射）           bijective_comp_of_bijective
  主張（Ψ_k ∈ 𝔅_O）                                 orbitTranspositionComposite_bijective
                                                    orbitTranspositionCompositeBij

`bijective_comp_of_bijective` は mathlib の `Function.Bijective.comp` を引かずに書いてある。
人手証明が単射性と全射性を別々に手で示しているので、そこを既製の補題へ委ねると
1 対 1 対応が切れるためである。

住処: 人手証明のこれらのブロックは ℕ を宣言している。
ここに ℝ / ℂ は現れない（現れるのは行配位とその部分集合、その上の写像と相等だけ）。
-/
import Ising2DLambda.AlgebraicEigenvalue.OrbitTranspositionSign

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 人手証明が定義の前段で示していること。`τ₀ ∈ O ∈ 𝒪_L` ならば任意の `k` について
`S^[k](τ₀) ∈ O` である。

人手証明どおり、まず `O(τ₀) = O`（`claim_row_config_orbit_mem_eq`）を出し、
そのうえで `S^[k](τ₀) ∈ O(τ₀)`（`def_row_config_orbit`）を移す。 -/
theorem rowShiftIterate_mem_of_mem_orbitSet {O : Finset (RowConfig L)}
    (hO : O ∈ rowShiftOrbitSet L) {τ₀ : RowConfig L} (hτ₀ : τ₀ ∈ O) (k : ℕ) :
    rowShiftIterate L k τ₀ ∈ O := by
  have horbit : rowShiftOrbit L τ₀ = O := rowShiftOrbit_eq_of_mem_orbitSet hO hτ₀
  have hmem : rowShiftIterate L k τ₀ ∈ rowShiftOrbit L τ₀ := mem_rowShiftOrbit.mpr ⟨k, rfl⟩
  exact horbit ▸ hmem

/-- 人手証明の定義「軌道の上の互換の反復合成」`Ψ^{O,τ₀}_k : O → O`。

`Ψ_0 = id_O`、`Ψ_{k+1} = t^O_{τ₀,S^[k+1](τ₀)} ∘ Ψ_k`。
合成の順（添字の小さい互換ほど先に作用する）も人手証明のとおりである。

ここでは全単射であることを型に持たせず、素の写像として定める。全単射であることは
次の主張で示す（型に持たせてしまうと、人手証明の帰納法が消える）。 -/
noncomputable def orbitTranspositionComposite {O : Finset (RowConfig L)}
    (hO : O ∈ rowShiftOrbitSet L) {τ₀ : RowConfig L} (hτ₀ : τ₀ ∈ O) :
    ℕ → ({τ : RowConfig L // τ ∈ O} → {τ : RowConfig L // τ ∈ O})
  | 0 => id
  | (k + 1) => fun τ =>
      orbitTranspositionRestriction O hτ₀
        (rowShiftIterate_mem_of_mem_orbitSet hO hτ₀ (k + 1))
        (orbitTranspositionComposite hO hτ₀ k τ)

/-- 人手証明の証明の準備。`O` から `O` への全単射 2 つの合成は `O` から `O` への全単射である。

人手証明どおり単射性と全射性を別々に示す（mathlib の `Function.Bijective.comp` は引かない）。 -/
theorem bijective_comp_of_bijective {α : Type*} {f g : α → α}
    (hf : Function.Bijective f) (hg : Function.Bijective g) :
    Function.Bijective (fun x => g (f x)) := by
  constructor
  · -- 単射性: g(f(τ)) = g(f(τ')) ならば g の単射性で f(τ) = f(τ')、f の単射性で τ = τ'
    intro x y hxy
    exact hf.1 (hg.1 hxy)
  · -- 全射性: g の全射性で g(τ') = τ''、f の全射性で f(τ) = τ' を取る
    intro z
    obtain ⟨y, hy⟩ := hg.2 z
    obtain ⟨x, hx⟩ := hf.2 y
    refine ⟨x, ?_⟩
    show g (f x) = z
    rw [hx, hy]

/-- 人手証明の主張。任意の `k` について `Ψ^{O,τ₀}_k` は `O` から `O` への全単射である。

人手証明どおり `k` についての帰納法である。出発点は恒等写像、一歩は上の準備を当てる。 -/
theorem orbitTranspositionComposite_bijective {O : Finset (RowConfig L)}
    (hO : O ∈ rowShiftOrbitSet L) {τ₀ : RowConfig L} (hτ₀ : τ₀ ∈ O) (k : ℕ) :
    Function.Bijective (orbitTranspositionComposite hO hτ₀ k) := by
  induction k with
  | zero =>
      -- Ψ_0 = id_O。恒等写像は自分自身を逆写像に持つので全単射である。
      exact Function.bijective_id
  | succ k ih =>
      -- Ψ_{k+1} = t^O_{τ₀,S^[k+1](τ₀)} ∘ Ψ_k。互換の制限は 𝔅_O の元なので全単射である。
      show Function.Bijective (fun τ =>
        orbitTranspositionRestriction O hτ₀
          (rowShiftIterate_mem_of_mem_orbitSet hO hτ₀ (k + 1))
          (orbitTranspositionComposite hO hτ₀ k τ))
      exact bijective_comp_of_bijective
        (f := orbitTranspositionComposite hO hτ₀ k)
        (g := orbitTranspositionRestriction O hτ₀
          (rowShiftIterate_mem_of_mem_orbitSet hO hτ₀ (k + 1)))
        ih
        (orbitTranspositionRestriction O hτ₀
          (rowShiftIterate_mem_of_mem_orbitSet hO hτ₀ (k + 1))).bijective

/-- 人手証明の主張の結論を `𝔅_O`（`OrbitBij O`）の元として書き直したもの。 -/
noncomputable def orbitTranspositionCompositeBij {O : Finset (RowConfig L)}
    (hO : O ∈ rowShiftOrbitSet L) {τ₀ : RowConfig L} (hτ₀ : τ₀ ∈ O) (k : ℕ) : OrbitBij O :=
  Equiv.ofBijective _ (orbitTranspositionComposite_bijective hO hτ₀ k)

end Ising2DLambda.AlgebraicEigenvalue
