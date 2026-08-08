/-
主張「シフト行列の特性行列の成分は、列の添字が行の添字でもその像でもないとき零元である」
「行の添字にもその像にも当たらない値を取る置換の項は零元である」
「各行配位をそれ自身かその像へ送る置換は軌道を保つ」
「軌道を保つ置換は各軌道をそれ自身へ写す」の必要十分版。

具体版（`Ising2DLambda.AlgebraicEigenvalue.ShiftCharTerm`）の証明が実際に使っているのは
次だけである。証明手順は具体版と同じ（同じ場合分け・同じ因子の括り出し・同じ 2 段の包含と個数）。

  主張                          使っている性質
  charMatrix_eq_zero_of_ne      行列の成分が「像のときだけ 1、他は 0」であること。
                                値の側は可換半環でよい（引き算を使わない）。
  term_eq_zero_of_entry_zero    上に加えて「零元を因子に持つ有限積は零元」だけ。
                                符号にあたる重み w には**何も要求していない**
                                （±1 であることも乗法的であることも使わない）。
  orbitPreserving_of_fixed_or_map  反復の 0 回と 1 回の場合だけ。写像にも型にも何も要求しない。
  image_orbit_eq                写像が単射であること・型が有限で相等が判定できること・
                                点ごとの周期の存在（`orbit_eq_of_mem` を通して）。

削れなかった仮定と、その理由。

1. `Function.Injective f`（`image_orbit_eq` のみ）。像の個数が変わらないことに使う。
   人手証明が「φ は単射なので |φ(O)| = |O|」と書いている段にあたる。
   ここで単射なのは置換 φ の方であり（`Equiv.Perm` なので自動）、f の単射性は
   `orbit_eq_of_mem` へ渡すためではなく**使っていない**——実際この定理の仮定に f の
   単射性は無い。
2. 点ごとの周期の存在（`image_orbit_eq` のみ）。`orbit_eq_of_mem` が要求する。
3. `Fintype ι` と `DecidableEq ι`。軌道を `Finset` として書くために要る。
4. 値の側の `CommRing`（特性行列を扱う 2 定理のみ）。**証明が引き算を使うからではなく、
   特性行列の定義そのものが `-A_{i,j}` を含むからである**（人手証明が符号の反転を
   係数環の中で先に済ませる書き方を採っているため、引き算が現れるのはこの 1 か所だけで、
   証明の中には一度も現れない）。実際、項が消えることの本体
   `term_eq_zero_of_entry_zero` は可換半環のままで通り、そこには負号が無い。

mathlib の `Matrix.charpoly` / `Equiv.Perm.support` / 群作用の軌道の一般論は引いていない。

住処: ここに ℝ / ℂ は現れない（添字は一般の型、係数は一般の可換半環、回数は ℕ）。
-/
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.RowShiftOrbitPartition
import Mathlib.Algebra.Polynomial.Basic

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

section Semiring

variable {S : Type*} [CommSemiring S]

/-- 人手証明の主張「行の添字にもその像にも当たらない値を取る置換の項は零元である」の本体。

証明は人手証明どおり、有限積から 1 つの因子を括り出し、その因子が零元であることで結論する。
重み `w`（人手証明の `ι(κ(sgn φ))`）には**何も要求していない**。
値の側は可換半環でよく、負号は現れない。 -/
theorem term_eq_zero_of_entry_zero (B : ι → ι → Polynomial S) (w : Polynomial S)
    (φ : Equiv.Perm ι) {i₁ : ι} (h : B i₁ (φ i₁) = 0) :
    w * ∏ i : ι, B i (φ i) = 0 := by
  classical
  have hprod : ∏ i : ι, B i (φ i) = 0 :=
    Finset.prod_eq_zero (Finset.mem_univ i₁) h
  rw [hprod, mul_zero]

end Semiring

section Ring

variable {S : Type*} [CommRing S]

/-- 人手証明のシフト行列 `U`。像のときだけ単位元、他は零元。

`f : ι → ι` が人手証明の `S`（行配位の巡回シフト）にあたる。 -/
noncomputable def permMatrixOf (f : ι → ι) (i j : ι) : S :=
  open Classical in if j = f i then 1 else 0

/-- 人手証明の特性行列 `ch(A)`。符号の反転は係数環の中で済ませてある。 -/
noncomputable def charMatrixOf (A : ι → ι → S) (i j : ι) : Polynomial S :=
  open Classical in
  if i = j then Polynomial.X + Polynomial.C (-A i i) else Polynomial.C (-A i j)

/-- 人手証明の主張「特性行列の成分は、列の添字が行の添字でもその像でもないとき零元である」。

証明は人手証明どおり 3 段（`ch` の非対角の場合 → 行列の成分が零元 → 零元の逆元は零元）。
値の側に可換環を要求するのは**証明が引き算を使うからではなく、`charMatrixOf` の定義が
`-A i j` を含むからである**（この定理の言明自体が `charMatrixOf` を含むので、
仮定を可換半環まで弱めることはできない）。証明の中で負号に触れるのは最後の `-0 = 0` の
1 段だけで、これは加法の逆元の性質である。項が消えることの本体
`term_eq_zero_of_entry_zero` は負号を含まず、可換半環のままで通る。 -/
theorem charMatrix_eq_zero_of_ne (f : ι → ι) {i j : ι} (hij : j ≠ i) (hfj : j ≠ f i) :
    charMatrixOf (permMatrixOf (S := S) f) i j = 0 := by
  classical
  calc charMatrixOf (permMatrixOf (S := S) f) i j
      = Polynomial.C (-(permMatrixOf (S := S) f i j)) := by
        simp [charMatrixOf, (Ne.symm hij)]
    _ = Polynomial.C (-(0 : S)) := by simp [permMatrixOf, hfj]
    _ = 0 := by simp

/-- 人手証明の主張「行の添字にもその像にも当たらない値を取る置換の項は零元である」を、
シフト行列の特性行列について述べたもの。上の 2 つを繋いだだけである。 -/
theorem charTerm_eq_zero (f : ι → ι) (w : Polynomial S) (φ : Equiv.Perm ι) {i₁ : ι}
    (h₁ : φ i₁ ≠ i₁) (h₂ : φ i₁ ≠ f i₁) :
    w * ∏ i : ι, charMatrixOf (permMatrixOf (S := S) f) i (φ i) = 0 :=
  term_eq_zero_of_entry_zero _ w φ (charMatrix_eq_zero_of_ne f h₁ h₂)

end Ring

/-- 人手証明の軌道を保つ置換 `𝔖^𝒪_L`。 -/
def OrbitPreserving (f : ι → ι) (φ : Equiv.Perm ι) : Prop :=
  ∀ i : ι, φ i ∈ orbit f i

/-- 人手証明の主張「各行配位をそれ自身かその像へ送る置換は軌道を保つ」。

反復の 0 回と 1 回の場合を使うだけで、写像にも型にも何も要求しない。 -/
theorem orbitPreserving_of_fixed_or_map (f : ι → ι) (φ : Equiv.Perm ι)
    (h : ∀ i : ι, φ i = i ∨ φ i = f i) : OrbitPreserving f φ := by
  intro i
  rcases h i with hi | hi
  · -- φ(i) = i = f^[0](i)
    exact mem_orbit.mpr ⟨0, hi⟩
  · -- φ(i) = f(i) = f(f^[0](i)) = f^[1](i)
    exact mem_orbit.mpr ⟨1, hi⟩

/-- 人手証明の主張「軌道を保つ置換は各軌道をそれ自身へ写す」。

証明は人手証明どおり 2 段。まず `O(τ) = O` から包含 `φ(O) ⊆ O` を出し、
次に `φ` が単射なので個数が等しいことを使って等号にする。 -/
theorem image_orbit_eq (f : ι → ι) (h : ∀ i : ι, ∃ k, 1 ≤ k ∧ iterLeft f k i = i)
    {φ : Equiv.Perm ι} (hφ : OrbitPreserving f φ) (i₀ : ι) :
    (orbit f i₀).image φ = orbit f i₀ := by
  classical
  -- 第 1 段: 包含。i ∈ O(i₀) ならば O(i) = O(i₀) なので φ(i) ∈ O(i) = O(i₀)
  have hsub : (orbit f i₀).image φ ⊆ orbit f i₀ := by
    intro a ha
    obtain ⟨i, hi, rfl⟩ := Finset.mem_image.mp ha
    have hoi : orbit f i = orbit f i₀ := orbit_eq_of_mem f i₀ (h i₀) hi
    exact hoi ▸ hφ i
  -- 第 2 段: φ は単射なので個数が等しい
  have hcard : ((orbit f i₀).image φ).card = (orbit f i₀).card :=
    Finset.card_image_of_injective _ φ.injective
  exact Finset.eq_of_subset_of_card_le hsub (le_of_eq hcard.symm)

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
