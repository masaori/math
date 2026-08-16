import Ising3DCut.AllEdgeVariablesToOneIndeterminate

/-!
人手証明「粗視化の値の一致から Z_L の等式へ」の Lean 具体版（第一歩）。

全ての辺変数を同じ正の有理数 `q` へ置く環準同型 `ε_{L,q}` を定め、それが
「全辺変数を単一不定元へ置く `κ_L`」と「`X ↦ q` の評価 `ev_q`」の合成に一致することを
多変数多項式環の普遍性（`MvPolynomial.ringHom_ext`）で示す。第二歩（`ε_{L,q}(𝒵_L)=Z_L(q)` と
値の一致から等式へ）は次の tick。
-/

namespace Ising3DCut

open MvPolynomial

section

variable {Configuration Edge : Type*}
variable [Fintype Configuration] [Fintype Edge] [DecidableEq Edge]

/-- 全ての辺変数を同じ有理数 `q` へ置く環準同型 `ε_{L,q}`（人手証明の定義）。 -/
noncomputable def allEdgesToRational (q : ℚ) : MvPolynomial Edge ℤ →+* ℚ :=
  eval₂Hom (Int.castRingHom ℚ) fun _ ↦ q

/-- 単一不定元の多項式を `X ↦ q` で評価する環準同型 `ev_q`。 -/
noncomputable def evalAtRational (q : ℚ) : Polynomial ℤ →+* ℚ :=
  Polynomial.eval₂RingHom (Int.castRingHom ℚ) q

/-- `ε_{L,q} = ev_q ∘ κ_L`：両辺は定数と各辺変数で一致するので、普遍性から一致する。 -/
theorem allEdgesToRational_eq_evalAtRational_comp_allEdgesToOneIndeterminate (q : ℚ) :
    (allEdgesToRational q : MvPolynomial Edge ℤ →+* ℚ) =
      (evalAtRational q).comp allEdgesToOneIndeterminate := by
  apply MvPolynomial.ringHom_ext
  · intro r
    simp [allEdgesToRational, evalAtRational, allEdgesToOneIndeterminate]
  · intro e
    simp [allEdgesToRational, evalAtRational, allEdgesToOneIndeterminate_X]

end

end Ising3DCut
