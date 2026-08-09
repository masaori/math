/-
主張「ι∘κ は有限積を有限積へ写す」「有限積は軌道ごとの積の積である」
「軌道を保つ置換の項は軌道ごとの因子の積である」の必要十分版。

具体版（`Ising2DLambda.AlgebraicEigenvalue.OrbitTermFactorization`）の証明が実際に
使っているのは次だけである。証明手順は具体版と同じ。

  使っている性質                                      どこで
  値の側が可換モノイドであること                        3 つの主張すべて
  写像が単位元と積を保つこと                            ι∘κ の段（環であることは使わない）
  族が互いに素で、その合併が全体であること               積を軌道ごとに分ける段
  「符号の積」「積の積」の 2 つの分解が与えられていること 項の分解の段

削れなかった仮定と、その理由。

1. `h1 : h 1 = 1` と `hmul : ∀ a b, h (a * b) = h a * h b`。人手証明が κ と ι について
   定義の中で述べているものそのものである。**加法を保つことは使わない**（人手証明の
   この段に和が一度も現れない）。したがって κ と ι が環準同型であることは要らない。
2. `hdisj`（互いに素）と `hunion`（合併が全体）。分割の 3 条件のうち
   **「どの元も空でない」は使っていない**（空の元があっても積は 1 になるだけで等式は保たれる）。
3. 項の分解では、符号の分解と積の分解を**仮定として受ける**。すなわちこの段が使うのは
   可換モノイドの分配（`Finset.prod_mul_distrib`）だけであり、
   符号であることも軌道であることも順序 `≺` があることも使わない。

具体版との差で言えば、次はいずれも使っていない。

* 値の側が環であること・多項式であること・零元があること。可換モノイドで足りる。
* 族の元が軌道であること・巡回シフトがあること・置換であること。
* 順序 `≺`（人手証明では符号を作る側にしか現れず、この段には入ってこない）。

住処: ここに ℝ / ℂ は現れない（値は一般の可換モノイド、添字は有限集合）。
-/
import Mathlib.Algebra.BigOperators.Group.Finset.Basic

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Finset

variable {α β M N : Type*} [CommMonoid M] [CommMonoid N]

/-- 人手証明の主張「ι∘κ は有限積を有限積へ写す」の必要十分版。

写像に要求するのは単位元と積を保つことだけである（加法は使わない）。 -/
theorem map_prod_of_mul [DecidableEq β] (h : M → N) (h1 : h 1 = 1)
    (hmul : ∀ a b : M, h (a * b) = h a * h b) (s : Finset β) (f : β → M) :
    h (∏ i ∈ s, f i) = ∏ i ∈ s, h (f i) := by
  induction s using Finset.cons_induction with
  | empty => rw [Finset.prod_empty, Finset.prod_empty, h1]
  | cons a s ha ih => rw [Finset.prod_cons, Finset.prod_cons, hmul, ih]

/-- 人手証明の主張「有限積は軌道ごとの積の積である」の必要十分版。

要求するのは族が互いに素であることと、その合併が全体であることだけである
（族の元が空でないことも、族の元が軌道であることも使わない）。 -/
theorem prod_eq_prod_of_partition [Fintype α] [DecidableEq α] (s : Finset (Finset α))
    (hdisj : ∀ O₁ ∈ s, ∀ O₂ ∈ s, O₁ ≠ O₂ → Disjoint O₁ O₂)
    (hunion : s.biUnion id = (univ : Finset α)) (f : α → M) :
    ∏ a : α, f a = ∏ O ∈ s.attach, ∏ a ∈ O.1, f a := by
  classical
  have hpd : Set.PairwiseDisjoint (↑s) (id : Finset α → Finset α) := by
    intro O₁ h₁ O₂ h₂ hne
    exact hdisj O₁ (by simpa using h₁) O₂ (by simpa using h₂) hne
  calc ∏ a : α, f a
      = ∏ a ∈ s.biUnion id, f a := by rw [hunion]
    _ = ∏ O ∈ s, ∏ a ∈ id O, f a := Finset.prod_biUnion hpd
    _ = ∏ O ∈ s.attach, ∏ a ∈ O.1, f a := (Finset.prod_attach s (fun O => ∏ a ∈ O, f a)).symm

/-- 人手証明の主張「軌道を保つ置換の項は、軌道ごとの因子の積である」の必要十分版。

2 つの分解（係数の側と積の側）を仮定として受けると、あとは可換モノイドの
「2 つの有限積の積は成分ごとの積の有限積である」だけで閉じる。 -/
theorem mul_prod_eq_prod_mul_of_decomp [Fintype α] (s : Finset (Finset α)) (c : M)
    (cf : {O : Finset α // O ∈ s} → M) (f : α → M)
    (hc : c = ∏ O ∈ s.attach, cf O)
    (hf : ∏ a : α, f a = ∏ O ∈ s.attach, ∏ a ∈ O.1, f a) :
    c * ∏ a : α, f a = ∏ O ∈ s.attach, cf O * ∏ a ∈ O.1, f a := by
  calc c * ∏ a : α, f a
      = (∏ O ∈ s.attach, cf O) * ∏ a : α, f a := by rw [hc]
    _ = (∏ O ∈ s.attach, cf O) * ∏ O ∈ s.attach, ∏ a ∈ O.1, f a := by rw [hf]
    _ = ∏ O ∈ s.attach, cf O * ∏ a ∈ O.1, f a := (Finset.prod_mul_distrib).symm

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
