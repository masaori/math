/-
章「固有値の代数性」の主張「シフト行列の特性多項式は、軌道ごとの和の積である」の具体版
（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts` の
`claim_shift_char_orbit_product`。

  人手証明                                          このファイル
  A(O_L) = A_L（第 2 の等号）                       orbitPermFamilyOnUnivEquiv
  分配則を s = O_L と取った段（第 3 の等号）        prod_sum_eq_sum_prod_orbitFamilyAll
  主張そのもの                                      charPoly_shiftMatrix_eq_prod_orbit_sum

人手証明では $\mathfrak{A}(\mathcal{O}_L)=\mathfrak{A}_L$ は等号だが、Lean では
**同じ型ではない**。`OrbitPermFamilyOn univ` は所属の証明 `O ∈ univ` を余分に受け取る形、
`OrbitPermFamily L` は受け取らない形である。そこで行き来する全単射を明示的に置き、
それで和の添字を取り替える（両向きの往復は `rfl` で閉じる。証明の受け渡しを
組み替えているだけだからである）。

積の側も同じ理由で 1 段要る。分配則の右辺の積は `univ.attach` にわたる積
（成分を取り出すのに所属の証明が要る形）なので、`Finset.prod_attach` で
`univ` にわたる積へ移す。前セクションの主張の積は `(rowShiftOrbitSet L).attach` に
わたる積だが、これは `Finset.attach_eq_univ` により `univ : Finset (OrbitIndex L)` である。

住処: 人手証明のこのブロックは ℤ を宣言している（値は ℤ[x][t] の元）。
ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.OrbitFamilyDistributive
import Ising2DLambda.AlgebraicEigenvalue.OrbitFamilySum

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 人手証明の第 2 の等号 `A(O_L) = A_L` に当たる橋渡し。

`OrbitPermFamilyOn univ` は所属の証明を受け取る形、`OrbitPermFamily L` は
受け取らない形であり、引数の受け渡しが違うだけで同じ組を表す（往復はどちらも `rfl`）。 -/
def orbitPermFamilyOnUnivEquiv :
    OrbitPermFamilyOn (univ : Finset (OrbitIndex L)) ≃ OrbitPermFamily L where
  toFun α := fun O => α O (Finset.mem_univ O)
  invFun α := fun O _ => α O
  left_inv _ := rfl
  right_inv _ := rfl

/-- 人手証明の第 3 の等号（分配則を `s = O_L` と取った段）を、
和の添字と積の添字の両方を `OrbitPermFamily L` と `univ` の形へ揃えて書いたもの。 -/
theorem prod_sum_eq_sum_prod_orbitFamilyAll
    (g : (O : OrbitIndex L) → OrbitBij O.1 → SecondPoly) :
    (∏ O : OrbitIndex L, ∑ ψ : OrbitBij O.1, g O ψ)
      = ∑ α : OrbitPermFamily L, ∏ O : OrbitIndex L, g O (α O) := by
  classical
  calc (∏ O : OrbitIndex L, ∑ ψ : OrbitBij O.1, g O ψ)
      = ∑ α : OrbitPermFamilyOn (univ : Finset (OrbitIndex L)),
          ∏ O ∈ (univ : Finset (OrbitIndex L)).attach, g O.1 (α O.1 O.2) :=
        prod_sum_eq_sum_prod_orbitFamily g univ
    -- 和の添字を、所属の証明を受け取らない形へ取り替える。
    _ = ∑ α : OrbitPermFamily L,
          ∏ O ∈ (univ : Finset (OrbitIndex L)).attach, g O.1 (α O.1) :=
        Equiv.sum_comp orbitPermFamilyOnUnivEquiv
          (fun α => ∏ O ∈ (univ : Finset (OrbitIndex L)).attach, g O.1 (α O.1))
    -- 積の添字を `univ.attach` から `univ` へ移す。
    _ = ∑ α : OrbitPermFamily L, ∏ O : OrbitIndex L, g O (α O) := by
        refine Finset.sum_congr rfl ?_
        intro α _
        exact Finset.prod_attach (univ : Finset (OrbitIndex L)) (fun O => g O (α O))

/-- 人手証明の主張「シフト行列の特性多項式は、軌道ごとの和の積である」。

人手証明の 3 段をそのまま辿る（前セクションの主張 → `A(O_L) = A_L` →
分配則を `s = O_L` と取った段）。あとの 2 段は上の補題にまとめてある。 -/
theorem charPoly_shiftMatrix_eq_prod_orbit_sum (L : ℕ) [NeZero L] :
    charPoly L (shiftMatrix L)
      = ∏ O : OrbitIndex L, ∑ ψ : OrbitBij O.1,
          orbitFactor L (charMatrix L (shiftMatrix L)) O.1 (ambientOf O.1 ψ) := by
  classical
  calc charPoly L (shiftMatrix L)
      = ∑ α : OrbitPermFamily L,
          ∏ O ∈ (rowShiftOrbitSet L).attach,
            orbitFactor L (charMatrix L (shiftMatrix L)) O.1 (ambientOf O.1 (α O)) :=
        charPoly_shiftMatrix_eq_sum_family L
    _ = ∑ α : OrbitPermFamily L,
          ∏ O : OrbitIndex L,
            orbitFactor L (charMatrix L (shiftMatrix L)) O.1 (ambientOf O.1 (α O)) := by
        simp only [Finset.attach_eq_univ]
    _ = ∏ O : OrbitIndex L, ∑ ψ : OrbitBij O.1,
          orbitFactor L (charMatrix L (shiftMatrix L)) O.1 (ambientOf O.1 ψ) :=
        (prod_sum_eq_sum_prod_orbitFamilyAll
          (fun O ψ => orbitFactor L (charMatrix L (shiftMatrix L)) O.1 (ambientOf O.1 ψ))).symm

end Ising2DLambda.AlgebraicEigenvalue
