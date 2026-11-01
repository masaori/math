/-
# 必要十分版: 共役と指数級数の部分和の極限の交換

対応する人手証明のラベル: **`constant_c_value_even_sector`** の Step 2 の
`U exp(S) U^{-1} = exp(USU^{-1})`
（具体版は `Ising2D/EigenvalueProblem/EigenvaluesOfVPlus/ClaimSignFlipConjugation.lean` の
`Uflip_conj_pow`・`Uflip_conj_expPartialSum`・`Uflip_conj_matExp`、
系としての導出は `Ising2D/EigenvalueProblem/EigenvaluesOfVPlus/ClaimSignFlipConjugationFromNecSuf.lean`）

**このファイルには必要十分版だけを置く。必要十分版は Lean の中だけの道具であり、
人手証明の本文にも参照用ノートにも持ち込まない**
（`exact-solution-of-2d-ising-model/README.md` 4 節）。

## 証明手順（具体版と同じ）

1. `u s^k v = (u s v)^k`（`k` についての帰納法。`k = 0` は `uv = 1`、帰納段階は `vu = 1`）。
   具体版の `Uflip_conj_pow`。
2. 部分和の共役 `u (∑_{k<n} c_k s^k) v = ∑_{k<n} c_k (usv)^k`（分配法則とスカラー倍の交換、手順 1）。
   具体版の `Uflip_conj_expPartialSum`。
3. 部分和が `e` に収束するなら、その共役は `u e v` に収束する（`x ↦ u x v` の連続性）。
   具体版はこの連続性を `‖UXU^{-1} - UWU^{-1}‖ ≤ ‖U‖‖U^{-1}‖‖X-W‖`（`matrix_norm_submultiplicativity`）から出す。
4. 手順 2 で同じ列と分かった `∑_{k<n} c_k (usv)^k` が `e'` にも収束するなら、極限の一意性で `u e v = e'`。

## 何が効いているか / 効いていないか

- **効いている**: `u` の両側の逆 `v`（手順 1 の `k = 0` に `uv = 1`、帰納段階に `vu = 1`）、
  分配法則（手順 2。`𝔸` は半環でよく、引き算は使わない）、係数のスカラー倍が左右の積と交換すること
  （`IsScalarTower R 𝔸 𝔸`・`SMulCommClass R 𝔸 𝔸`）、`u, v` を固定した写像 `x ↦ u x v` の極限 `e` での連続性
  （手順 3。仮定 `hcont`。積が二つの引数について同時に連続であることまでは要らない）、
  極限の一意性（手順 4。`T2Space 𝔸`）。
- **効いていない**: 行列であること、ノルム（具体版がノルムを使うのは手順 3 の連続性を示すためだけである）、
  完備性と級数の収束の理由（部分和の極限 `e`・`e'` は仮定として受け取る。人手の `def_exp` と同じく部分和の極限であり、
  項の順序によらない和は要求しない）、係数が `(k!)^{-1}` であること（任意の係数列 `c : ℕ → R` で通る）、
  `R` が `ℂ` であること、和の連続性（手順 3 で連続性を当てるのは部分和の列そのものに対してである）。
- 片側の逆では足りない: `uv = 1` だけだと帰納段階が、`vu = 1` だけだと `k = 0` の項 `u s^0 v = uv` が `1` にならない
  （`NecSuf/Conjugation.lean` の `sandwich_mul_needs_left_inv`・`sandwich_one_needs_right_inv` と同じ理由）。
-/
import Mathlib.Topology.Separation.Hausdorff
import Mathlib.Topology.ContinuousOn
import Mathlib.Algebra.Module.Defs
import Mathlib.Algebra.BigOperators.Ring.Finset

namespace Ising2D.NecSuf

open Filter Topology

variable {𝔸 : Type*} [Semiring 𝔸]

/-- 手順 1: `u s^k v = (u s v)^k`。 -/
theorem conj_pow_of_inv {u v : 𝔸} (huv : u * v = 1) (hvu : v * u = 1) (s : 𝔸) (k : ℕ) :
    u * s ^ k * v = (u * s * v) ^ k := by
  induction k with
  | zero =>
    calc u * s ^ 0 * v = u * v := by rw [pow_zero, mul_one]
      _ = 1 := huv
      _ = (u * s * v) ^ 0 := (pow_zero _).symm
  | succ k ih =>
    calc u * s ^ (k + 1) * v
        = u * s ^ k * (v * u) * s * v := by rw [hvu, mul_one, pow_succ]; simp only [mul_assoc]
      _ = (u * s ^ k * v) * (u * s * v) := by simp only [mul_assoc]
      _ = (u * s * v) ^ k * (u * s * v) := by rw [ih]
      _ = (u * s * v) ^ (k + 1) := (pow_succ _ _).symm

variable {R : Type*} [SMul R 𝔸] [IsScalarTower R 𝔸 𝔸] [SMulCommClass R 𝔸 𝔸]

/-- 手順 2: 部分和の共役 `u (∑_{k<n} c_k s^k) v = ∑_{k<n} c_k (usv)^k`。 -/
theorem conj_partialSum_of_inv {u v : 𝔸} (huv : u * v = 1) (hvu : v * u = 1)
    (c : ℕ → R) (s : 𝔸) (n : ℕ) :
    u * (∑ k ∈ Finset.range n, c k • s ^ k) * v
      = ∑ k ∈ Finset.range n, c k • (u * s * v) ^ k := by
  calc u * (∑ k ∈ Finset.range n, c k • s ^ k) * v
      = ∑ k ∈ Finset.range n, u * (c k • s ^ k) * v := by rw [Finset.mul_sum, Finset.sum_mul]
    _ = ∑ k ∈ Finset.range n, c k • (u * s ^ k * v) := by
        simp only [mul_smul_comm, smul_mul_assoc]
    _ = ∑ k ∈ Finset.range n, c k • (u * s * v) ^ k := by
        simp only [conj_pow_of_inv huv hvu]

variable [TopologicalSpace 𝔸] [T2Space 𝔸]

/-- **共役と指数級数の部分和の極限の交換**: `uv = vu = 1`、`x ↦ uxv` が `e` で連続で、`∑_{k<n} c_k s^k → e`、
`∑_{k<n} c_k (usv)^k → e'` なら `u e v = e'`（手順 3・4）。 -/
theorem conj_series_limit_of_inv {u v : 𝔸} (huv : u * v = 1) (hvu : v * u = 1)
    (c : ℕ → R) (s e e' : 𝔸) (hcont : ContinuousAt (fun x => u * x * v) e)
    (he : Tendsto (fun n => ∑ k ∈ Finset.range n, c k • s ^ k) atTop (𝓝 e))
    (he' : Tendsto (fun n => ∑ k ∈ Finset.range n, c k • (u * s * v) ^ k) atTop (𝓝 e')) :
    u * e * v = e' := by
  -- 手順 3
  have hconj : Tendsto (fun n => u * (∑ k ∈ Finset.range n, c k • s ^ k) * v)
      atTop (𝓝 (u * e * v)) :=
    hcont.tendsto.comp he
  -- 手順 2 で書き換える
  have hconj' : Tendsto (fun n => ∑ k ∈ Finset.range n, c k • (u * s * v) ^ k)
      atTop (𝓝 (u * e * v)) := by
    simpa only [conj_partialSum_of_inv huv hvu] using hconj
  -- 手順 4
  exact tendsto_nhds_unique hconj' he'

end Ising2D.NecSuf
