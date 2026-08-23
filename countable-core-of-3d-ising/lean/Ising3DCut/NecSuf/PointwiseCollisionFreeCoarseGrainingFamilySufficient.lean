/-
「各箱で有限箱データを区別する粗視化の族は極限量に対して十分である」の Lean 必要十分版。

具体版（`LimitQuantity/PointwiseCollisionFreeCoarseGrainingFamilySufficient.lean`）は
サイト数と素指数データの組・正の有理数・分配多項式・実数乗根を使うが、証明が実際に使うのは
次だけである。

- 添字ごとに型が違ってよいデータ `D i` と粗視化 `τ i : D i → P i`。
- 粗視化の単射性は**現れるデータの上だけ**でよい（述語 `Good` で切る）。
  具体版は全域での単射性を仮定しているが、証明は二つの族の値にしか適用していない。
- データから観測値を取り出す写像 `obs i : D i → X`。
  具体版の「素指数データから有限箱の値を復元する」段はこの写像に吸収される。
- 添字の条件（具体版の $0<L$）は、フィルタ `F` に沿って**最終的に**成り立てば足りる。
- 極限の一致には位相空間の Hausdorff 性とフィルタが自明でないことだけが要る。
  実数・順序・距離は使わない。
-/
import Mathlib.Topology.Basic
import Mathlib.Order.Filter.AtTopBot.Defs
import Mathlib.Topology.Separation.Hausdorff

namespace Ising3DCut.NecSuf

open Filter Topology

variable {ι X : Type*} {D P : ι → Type*}

/-- 現れるデータの上で粗視化が単射なら、粗視化像が一致する添字ではデータ自身が一致する。 -/
theorem data_eq_of_pointwise_collision_free_coarse_graining
    (τ : ∀ i, D i → P i) (Good : ∀ i, D i → Prop)
    (hfree : ∀ i a b, Good i a → Good i b → τ i a = τ i b → a = b)
    (A B : ∀ i, D i) (hA : ∀ i, Good i (A i)) (hB : ∀ i, Good i (B i))
    {S : Set ι} (hagree : ∀ i ∈ S, τ i (A i) = τ i (B i)) :
    ∀ i ∈ S, A i = B i := by
  intro i hi
  exact hfree i (A i) (B i) (hA i) (hB i) (hagree i hi)

/-- 粗視化像がフィルタに沿って最終的に一致すれば、観測列も最終的に一致する。 -/
theorem observed_eventuallyEq_of_pointwise_collision_free_coarse_graining
    (τ : ∀ i, D i → P i) (Good : ∀ i, D i → Prop)
    (hfree : ∀ i a b, Good i a → Good i b → τ i a = τ i b → a = b)
    (A B : ∀ i, D i) (hA : ∀ i, Good i (A i)) (hB : ∀ i, Good i (B i))
    (obs : ∀ i, D i → X) (F : Filter ι)
    (hagree : ∀ᶠ i in F, τ i (A i) = τ i (B i)) :
    (fun i => obs i (A i)) =ᶠ[F] fun i => obs i (B i) := by
  filter_upwards [hagree] with i hi
  have hdata : A i = B i := hfree i (A i) (B i) (hA i) (hB i) hi
  rw [hdata]

/-- 十分性（存在）：観測列が最終的に一致するので、一方の収束は他方へ移る。 -/
theorem tendsto_of_pointwise_collision_free_coarse_graining [TopologicalSpace X]
    (τ : ∀ i, D i → P i) (Good : ∀ i, D i → Prop)
    (hfree : ∀ i a b, Good i a → Good i b → τ i a = τ i b → a = b)
    (A B : ∀ i, D i) (hA : ∀ i, Good i (A i)) (hB : ∀ i, Good i (B i))
    (obs : ∀ i, D i → X) (F : Filter ι)
    (hagree : ∀ᶠ i in F, τ i (A i) = τ i (B i))
    (x : X) (h : Tendsto (fun i => obs i (A i)) F (𝓝 x)) :
    Tendsto (fun i => obs i (B i)) F (𝓝 x) :=
  h.congr' (observed_eventuallyEq_of_pointwise_collision_free_coarse_graining
    τ Good hfree A B hA hB obs F hagree)

/-- 十分性（値の一致）：Hausdorff かつフィルタが自明でなければ、両者の極限量は一致する。 -/
theorem limit_eq_of_pointwise_collision_free_coarse_graining
    [TopologicalSpace X] [T2Space X]
    (τ : ∀ i, D i → P i) (Good : ∀ i, D i → Prop)
    (hfree : ∀ i a b, Good i a → Good i b → τ i a = τ i b → a = b)
    (A B : ∀ i, D i) (hA : ∀ i, Good i (A i)) (hB : ∀ i, Good i (B i))
    (obs : ∀ i, D i → X) (F : Filter ι) [F.NeBot]
    (hagree : ∀ᶠ i in F, τ i (A i) = τ i (B i))
    (x x' : X)
    (h : Tendsto (fun i => obs i (A i)) F (𝓝 x))
    (h' : Tendsto (fun i => obs i (B i)) F (𝓝 x')) : x = x' := by
  have hB' := tendsto_of_pointwise_collision_free_coarse_graining
    τ Good hfree A B hA hB obs F hagree x h
  exact tendsto_nhds_unique hB' h'

end Ising3DCut.NecSuf
