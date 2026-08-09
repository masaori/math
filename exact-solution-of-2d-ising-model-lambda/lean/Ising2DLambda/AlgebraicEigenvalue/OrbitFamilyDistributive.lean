/-
章「固有値の代数性」の主張「軌道の部分集合にわたる有限積の分配則」の具体版
（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts` の
`claim_orbit_family_distributive`。

  人手証明                                              このファイル
  𝔄(s) が有限（和の添字にできること）                   orbitPermFamilyOnFintype
  𝔄(∅) がちょうど 1 元であること                        orbitPermFamilyOnEmptyUnique
  一歩の 1 対 1 対応 ins / spl                          orbitInsertFamilyEquiv
  一歩の第 1・最後の等号（積から O₀ の因子を分ける）     prod_attach_orbitInsertFamily
  主張そのもの                                          prod_sum_eq_sum_prod_orbitFamily

和を `𝔄(s)` にわたって取るために `Fintype (OrbitPermFamilyOn s)` が要る。
`OrbitPermFamilyOn s = ∀ O, O ∈ s → 𝔅_O` は命題の上の依存関数型なので `Pi.fintype` が
直接は効かず、部分型の上の依存関数型との 1 対 1 対応を経由して移す。

積を `s.attach` にわたって書いているのは、組から値を取り出すのに所属の証明が要るためである。
人手証明の $\prod_{O\in s}g(O,\alpha(O))$ がこれに当たる。

mathlib の `Finset.prod_univ_sum` は引いていない（引くと人手証明の帰納法そのものが
既製の一般論へ置き換わり、1 対 1 対応の要件に反する）。使ったのは有限積・有限和の
基本補題（`Finset.prod_insert` / `Finset.attach_insert` / `Fintype.sum_mul_sum` /
`Equiv.sum_comp` / `Fintype.sum_prod_type`）だけである。

住処: 人手証明のこのブロックは ℤ を宣言している（値は ℤ[x][t] の元）。
ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.OrbitFamilyInsert
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Data.Fintype.BigOperators
import Mathlib.Data.Fintype.Prod
import Mathlib.Data.Fintype.Pi

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 組の全体と、部分型の上の依存関数型との 1 対 1 対応（有限性を移すための足場）。 -/
def orbitPermFamilyOnEquivSubtypePi (s : Finset (OrbitIndex L)) :
    OrbitPermFamilyOn s ≃ ∀ O : {X : OrbitIndex L // X ∈ s}, OrbitBij O.1.1 where
  toFun α := fun O => α O.1 O.2
  invFun f := fun O hO => f ⟨O, hO⟩
  left_inv _ := rfl
  right_inv _ := rfl

/-- 組の全体は有限型である（和の添字にできる）。 -/
noncomputable instance orbitPermFamilyOnFintype (s : Finset (OrbitIndex L)) :
    Fintype (OrbitPermFamilyOn s) := by
  classical
  exact Fintype.ofEquiv _ (orbitPermFamilyOnEquivSubtypePi s).symm

/-- 人手証明の出発点「`𝔄(∅)` はちょうど 1 元である」。 -/
instance orbitPermFamilyOnEmptyUnique :
    Unique (OrbitPermFamilyOn (∅ : Finset (OrbitIndex L))) where
  default := fun _ hO => absurd hO (Finset.notMem_empty _)
  uniq _ := funext fun _ => funext fun hO => absurd hO (Finset.notMem_empty _)

/-- 人手証明の一歩の 1 対 1 対応（`ins` と `spl` が互いに逆であること）を
和の添字の取り替えに使える形にしたもの。 -/
def orbitInsertFamilyEquiv {s : Finset (OrbitIndex L)} {O₀ : OrbitIndex L}
    (hO₀ : O₀ ∉ s) :
    OrbitBij O₀.1 × OrbitPermFamilyOn s ≃ OrbitPermFamilyOn (insert O₀ s) where
  toFun p := orbitInsertFamily O₀ p.1 p.2
  invFun β := orbitSplitFamily O₀ β
  left_inv p := by
    simpa using orbitFamilyInsert_leftInverse hO₀ p.1 p.2
  right_inv β := orbitFamilyInsert_rightInverse β

/-- 人手証明の一歩の第 1 の等号（と最後の等号）。

軌道を 1 つ足した組にわたる積は、足した軌道での値と、残りの組にわたる積の積である。 -/
theorem prod_attach_orbitInsertFamily {s : Finset (OrbitIndex L)} {O₀ : OrbitIndex L}
    (hO₀ : O₀ ∉ s) (g : (O : OrbitIndex L) → OrbitBij O.1 → SecondPoly)
    (ψ : OrbitBij O₀.1) (α : OrbitPermFamilyOn s) :
    (∏ O ∈ (insert O₀ s).attach, g O.1 (orbitInsertFamily O₀ ψ α O.1 O.2))
      = g O₀ ψ * ∏ O ∈ s.attach, g O.1 (α O.1 O.2) := by
  classical
  rw [Finset.attach_insert, Finset.prod_insert, Finset.prod_image]
  · congr 1
    · -- 足した軌道での値。`ins` の場合分けの前者。
      simp [orbitInsertFamily]
    · -- 残りの軌道での値。`O ∈ s` なら `O ≠ O₀`（`hO₀` による）ので後者。
      refine Finset.prod_congr rfl ?_
      rintro ⟨O, hO⟩ -
      have hne : O ≠ O₀ := fun h => hO₀ (h ▸ hO)
      simp [orbitInsertFamily, dif_neg hne]
  · -- 像を取る写像は単射である。
    rintro ⟨a, ha⟩ - ⟨b, hb⟩ - h
    have hab : a = b := congrArg Subtype.val h
    exact Subtype.ext hab
  · -- 足した軌道は像に入らない（`hO₀` による）。
    intro hmem
    rw [Finset.mem_image] at hmem
    obtain ⟨⟨a, ha⟩, -, h⟩ := hmem
    have haO : a = O₀ := congrArg Subtype.val h
    exact hO₀ (haO ▸ ha)

/-- 人手証明の主張「軌道の部分集合にわたる有限積の分配則」。

$s$ の元の個数についての帰納法。出発点は空集合（両辺とも空積・1 元の和で `1`）、
一歩は、積から `O₀` の因子を分けて帰納法の仮定を当て、分配則で 2 重の和にし、
積集合にわたる和へまとめ、`ins` と `spl` の 1 対 1 対応で和の添字を組へ取り替える。 -/
theorem prod_sum_eq_sum_prod_orbitFamily
    (g : (O : OrbitIndex L) → OrbitBij O.1 → SecondPoly) (s : Finset (OrbitIndex L)) :
    (∏ O ∈ s, ∑ ψ : OrbitBij O.1, g O ψ)
      = ∑ α : OrbitPermFamilyOn s, ∏ O ∈ s.attach, g O.1 (α O.1 O.2) := by
  classical
  induction s using Finset.induction_on with
  | empty =>
      -- 出発点。空集合にわたる積は 1、`𝔄(∅)` はちょうど 1 元。
      simp
  | insert O₀ s hO₀ ih =>
      rw [Finset.prod_insert hO₀, ih, Fintype.sum_mul_sum]
      rw [← Equiv.sum_comp (orbitInsertFamilyEquiv hO₀)]
      rw [Fintype.sum_prod_type]
      refine Finset.sum_congr rfl ?_
      rintro ψ -
      refine Finset.sum_congr rfl ?_
      rintro α -
      exact (prod_attach_orbitInsertFamily hO₀ g ψ α).symm

end Ising2DLambda.AlgebraicEigenvalue
