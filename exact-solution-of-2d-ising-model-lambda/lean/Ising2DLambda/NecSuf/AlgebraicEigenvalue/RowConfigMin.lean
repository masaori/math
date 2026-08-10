/-
主張「行配位の空でない部分集合は最小元をちょうど 1 つ持つ」「相異なる軌道の最小元は相異なる」と
定義「行配位の空でない部分集合の最小元」の必要十分版。

具体版（`Ising2DLambda.AlgebraicEigenvalue.RowConfigMin`）の証明が実際に使っているのは
次だけである。証明手順は具体版と同じ（同じ帰納法、同じ場合分け、同じ背理法）。

  主張                          使っている性質
  existsUnique_min              存在: 相異なる 2 点が比較できること（`hcompare`）と推移律（`htrans`）。
                                一意性: 非対称性（`hasymm`）。
  ne_of_mem_of_mem_of_disjoint  2 つの集合が交わらないことだけ。

削れなかった仮定と、その理由。

1. `hcompare : ∀ a b, a ≠ b → lt a b ∨ lt b a`。元を 1 つ足す段で、新しい元と古い最小元の
   どちらが小さいかを決めるのに要る。**三分律の全体を要求してはいない**
   （「ちょうど 1 つ」のうち、相異なるなら少なくとも一方という側だけを使う）。
2. `htrans`。新しい元が古い最小元より小さいとき、それが古い集合のすべての元より小さいことを
   出す段に要る。**ここが前のいくつかのセクションとの違いである**（またがる転倒対の偶数性は
   三分律だけで通った。最小元の存在は推移律なしでは出ない）。
3. `hasymm : ∀ a b, lt a b → ¬ lt b a`。一意性だけに要る。存在の側では使っていないので、
   2 つの主張で仮定が違う（同じ節にまとめず、必要な方だけへ渡している）。

具体版との差で言えば、次はいずれも使っていない。

* 型の有限性（`Fintype ι`）。`X` が `Finset` であることだけで足りる。
* 行配位であること・巡回シフトがあること・軌道であること。
* `lt` が非反射的であること（`hasymm` から出るので別に仮定しない）。
* 後者の主張では、選んだ点が最小元であること・族 `𝒪` があること・順序 `lt` があること。
  交わらない 2 つの集合から取った 2 点である、ということしか使っていない。

mathlib の `Finset.min'` / `LinearOrder` のインスタンスは引いていない。
使ったのは `Finset.Nonempty.cons_induction` だけである。

住処: ここに ℝ / ℂ は現れない（元は一般の型、個数は ℕ）。
-/
import Mathlib.Data.Finset.Lattice.Fold
import Mathlib.Data.Finset.Card

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Finset

variable {ι : Type*} [DecidableEq ι]

/-- 人手証明の「`X` の最小元」の条件。 -/
def IsMin (lt : ι → ι → Prop) (X : Finset ι) (a : ι) : Prop :=
  a ∈ X ∧ ∀ b ∈ X, b = a ∨ lt a b

variable {lt : ι → ι → Prop}

/-- 人手証明の存在の段。要求するのは「相異なる 2 点が比較できること」と推移律だけである
（非対称性は使っていない。一意性の側でだけ要る）。 -/
theorem exists_min (hcompare : ∀ a b : ι, a ≠ b → lt a b ∨ lt b a)
    (htrans : ∀ {a b c : ι}, lt a b → lt b c → lt a c)
    {X : Finset ι} (hX : X.Nonempty) : ∃ a, IsMin lt X a := by
  classical
  induction hX using Finset.Nonempty.cons_induction with
  | singleton a =>
    -- |X| = 1 の場合。
    exact ⟨a, Finset.mem_singleton_self a, fun b hb => Or.inl (Finset.mem_singleton.mp hb)⟩
  | cons a Y ha _hY ih =>
    -- 元を 1 つ足す場合。古い最小元 a₂ と新しい元 a を比べる。
    obtain ⟨a₂, ha₂mem, ha₂min⟩ := ih
    have hne : a ≠ a₂ := fun h => ha (h ▸ ha₂mem)
    rcases hcompare a a₂ hne with h | h
    · -- a ≺ a₂ の場合: a が最小元である（ここで推移律を使う）。
      refine ⟨a, Finset.mem_cons_self a Y, ?_⟩
      intro b hb
      rcases Finset.mem_cons.mp hb with hb | hb
      · exact Or.inl hb
      · rcases ha₂min b hb with hb | hb
        · exact Or.inr (hb ▸ h)
        · exact Or.inr (htrans h hb)
    · -- a₂ ≺ a の場合: a₂ が最小元である。
      refine ⟨a₂, Finset.mem_cons_of_mem ha₂mem, ?_⟩
      intro b hb
      rcases Finset.mem_cons.mp hb with hb | hb
      · exact Or.inr (hb ▸ h)
      · exact ha₂min b hb

/-- 人手証明の一意性の段。要求するのは非対称性だけである。 -/
theorem min_unique (hasymm : ∀ {a b : ι}, lt a b → ¬ lt b a)
    {X : Finset ι} {a a' : ι} (ha : IsMin lt X a) (ha' : IsMin lt X a') : a = a' := by
  by_contra hne
  have h1 : lt a a' := (ha.2 a' ha'.1).resolve_left (Ne.symm hne)
  have h2 : lt a' a := (ha'.2 a ha.1).resolve_left hne
  exact hasymm h1 h2

/-- 人手証明の主張「空でない部分集合は最小元をちょうど 1 つ持つ」。 -/
theorem existsUnique_min (hcompare : ∀ a b : ι, a ≠ b → lt a b ∨ lt b a)
    (htrans : ∀ {a b c : ι}, lt a b → lt b c → lt a c)
    (hasymm : ∀ {a b : ι}, lt a b → ¬ lt b a)
    {X : Finset ι} (hX : X.Nonempty) : ∃! a, IsMin lt X a := by
  obtain ⟨a, ha⟩ := exists_min hcompare htrans hX
  exact ⟨a, ha, fun a' ha' => min_unique hasymm ha' ha⟩

/-- 人手証明の主張「相異なる軌道の最小元は相異なる」。

要求するのは「2 つの集合が交わらないこと」だけである。**最小元であることも、順序 `lt` が
あることも、族 `𝒪` を持ち出すことも使っていない**。すなわちこの主張は最小元の理論に属さず、
「交わらない 2 つの集合から取った 2 点は相異なる」という言明である。 -/
theorem ne_of_mem_of_mem_of_disjoint {O O' : Finset ι}
    (hdisj : ∀ a : ι, a ∈ O → a ∈ O' → False) {a a' : ι} (ha : a ∈ O) (ha' : a' ∈ O') :
    a ≠ a' := by
  intro hcon
  exact hdisj a ha (hcon ▸ ha')

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
